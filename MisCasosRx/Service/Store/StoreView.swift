//
//  StoreView.swift
//  MisCasosRx
//
//  Created by Fares Cherni on 08/06/2022.
//

import Foundation
import SwiftUI
import StoreKit

struct StoreView: View {
    @EnvironmentObject var store: Store
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        List {
           

          //  SubscriptionsView()

       Text("")

            // Restore Purchases
            
            Button("Restaurar las Compras", action: {
                Task {
                    //This call displays a system prompt that asks users to authenticate with their App Store credentials.
                    //Call this function only in response to an explicit user action, such as tapping a button.
                    try? await AppStore.sync()
                }
            })

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
            .padding(.leading,6.6)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
        )
        .navigationBarTitleDisplayMode(.inline)
//        .navigationTitle("Shop")
    }
}

