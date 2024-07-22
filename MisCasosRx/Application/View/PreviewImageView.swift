//
//  PreviewImageView.swift
//  MisCasosRx
//
//  Created by NamTrinh on 15/07/2024.
//

import Foundation
import SwiftUI

struct PreviewImageView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0
    @Binding var img: UIImage?
    @Binding var imgs: [UIImage]
    
    var body: some View {
        VStack {
            header
            Spacer()
            ZoomableScrollView {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Spacer()
            
            arrayImagesView
        }
        .preferredColorScheme(.dark)
    }
}

extension PreviewImageView {
    var header: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.white)
                    .padding(.top, 20)
            }
            
            Spacer()
        }
        .frame(height: 30)
        .padding(.horizontal)
        .padding(.bottom, 16)
    }
    
    var arrayImagesView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                ForEach(0..<imgs.count, id: \.self) { i in
                    Image(uiImage: imgs[i])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 100)
                        .cornerRadius(8)
                        .onTapGesture {
                            img = imgs[i]
                        }
                }
            }
        }
        .scrollIndicators(.hidden)
        .frame(height: 120)
    }
}
