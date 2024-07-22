//
//  ImagenFirebase.swift
//  MisCasosRx
//
//  Created by Diego Jaramillo Hernández on 11/05/22.
//

//import SwiftUI
//
//struct ImagenFirebase: View {
//    
//    let imagenAlternativa = UIImage(systemName: "photo")
//    
//    @ObservedObject var imageLoader : PortadaViewModel
//    
//    init (imageUrl: String) {
//        imageLoader = PortadaViewModel(imageUrl: imageUrl)
//        
//    }
//    
//    var image : UIImage? {
//        imageLoader.data.flatMap(UIImage.init)
//        
//    }
//    
//    var body: some View {
//        
//        Image(uiImage: image ?? imagenAlternativa!)
//            .resizable()
//            .scaledToFill()
//            .clipped()
//        
//    }
//}
