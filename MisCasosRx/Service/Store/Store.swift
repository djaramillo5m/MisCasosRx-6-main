//
//  Store.swift
//  MisCasosRx
//
//  Created by Fares Cherni on 08/06/2022.
//

import Foundation
import StoreKit
import SwiftUI
import os.log

typealias Transaction = StoreKit.Transaction
typealias RenewalInfo = StoreKit.Product.SubscriptionInfo.RenewalInfo
typealias RenewalState = StoreKit.Product.SubscriptionInfo.RenewalState

public enum StoreError: Error {
    case failedVerification
}
public enum SubscriptionTier: Int, Comparable {
    case none = 0
    case premium = 1
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

class Store: ObservableObject {
    @Published private(set) var subscriptions: [Product]
    @Published private(set) var purchasedSubscriptions: [Product] = []
    @Published private(set) var subscriptionGroupStatus: RenewalState?
    
    @Published private(set) var entryFetchIsDone: Bool = false
    
    var updateListenerTask: Task<Void, Error>? = nil

    private let productIdToEmoji: [String: String]
    private let logger = Logger(subsystem: "com.MisCasosRxN.logging.Medical", category: "Store")
    init() {
        if let path = Bundle.main.path(forResource: "Products", ofType: "plist"),
        let plist = FileManager.default.contents(atPath: path) {
            productIdToEmoji = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String: String]) ?? [:]
        } else {
            productIdToEmoji = [:]
        }
        subscriptions = []
        updateListenerTask = listenForTransactions()

        Task {
            await requestProducts()
            await updateCustomerProductStatus()
            withAnimation{
            entryFetchIsDone = true
            }
        }
    }

    deinit {
        updateListenerTask?.cancel()
    }

    
    func getNumberOfPurchasedImages( )->Int {
        var  result = 0
         for item in purchasedSubscriptions {
             result += getImagesCountFromProduct(product: item)
         }
        return result
    }
    
    func getImagesCountFromProduct(product : Product)->Int{
        switch product.id {
        case  "fuel.MisCasosRx.500": return 500
        case  "fuel.MisCasosRx.1000": return 1000
        case  "fuel.MisCasosRx.2000": return 2000
        case  "fuel.MisCasosRx.5000": return 5000
        case  "subscription.premium.MisCasos" : return 300
        default : return 0
        }
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    await self.updateCustomerProductStatus()
                    await transaction.finish()
                } catch {
                    self.logger.info("[\(loggingDateFormatter.string(from: Date()))] Transaction failed verification")
                }
            }
        }
    }

    @MainActor
    func requestProducts() async {
        do {
            let storeProducts = try await Product.products(for: productIdToEmoji.keys)
            var newCars: [Product] = []
            var newSubscriptions: [Product] = []
            var newNonRenewables: [Product] = []
            var newFuel: [Product] = []

            //Filter the products into categories based on their type.
            for product in storeProducts {
                switch product.type {
                case .consumable:
                    newFuel.append(product)
                case .nonConsumable:
                    newCars.append(product)
                case .autoRenewable:
                    newSubscriptions.append(product)
                case .nonRenewable:
                    newNonRenewables.append(product)
                default:
                    self.logger.info("[\(loggingDateFormatter.string(from: Date()))] Unknown product")
                }
            }

            //Sort each product category by price, lowest to highest, to update the store.
            subscriptions = sortByPrice(newSubscriptions)
            self.logger.info("[\(loggingDateFormatter.string(from: Date()))] the subscriptions \(self.subscriptions)")
        } catch(let error) {
            self.logger.info("[\(loggingDateFormatter.string(from: Date()))] Failed product request from the App Store server: \(error.localizedDescription)")
        }
    }

    func purchase(_ product: Product) async throws -> Transaction? {
        //Begin purchasing the `Product` the user selects.
        let result = try await product.purchase()

        switch result {
        case .success(let verification):
            //Check whether the transaction is verified. If it isn't,
            //this function rethrows the verification error.
            let transaction = try checkVerified(verification)
            await updateCustomerProductStatus()

            //Always finish a transaction.
            await transaction.finish()

            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }

    func isPurchased(_ product: Product) async throws -> Bool {
        //Determine whether the user purchases a given product.
        switch product.type {
        case .nonRenewable:
            return false  // purchasedNonRenewableSubscriptions.contains(product)
        case .nonConsumable:
            return false // purchasedCars.contains(product)
        case .autoRenewable:
           // print(product)
            return purchasedSubscriptions.contains(product)
        default:
            return false
        }
    }

    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        //Check whether the JWS passes StoreKit verification.
        switch result {
        case .unverified:
            //StoreKit parses the JWS, but it fails verification.
            throw StoreError.failedVerification
        case .verified(let safe):
            //The result is verified. Return the unwrapped value.
            return safe
        }
    }

    @MainActor
    func updateCustomerProductStatus() async {
        var purchasedSubscriptions: [Product] = []

        //Iterate through all of the user's purchased products.
        
        for await result in Transaction.currentEntitlements {
            do {
                //Check whether the transaction is verified. If it isn’t, catch `failedVerification` error.
                let transaction = try checkVerified(result)

                //Check the `productType` of the transaction and get the corresponding product from the store.
                switch transaction.productType {
                case .nonConsumable:
                    break
                case .nonRenewable:
                    break
                case .autoRenewable:
                    if let subscription = subscriptions.first(where: { $0.id == transaction.productID }) {
                        purchasedSubscriptions.append(subscription)
                    }
                default:
                    break
                }
            } catch {
                self.logger.info("[\(loggingDateFormatter.string(from: Date()))] Failed updateCustomerProductStatus: \(error.localizedDescription)")
            }
        }

        //Update the store information with the purchased products.


        //Update the store information with auto-renewable subscription products.
        self.purchasedSubscriptions = purchasedSubscriptions

        //Check the `subscriptionGroupStatus` to learn the auto-renewable subscription state to determine whether the customer
        //is new (never subscribed), active, or inactive (expired subscription). This app has only one subscription
        //group, so products in the subscriptions array all belong to the same group. The statuses that
        //`product.subscription.status` returns apply to the entire subscription group.
        subscriptionGroupStatus = try? await subscriptions.first?.subscription?.status.first?.state
    }

    func emoji(for productId: String) -> String {
        return productIdToEmoji[productId]!
    }

    func sortByPrice(_ products: [Product]) -> [Product] {
        products.sorted(by: { return $0.price < $1.price })
    }

    //Get a subscription's level of service using the product ID.
    func tier(for productId: String) -> SubscriptionTier {
        switch productId {
//        case "subscription.standard":
//            return .standard
        case "subscription.premium.MisCasos":
            return .premium
//        case "subscription.pro":
//            return .pro
        default:
            return .none
        }
    }
}
