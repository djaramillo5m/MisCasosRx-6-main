//
//  statisticsView.swift
//  MisCasosRx
//
//  Created by Fares Cherni on 14/06/2022.
//

import SwiftUI
import OrderedCollections

struct StatisticsView: View {
    @FetchRequest(entity: Clinical.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Clinical.id, ascending: true)]) var clinicals: FetchedResults<Clinical>
    
    @Environment(\.presentationMode) var presentationMode
    @State var statisticsValues : OrderedDictionary<String, Int>  = [:]
    
    var totalCases : Int {
        clinicals.count
    }
    
    var body: some View {
        let fluoto = clinicals.filter { $0.defecto == "Fluoro" }.count
        let cxr = clinicals.filter { $0.defecto == "CXR" }.count
        let us = clinicals.filter { $0.defecto == "US" }.count
        let ct = clinicals.filter { $0.defecto == "CT" }.count
        let mg = clinicals.filter { $0.defecto == "MG" }.count
        let mr = clinicals.filter { $0.defecto == "MR" }.count
        let nm = clinicals.filter { $0.defecto == "NM" }.count
        let medDev = clinicals.filter { $0.defecto == "MedDev" }.count
        
        
        VStack {
            
            HStack {
                
                (
                    
                    Text("Mis")
                        .font(.system(size: 35, weight: .black))
                        .foregroundColor(.white.opacity(0.9))
                    
                    +
                    
                    Text ("Estadísticas")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.white.opacity(0.6))

                    
                )
                
            }
                       
            
            Text("Actualmente tienes \(totalCases) casos en tu colección")
                .font(.caption)
                .foregroundColor(.white)
        }
        
        .padding()
        
        ScrollView(.vertical, showsIndicators: false) {
            
            HStack {
                StatisticsCardView(title: "Fluoroscopia y Angiografía", value: "\(String(describing: fluoto))", coefficient: 0.45, color: .purple,size: 35)
                StatisticsCardView(title: "Radiología Convencional", value: "\(String(describing: cxr))", coefficient: 0.45, color: .cyan,size: 35)
            }
            
            .padding(.top, 3)
            
            HStack {
                StatisticsCardView(title: "Ultrasonido y Doppler", value: "\(String(describing: us))", coefficient: 0.45, color: .yellow,size: 35)
                StatisticsCardView(title: "Tomografía Computarizada", value: "\(String(describing: ct))", coefficient: 0.45, color: .red,size: 35)
            }
            
            HStack {
                StatisticsCardView(title: "Mamografía y Tomosíntesis", value: "\(String(describing: mg))", coefficient: 0.45, color: .red,size: 35)
                StatisticsCardView(title: "Resonancia Magnética", value: "\(String(describing: mr))", coefficient: 0.45, color: .green,size: 35)
            }
            
            HStack {
                StatisticsCardView(title: "Medicina Nuclear", value: "\(String(describing: nm))", coefficient: 0.45, color: .green,size: 35)
                StatisticsCardView(title: "Dispositivos Médicos", value: "\(String(describing: medDev))", coefficient: 0.45, color: .orange,size: 35)
            }
            

/*
            VStack {
                
                Text ("No olvides visitar la página de nuestro patrocinador:")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.trailing)
                
                Button(action: {
                    UIApplication.shared.open(URL(string: "https://www.circlecvi.com/")!)
                    
                }){
                    
                    VStack {
                        
                        Image("Philips")
                            .resizable()
                            .scaledToFit()
                        
                    }
                    
                    .frame(maxWidth: 300, maxHeight: 80)
                    .cornerRadius(18)
 
                    
                }
                
            }
            
            .padding(.top, 20)
 
 */
            
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Pulsa aquí para regresar")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(5)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .background(Color("ColorAtras").opacity(0.5))
                        .cornerRadius(18)
                        .padding(.bottom, 8)
                }

            }
            
            .padding(.top, 5)
            
            VStack {
                
                Text("MisCasosRx - Una app diseñada y desarrollada por:")
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("Diego Jaramillo Hernández")
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("Médico Especialista en Radiología e Imágenes Diagnósticas\nBogotá D.C. Colombia")
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
            
            .padding(.top, 20)
            .padding(.bottom, 15)
            
            VStack {
                                
                Text("Agradecimiento especial a:\nTrinh Ngoc Nam - Lead iOS Developer")
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("Asesoría en la implementación del código")
                    .font(.system(size: 9, weight: .light))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("Hanoi, Vietnam")
                    .font(.system(size: 9, weight: .light))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("namtrinh99@gmail.com")
                    .font(.system(size: 9, weight: .light))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("\n\nTodos los derechos reservados")
                    .font(.system(size: 9, weight: .light))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                     
                Text("®")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                }
            
            .padding(.bottom, 10)
            
        }
        
    }
}


struct StatisticsCardView: View {
    let title : String
    let value : String
    let coefficient: Double
    let color : Color
    let size : Double
    
    var body: some View {
        VStack {
            Text(value)
                .font(.system(size: 65, weight: .bold))
                .foregroundColor(color).opacity(0.6)
            
            Text(title)
                .font(.caption2)
                .foregroundColor(Color.gray)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
        .frame(width: UIScreen.main.bounds.width * coefficient, height:  110)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.orange.opacity(0.6), lineWidth: 1))
        .padding(.bottom, 10)
    }
}
