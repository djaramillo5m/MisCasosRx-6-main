//
//  ContentView.swift
//  MisCasosRx
//
//  Created by Diego Jaramillo Hernández on 10/05/22.
//

import SwiftUI
import StoreKit
import SDWebImageSwiftUI

struct ContentView: View {
   @AppStorage("IsLogin") var  isLogin: Bool  = false
   
    @State var syncronizeFetchForFirstRegister : Bool = false

    @AppStorage("AlreadyAUser") var AlreadyAUser: Bool = false
    @State var alertNotLinkedToYourAppleId: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Clinical.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Clinical.id, ascending: true)]) var clinical: FetchedResults<Clinical>
    
    var body: some View {
        Group {
            Home()
                .edgesIgnoringSafeArea(.all)
                .alert(isPresented: $alertNotLinkedToYourAppleId, content: {
                    Alert(title: Text("Tu cuenta no esta asociada con un Apple ID"), message: nil, dismissButton: .default(Text("Aceptar")))
                })
        }
    }
}
