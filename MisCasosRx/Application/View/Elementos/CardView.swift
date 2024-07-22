//
//  CardView.swift
//  MisCasosRx
//
//  Created by Diego Jaramillo Hernández on 10/05/22.
//

import SwiftUI

struct CardView : View {
    var index : Clinical

    @State var carDelete : Bool = false
    
    var onDelete: ((Clinical) -> Void)
    
    var body: some View {
        Image(uiImage: UIImage(data: index.images.first?.img ?? Data()))
            .resizable()
            .scaledToFill()
            .overlay {
                VStack {
                    deleteButton
                    Spacer()
                    
                    VStack {
                        Text(index.titulo ?? "")
                            .font(.caption2)
                            .bold()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width / 3.5)
                            .padding(.top, 2)
                        
                        Text(index.centro ?? "")
                            .font(.caption2)
                            .foregroundColor(.yellow)
                            .multilineTextAlignment(.center)
                            .frame(width: UIScreen.main.bounds.width / 3.5)
                            .padding(.bottom, 3)

                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.black.opacity(0.4))
                    

                }
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, height: 170, alignment: .top)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(
            color: Color.black.opacity(0.5),
            radius: 5, x: 0, y: 0
                
        )
    }
}

extension CardView {
    var deleteButton: some View {
        Button (action: {
            carDelete = true
        }){
            Text("Eliminar")
                .font(.system(size: 10, weight: .light))
                .foregroundColor(.white)
                .padding(.vertical, 0.8)
                .padding(.horizontal, 6)
                .background(Color("ColorEliminar"))
                .clipShape(Capsule())
                .padding(.top, 4)
        }
        .alert(isPresented: $carDelete, content: {
            Alert(title: Text("Eliminar un registro de tu colección")
                .foregroundColor(Color.red),
                  message: Text("Recuerda: no podrás recuperar este registro a menos que vuelvas a agregarlo."),
                  primaryButton: .destructive(Text("Eliminar"), action: {
                onDelete(index)
            }),
                  secondaryButton: .default(Text("Cancelar")))
            
        })
    }
}
