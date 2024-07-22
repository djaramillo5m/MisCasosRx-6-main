//
//  NavBar.swift
//  MisCasosRx
//
//  Created by Diego Jaramillo Hernández on 10/05/22.
//

import SwiftUI

struct NavBar : View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var index : String
    @Binding var menu : Bool
    @State var statistics : Bool = false

    var body: some View {

        HStack {
         
            (
                
                Text("Mis")
                    .font(.system(size: 32, weight: .black))
                    .foregroundColor(.black.opacity(0.8))
                
                +
                
                Text ("Casos")
                    .font(.system(size: 32, weight: .heavy))
                    .foregroundColor(.black.opacity(0.6))
                
                +
                
                Text ("Rx")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black.opacity(0.3))
                
                +
                
                Text ("®")
                    .font(.system(size: 31, weight: .light))
                    .foregroundColor(.black.opacity(0.1))
            
            )
            
            Spacer()
            
            if device == .pad {
                
                // MENÚ PARA IPAD:
                
                HStack (spacing: 25) {
                    
                    ButtonView(index: $index, menu: $menu, title: "Fluoro")
                    ButtonView(index: $index, menu: $menu, title: "CXR")
                    ButtonView(index: $index, menu: $menu, title: "US")
                    ButtonView(index: $index, menu: $menu, title: "CT")
                    ButtonView(index: $index, menu: $menu, title: "MG")
                    ButtonView(index: $index, menu: $menu, title: "MR")
                    ButtonView(index: $index, menu: $menu, title: "NM")
                    ButtonView(index: $index, menu: $menu, title: "MedDev")
                    ButtonView(index: $index, menu: $menu, title: "Nuevo")
                    
//                    Button {
//
//                    } label: {
//                        Image(systemName: "cart.badge.plus")
//                            .font(.title2.bold())
//                            .shadow(color: .black, radius: 2, x: 0, y: 0)
//                            .foregroundColor(.white)
//                            .background(Color.gray)
//                    }

                    
        
                }
                
            }else{
                
                // MENÚ PARA IPHONE:
                
                Button {
                    withAnimation {
                        statistics = true
                    }
                    
                } label: {
                    Image(systemName: "chart.xyaxis.line")
                        .font(.system(.title2).bold())
                        .foregroundColor(.white)
                }
                .fullScreenCover(isPresented: $statistics) {  
                    StatisticsView()
                }


                
                Button (action: {
                    withAnimation {
                        index = "Agregar"
                    }
                   
                    
                }){
                    Image(systemName: "plus")
                        .font(.system(.title2).bold())
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                    
                }
                
                Button (action: {
                    withAnimation{
                        menu.toggle()
                    }
                    
                }){
                    
                    Image(systemName: "filemenu.and.selection")
                        .font(.system(.title2).bold())
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                    
                }
            }
        }
        .padding(10)
        .background(Color.gray)

    }
}
