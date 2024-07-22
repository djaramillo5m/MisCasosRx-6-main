//
//  ImagePicker.swift
//  MisCasosRx
//
//  Created by Diego Jaramillo Hernández on 11/05/22.
//

import SwiftUI
import Foundation

// ESTRUCTURA DE IMAGE PICKER UNIVERSAL (útil para reciclar)

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var show : Bool
    @Binding var image : UIImage?
    
    var source : UIImagePickerController.SourceType
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(conexion: self)
    }
    
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = source
        controller.delegate = context.coordinator
        controller.allowsEditing = true
        return controller
        }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
    
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var conexion : ImagePicker
        
        init (conexion: ImagePicker) {
            self.conexion = conexion
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("Se canceló")
            self.conexion.show.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.editedImage] as! UIImage
            self.conexion.image = image
            self.conexion.show.toggle()
        }
        
    }
    
}
