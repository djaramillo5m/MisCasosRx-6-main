//
//  DownloadingImageView.swift
//  MisCasosRx
//
//  Created by Fares Cherni on 04/06/2022.
//

import Foundation
import SwiftUI
import SkeletonUI
import SDWebImageSwiftUI


//struct DownloadingImageView<V>: View  where V: ViewModifier {
//    
//    let url : String
//    private let vm: V
//    init(url: String, key: String, vm: V) {
//        self.vm = vm
//        self.url = url
//    }
//    
//    var body: some View {
//
//        
//        WebImage(url: imageURL(url))
//           // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
//            
////           .onSuccess { image, data, cacheType in
////
//////           print(image)
//////            print(data)
//////               print(cacheType)
////           }
//           .resizable()
////           .placeholder {
////               Rectangle()
////                         
////                                     .skeleton(with:  true)
////                                     .shape(type: .rectangle)
////                                     .appearance(type: .gradient())
////                                     .animation(type: .linear())
////                                     .modifier(vm)
////           }
////           .transition(.fade(duration: 0.5)) // Fade Transition with duration
////           .modifier(vm)
//////           .onAppear {
//////               SDWebImageManager.defaultImageLoader  = StorageImageLoader.shared
//////                         //self.loadData()
//////           }
////        
////           .preferredColorScheme(.dark)
//    }
//
//}
//struct ImagePostModifier: ViewModifier {
//    
////    let width : CGFloat = 0
////    let height: CGFloat = 0
//    let resize : Bool 
//    
//    func body(content: Content) -> some View {
//        content
//           // .scaledToFit()
//            .if(!resize, transform: { view in
//                view
//                    .scaledToFit()
//                    .frame(width:  370, height: 370)
//                    .cornerRadius(10)
//            })
//            .if(resize, transform: { view in
//                view
//                    .scaledToFill()
//
//            })
//
//    }
//}
//
//
//
//extension View {
//    /// Applies the given transform if the given condition evaluates to `true`.
//    /// - Parameters:
//    ///   - condition: The condition to evaluate.
//    ///   - transform: The transform to apply to the source `View`.
//    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
//    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
//        if condition {
//            transform(self)
//            
//        } else {
//            
//            self
//            
//        }
//    }
//}
