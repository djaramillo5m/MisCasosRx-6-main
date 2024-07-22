//
//  AddView.swift
//  MisCasosRx
//
//  Created by Diego Jaramillo Hernández on 11/05/22.
//

import SwiftUI
import StoreKit
import PhotosUI

struct AddView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var título = ""
    @State private var centro = ""
    @State private var fecha: Date = Date()
    @State private var cedula = ""
    @State private var area = ""
    
    var modalidad = ["Fluoro", "CXR", "US", "CT", "MG", "MR", "NM", "MedDev"]
    
    @State private var defecto = "CT"
    
    @State private var mostrarMenu = false
    @State private var imagePicker = false
   
    @State private var source : UIImagePickerController.SourceType = .camera
    
    @State private var progress = false

    @State var errorTitle = ""
    @State var isShowingError: Bool = false
    let itemPerRow: CGFloat = 3
    let horizontalSpacing: CGFloat = 8
    let height: CGFloat = 200
    
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [UIImage]()
    
    @State private var showVideoPicker = false
    
    @State private var isShowImg = false
    @State private var selectedImage: UIImage?
    
    @State private var isShowCamera = false
    @State private var selectedCameraImage: UIImage?
    
    var onAdded: (() -> Void)
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
                        VStack {
                            
                            Text("Agrega un nuevo caso")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color("BotonTexto"))
                                .padding(.top, 15)
                                .padding(.bottom, 10)
                            
                            
                            TextField("Nombre del caso", text: $título)
                                .font(.subheadline)
                                .disableAutocorrection(true)
                                .padding(7)
                                .padding(.leading, 5)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.theme.background)
                                        .shadow(
                                            color: Color.theme.accent.opacity(0.8),
                                            radius: 2, x: 0, y: 0
                                    )
                                )
                                .padding(.horizontal, 20)
                            
                            
                            TextField("Centro médico del caso", text: $centro)
                                .font(.subheadline)
                                .disableAutocorrection(true)
                                .padding(7)
                                .padding(.leading, 5)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.theme.background)
                                        .shadow(
                                            color: Color.theme.accent.opacity(0.8),
                                            radius: 2, x: 0, y: 0
                                    )
                                )
                                .padding(.top, 3)
                                .padding(.horizontal, 20)

                            TextField("Área del caso", text: $area)
                                .font(.subheadline)
                                .disableAutocorrection(true)
                                .padding(7)
                                .padding(.leading, 5)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.theme.background)
                                        .shadow(
                                            color: Color.theme.accent.opacity(0.8),
                                            radius: 2, x: 0, y: 0
                                    )
                                )
                                .padding(.top, 3)
                                .padding(.horizontal, 20)
                            
                            TextField("ID del caso", text: $cedula)
                                .font(.subheadline)
                                .disableAutocorrection(true)
                                .padding(7)
                                .padding(.leading, 5)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.theme.background)
                                        .shadow(
                                            color: Color.theme.accent.opacity(0.8),
                                            radius: 2, x: 0, y: 0
                                    )
                                )
                                .padding(.top, 3)
                                .padding(.horizontal, 20)
                            
                            }

                        defectoView
                        
                        DatePicker("Fecha del caso:", selection: $fecha, displayedComponents: [.date])
                            .font(.subheadline.bold())
                            .foregroundColor(Color("BotonTexto"))
                            .padding(3)
                            .padding(.leading, 7)
                            .padding(.horizontal, 20)
                        
                        if selectedImages.count > 0 {
                            selectionImageView
                        }
                        
                        Button (action: {
                            mostrarMenu.toggle()
                        }){
                            Text("Cargar una imagen")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                                .foregroundColor(Color("BotonTexto"))
                                .padding(10)
                                .background(Color("BotonFondo"))
                                .cornerRadius(10)
                                .padding(.top, 10)
                                .padding(.bottom, 8)
                            
                        }.actionSheet(isPresented: $mostrarMenu, content: {
                            ActionSheet(title: Text("Agrega una imagen a tu caso"), message: Text("Selecciona desde donde quieres importar la imagen, desde tu carrete o tomarla directamente con la cámara de tu teléfono"), buttons:  [
                                
                                .default(Text("Cámara"), action: {
                                    source = .camera
                                    isShowCamera.toggle()
                                }),
                                .default(Text("Galería"), action: {
                                    source = .photoLibrary
                                    imagePicker.toggle()
                                }),
                                .default(Text("Cancelar"))
                            ])
                        })
                        
                        saveButton
                    }
                })
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(.dark)
        .sheet(isPresented: $isShowCamera, content: {
            ImagePicker(show: $isShowCamera, image: $selectedCameraImage, source: source)
        })
        .fullScreenCover(isPresented: $isShowImg) {
            PreviewImageView(img: $selectedImage, imgs: $selectedImages)
        }
        .photosPicker(isPresented: $imagePicker, selection: $selectedItems, maxSelectionCount: 10, matching: .images)
        .onChange(of: selectedItems) { newValues in
            Task {
                selectedImages = []
                for value in newValues {
                    if let imgData = try? await value.loadTransferable(type: Data.self),
                       let image = UIImage(data: imgData) {
                        selectedImages.append(image)
                    }
                }
                if let image = selectedCameraImage {
                    selectedImages.append(image)
                }
            }
        }
        .onChange(of: selectedCameraImage) { newValue in
            if let image = newValue {
                selectedImages.append(image)
            }
        }
    }
}

extension AddView {
    var selectionImageView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                ForEach(0..<selectedImages.count, id: \.self) { i in
                    Image(uiImage: selectedImages[i])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 150)
                        .cornerRadius(8)
                        .overlay {
                            VStack {
                                HStack {
                                    Spacer()
                                    Button {
                                        selectedImages.remove(at: i)
                                        if selectedItems.count > i {
                                            selectedItems.remove(at: i)
                                        }
                                    } label: {
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .frame(width: 16, height: 16)
                                            .foregroundStyle(.white)
                                            .shadow(color: Color.black, radius: 3, y: 0)
                                            .padding(.all, 4)
                                    }
                                }
                                Spacer()
                            }
                        }
                        .onTapGesture {
                            selectedImage = selectedImages[i]
                            isShowImg.toggle()
                        }
                }
            }
        }
        .scrollIndicators(.hidden)
        .frame(height: 200)
    }
    
    var saveButton: some View {
        Button (action: {
            addClinical()
        }){
            Text("Guardar")
                .font(.subheadline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(width: 250)
                .foregroundColor(Color("BotonTexto"))
                .padding(10)
                .background(Color("BotonFondo"))
                .cornerRadius(10)
                .padding(.bottom, 10)
            
        }
        
    }
    
    var defectoView: some View {
        HStack {
            Text("Modalidad diagnóstica:")
                .font(.subheadline.bold())
                .foregroundColor(Color("BotonTexto"))
                .padding(.leading, 7)
                .padding(.top, 5)
            
            Picker("", selection: $defecto) {
                ForEach(modalidad, id: \.self) {
                    Text($0)
                }
                
            }
            .tint(.white)
            .pickerStyle(.menu)
        }
        .padding(.horizontal)
    }
    
    func addClinical() {
        withAnimation {
            let newClinical = Clinical(context: viewContext)
            newClinical.id = UUID().uuidString
            newClinical.titulo = título
            newClinical.centro = centro
            newClinical.fecha = String(describing: fecha.timeIntervalSince1970)
            newClinical.area = area
            newClinical.defecto = defecto
            newClinical.cedula = cedula
            
            for image in selectedImages {
                let data = image.jpegData(compressionQuality: 0.6)
                let id = UUID()
                let imageData = ImageData(context: viewContext)
                imageData.id = id
                imageData.img = data
                imageData.imageToClinical = newClinical
            }
            
            do {
                try viewContext.save()
                onAdded()
            } catch {
                print(error)
            }
        }
    }
}

#Preview(body: {
    AddView(onAdded: {
        
    })
})
