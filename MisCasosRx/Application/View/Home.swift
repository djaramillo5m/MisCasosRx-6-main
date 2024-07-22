//
//  Home.swift
//  MisCasosRx
//
//  Created by Diego Jaramillo Hernández on 10/05/22.
//

import SwiftUI
import os.log
import CoreData

struct Home : View {
    @State private var index = "Fluoro"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Clinical.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Clinical.id, ascending: true)]) var clinical: FetchedResults<Clinical>
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    NavBar(index: $index, menu: $menu)

                    switch index {
                    case "Fluoro":
                        ListView(defecto: "Fluoro", onReload: onReload(defecto:))
                    case "CXR":
                        ListView(defecto: "CXR", onReload: onReload(defecto:))
                    case "US":
                        ListView(defecto: "US", onReload: onReload(defecto:))
                    case "CT":
                        ListView(defecto: "CT", onReload: onReload(defecto:))
                    case "MG":
                        ListView(defecto: "MG", onReload: onReload(defecto:))
                    case "MR":
                        ListView(defecto: "MR", onReload: onReload(defecto:))
                    case "NM":
                        ListView(defecto: "NM", onReload: onReload(defecto:))
                    case "MedDev":
                        ListView(defecto: "MedDev", onReload: onReload(defecto:))
                    default :
                        AddView(onAdded: onAdded)
                    }
                }
                .blur(radius: menu ? 20 : 0 )
                .disabled(menu)
                .id(clinical.count)
                
                // MENÚ DEL IPHONE:
                if menu {
                    menuView
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .onAppear(perform: {
                index = index
            })
        }
    }
    
    func onAdded() {
        index = "Fluoro"
    }
    
    func onReload(defecto: String) {
        index = defecto
    }
}

extension Home {
    var menuView: some View {
        HStack {
            Spacer ()
            VStack {
                HStack {
                    Spacer()
                    Button (action: {
                        withAnimation {
                            menu.toggle()
                        }
                    }){
                        Image(systemName: "xmark")
                            .font(.system(.title).bold())
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .padding(.top, 3)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            VStack (alignment: .trailing) {
                                VStack (alignment: .trailing) {
                                    ButtonView(index: $index, menu: $menu, title: "Fluoro")
                                        .shadow(color: .yellow, radius: 4, x: 0, y: 0)
                                    Text("Angiografía y Fluoroscopia")
                                        .font(.footnote)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.light)
                                        .padding(.bottom, 3)
                                    
                                    ButtonView(index: $index, menu: $menu, title: "CXR")
                                        .shadow(color: .yellow, radius: 4, x: 0, y: 0)
                                    Text("Radiología Convencional")
                                        .font(.footnote)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.light)
                                        .padding(.bottom, 3)
                                    
                                    ButtonView(index: $index, menu: $menu, title: "US")
                                        .shadow(color: .yellow, radius: 4, x: 0, y: 0)
                                    Text("Ultrasonido y Doppler")
                                        .font(.footnote)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.light)
                                        .padding(.bottom, 3)
                                    
                                    ButtonView(index: $index, menu: $menu, title: "CT")
                                        .shadow(color: .yellow, radius: 4, x: 0, y: 0)
                                    Text("Tomografía Computarizada")
                                        .font(.footnote)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.light)
                                        .padding(.bottom, 3)
                                    
                                }
                                .multilineTextAlignment(.trailing)
                                
                                VStack (alignment: .trailing) {
                                    
                                    ButtonView(index: $index, menu: $menu, title: "MG")
                                        .shadow(color: .yellow, radius: 4, x: 0, y: 0)
                                    Text("Mamografía y Tomosíntesis")
                                        .font(.footnote)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.light)
                                        .padding(.bottom, 3)
                                    
                                    ButtonView(index: $index, menu: $menu, title: "MR")
                                        .shadow(color: .yellow, radius: 4, x: 0, y: 0)
                                    Text("Resonancia Magnética")
                                        .font(.footnote)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.light)
                                        .padding(.bottom, 3)
                                    
                                    ButtonView(index: $index, menu: $menu, title: "NM")
                                        .shadow(color: .yellow, radius: 4, x: 0, y: 0)
                                    Text("Medicina Nuclear")
                                        .font(.footnote)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.light)
                                        .padding(.bottom, 3)
                                    
                                    ButtonView(index: $index, menu: $menu, title: "MedDev")
                                        .shadow(color: .yellow, radius: 4, x: 0, y: 0)
                                    Text("Dispositivos médicos")
                                        .font(.footnote)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.light)
                                        .padding(.bottom, 3)
                                    
                                }
                                
                                .padding(.bottom, 40)
                                
                            }
                            
                            .padding(.horizontal, 22)
                            
                        }
                        
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Spacer()
                        
                    }
                    
                    .padding(.top, 5)
                    .padding(.bottom, 90)
                    
                    VStack {
                        
                        Text("MisCasosRx\nUna app diseñada y desarrollada por:")
                            .font(.system(size: 9, weight: .semibold))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text("Diego Jaramillo Hernández")
                            .font(.system(size: 9, weight: .semibold))
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text("Médico Especialista en Radiología e Imágenes\nDiagnósticas\nBogotá D.C. Colombia")
                            .font(.system(size: 9, weight: .light))
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text("djaramillo5m@gmail.com")
                            .font(.system(size: 9, weight: .light))
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                        

                    }
                    
                    .padding(.bottom, 40)
                    
                    VStack {

                        
                        Text("Todos los derechos reservados")
                            .font(.system(size: 9, weight: .light))
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                             
                        Text("®")
                            .font(.system(size: 8, weight: .light))
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)

                    }
                }
                
                
//                .multilineTextAlignment(.center)
//                .frame(maxWidth: .infinity, alignment: .center)
//                .padding(5)
//                .background(Color.black.opacity(0.7))
//                .cornerRadius(10)
//                .padding(.top, 5)
//                .padding(.trailing, 10)
//                .padding(.leading, 16)
//                .padding(.bottom, 10)
            }
            .frame(width: widthMenu - 150)
            .background(Color.black.opacity(0.8))
            
        }
        
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
        .zIndex(menu ? 2 : 0 )
    }
}
