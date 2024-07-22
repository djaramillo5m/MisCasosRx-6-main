//
//  StatusInfoView.swift
//  MisCasosRx
//
//  Created by Fares Cherni on 08/06/2022.
//

import Foundation
import SwiftUI
import StoreKit

struct StatusInfoView: View {
    @EnvironmentObject var store: Store

    let product: Product
    let status: Product.SubscriptionInfo.Status

    var body: some View {
        Text(statusDescription())
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
    }

    //Build a string description of the subscription status to display to the user.
    fileprivate func statusDescription() -> String {
        guard case .verified(let renewalInfo) = status.renewalInfo,
              case .verified(let transaction) = status.transaction else {
            
            // The App Store could not verify your subscription status.
            
            return "AppStore no pudo verificar el estado de tu suscripción."
        }

        var description = ""

        switch status.state {
        case .subscribed:
            description = subscribedDescription()
        case .expired:
            if let expirationDate = transaction.expirationDate,
               let expirationReason = renewalInfo.expirationReason {
                description = expirationDescription(expirationReason, expirationDate: expirationDate)
            }
        case .revoked:
            if let revokedDate = transaction.revocationDate {
                
                // The App Store refunded your subscription to
                
                description = "AppStore reembolsó su suscripción a \(product.displayName) en \(revokedDate.formattedDate())."
            }
        case .inGracePeriod:
            description = gracePeriodDescription(renewalInfo)
        case .inBillingRetryPeriod:
            description = billingRetryDescription()
        default:
            break
        }

        if let expirationDate = transaction.expirationDate {
            description += renewalDescription(renewalInfo, expirationDate)
        }
        return description
    }

    fileprivate func billingRetryDescription() -> String {
        
        // The App Store could not confirm your billing information for...
        
        var description = "AppStore no pudo confirmar su información de facturación para \(product.displayName)."
        
        // Please verify your billing information to resume service.
        
        description += " Por favor, verifique su información de facturación para reanudar el servicio."
        return description
    }

    fileprivate func gracePeriodDescription(_ renewalInfo: RenewalInfo) -> String {
        
        // The App Store could not confirm your billing information for...
        
        var description = "AppStore no pudo confirmar su información de facturación para \(product.displayName)."
        if let untilDate = renewalInfo.gracePeriodExpirationDate {
            
            // Please verify your billing information to continue service after...
            
            description += " Verifique su información de facturación para continuar con el servicio despues de \(untilDate.formattedDate())"
        }

        return description
    }

    fileprivate func subscribedDescription() -> String {
        
        // You are currently subscribed to...
        
        return "Actualmente estás suscrito a \(product.displayName)."
    }

    fileprivate func renewalDescription(_ renewalInfo: RenewalInfo, _ expirationDate: Date) -> String {
        var description = ""

        if let newProductID = renewalInfo.autoRenewPreference {
            if let newProduct = store.subscriptions.first(where: { $0.id == newProductID }) {
                
                // Your subscription to...
                
                description += "\nTu suscripción a \(newProduct.displayName)"
                
                // will begin when your current subscription expires on
                
                description += " comenzará, cuando tu suscripción actual expire el \(expirationDate.formattedDate())."
            }
        } else if renewalInfo.willAutoRenew {
            
            // Next billing date:
            
            description += "\nPróxima fecha de facturación: \(expirationDate.formattedDate())."
        }

        return description
    }

    //Build a string description of the `expirationReason` to display to the user.
    fileprivate func expirationDescription(_ expirationReason: RenewalInfo.ExpirationReason, expirationDate: Date) -> String {
        var description = ""

        switch expirationReason {
        case .autoRenewDisabled:
            if expirationDate > Date() {
                
                // Your subscription to... will expire on...
                
                description += "Tu suscripción a \(product.displayName) caducará el \(expirationDate.formattedDate())."
            } else {
                description += "Tu suscripción a \(product.displayName) caducará el \(expirationDate.formattedDate())."
            }
            
        case .billingError:
            // Your subscription to... was not renewed due to a billing error.
            description = "Tu suscripción a \(product.displayName) no se renovó por un error de facturación."
        case .didNotConsentToPriceIncrease:
            // Your subscription to... was not renewed due to a price increase that you disapproved.
            description = "Tu suscripción a \(product.displayName) no se renovó debido a que el precio no fue aprobado por usted."
        case .productUnavailable:
            // Your subscription to... was not renewed because the product is no longer available.
            description = "Tu suscripción a \(product.displayName) no se renovó porque el producto ya no está disponible."
        default:
            // Your subscription to... was not renewed.
            description = "Tu suscripción a \(product.displayName) no se renovó."
        }

        return description
    }
}
extension Date {
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
}
