//
//  SecondView.swift
//  MisCasosRx
//
//  Created by Fares Cherni on 08/06/2022.
//

import SwiftUI
import StoreKit

struct SecondView: View {
    @EnvironmentObject var store: Store
    @AppStorage("firstTime") var  firstTimeHere: Bool  = true
    @Environment(\.presentationMode) var presentationMode
    let iSInSideBar : Bool
    
    var body: some View {
        
        NavigationView {
            
        List {
            
            Group{
            Section("Navigation Service") {
                if  !store.purchasedSubscriptions.isEmpty {
                
                    ForEach(store.purchasedSubscriptions) { product in
//                        NavigationLink {
//                            ProductDetailView(product: product)
//                        } label: {
                            ListCellView(product: product, purchasingEnabled: false)
//                        }
                    }

                } else {
                    if let subscriptionGroupStatus = store.subscriptionGroupStatus {
                        if subscriptionGroupStatus == .expired || subscriptionGroupStatus == .revoked {
                            
                            // Welcome Back! \nHead over to the shop to get started!
                            
                            Text("Bienvenido de vuelta! \nDirígete a la tienda para comenzar!")
                            
                        } else if subscriptionGroupStatus == .inBillingRetryPeriod {
                            //The best practice for subscriptions in the billing retry state is to provide a deep link
                            //from your app to https://apps.apple.com/account/billing.
                            
                            // Please verify your billing details.
                            
                            Text("Por favor, verifica tus datos de facturación.")
                        }
                    } else {
                        
                        // You don't own any subscriptions. \nHead over to the shop to get started!
                        
                        Text("Actualmente no posees ninguna suscripción.\nDirígete a la tienda para comenzar!")
                    }
                }
            }
            }
            .listStyle(GroupedListStyle())
            
            
            NavigationLink {
                StoreView()
          
                
                
            } label: {
                
                Label("Shop", systemImage: "cart")
            }
            
            .foregroundColor(.white)
            .listRowBackground(Color.blue)
        }
            
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                
                    HStack{
            
                        Image("Back")
                        Text("Back")
                            .font(.custom("Nunito-Regular", size: 12))
                            .foregroundColor(Color("767676"))
                        Spacer()
                    }
                    .onTapGesture {
                        if iSInSideBar {
                            presentationMode.wrappedValue.dismiss()
                        }
                        else {
                            withAnimation {
                                firstTimeHere = false
                            }
                        }
                       
                       //
                    }
        )
        .navigationBarTitleDisplayMode(.inline)

        }
    }
}

