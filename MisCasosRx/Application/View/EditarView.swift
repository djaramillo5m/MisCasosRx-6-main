//
//  EditarView.swift
//  MisCasosRx
//
//  Created by Diego Jaramillo Hernández on 14/05/22.
//

import SwiftUI
import SDWebImageSwiftUI
import PhotosUI

struct EditarView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Binding var clinical: Clinical?
    @State var título = ""
    @State var centro = ""
    @State private var fecha: Date = Date()
    @State private var cedula = ""
    @State private var area = ""
    @State private var defecto = "CT"
    
    @State private var imageData = [ImageData]()
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [UIImage]()
    @State private var isShowCamera = false
    @State private var selectedCameraImage: UIImage?
    @State private var isShowImg = false
    @State private var selectedImage: UIImage?
    
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    @State private var isFirstAppear = true
    @State private var progress = false
    @State private var isShare = false
    @State var lastScaleValue: CGFloat = 1.0
    
    @State var scale: CGFloat = 1.0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView (.vertical, showsIndicators: false, content: {
                    VStack (alignment: .center) {
                        if let item = clinical {
                            EditarInfoView(defecto: $defecto, título: $título, centro: $centro, fecha: $fecha, cedula: $cedula, area: $area, clinical: item)
                        }
                        
                        if selectedImages.count != 0 {
                            selectionImageView
                            
                            SharingViewController(isPresenting: $isShare) {
                                let images: [UIImage] = selectedImages
                                let av = UIActivityViewController(activityItems: images, applicationActivities: nil)
                                av.completionWithItemsHandler = { _, _, _, _ in
                                    isShare = false // required for re-open !!!
                                }
                                return av
                            }
                        }
                        
                        
                        
                        
                        Button {
                            withAnimation {
                                isShare = true
                            }
                        } label: {
                            HStack {
                                Spacer()
                                Text("[ Comparte tu caso ]")
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 250)
                                    .padding(10)
                                    .background(Color("BotonFondo"))
                                    .cornerRadius(10)
                                    .padding(.bottom, 5)
                                Spacer()
                            }
                            .padding(.top, 8)

                        }
                        
                        
                        Button (action: {
                            mostrarMenu.toggle()
                            
                        }){
                            Text("Cargar una nueva imagen")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                                .foregroundColor(Color("BotonTexto"))
                                .padding(10)
                                .background(Color("BotonFondo"))
                                .cornerRadius(10)
                                .padding(.bottom, 5)
                            
                        }.actionSheet(isPresented: $mostrarMenu, content: {
                            ActionSheet(title: Text("Menú"), message: Text("Selecciona una opción"), buttons: [
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
                        
                        Button (action: {
                            updateClinical()
                        }){
                            Text("Editar")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                                .foregroundColor(Color("BotonTexto"))
                                .padding(10)
                                .background(Color("BotonFondo"))
                                .cornerRadius(10)
                                .padding(.bottom, 8)
                        }
                    }
                })
                .background(Color.theme.background)
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
        .photosPicker(isPresented: $imagePicker, selection: $selectedItems, maxSelectionCount: 10 - imageData.count, matching: .images)
        .onChange(of: selectedItems) { newValues in
            Task {
                selectedImages = imageData.map { return UIImage(data: $0.img ?? Data()) ?? UIImage() }
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
        .onAppear(perform: {
            if isFirstAppear {
                isFirstAppear = false
                imageData = clinical?.images ?? []
                título = clinical?.titulo ?? ""
                centro = clinical?.centro ?? ""
                fecha = getTime(time: clinical?.fecha ?? "")
                cedula = clinical?.cedula ?? ""
                area = clinical?.area ?? ""
                defecto = clinical?.defecto ?? ""
                selectedImages = imageData.map { return UIImage(data: $0.img ?? Data())! }
            }
            
        })
    }
    
    func updateClinical() {
        clinical?.titulo = título
        clinical?.centro = centro
        clinical?.fecha = String(describing: fecha.timeIntervalSince1970)
        clinical?.cedula = cedula
        clinical?.area = area
        clinical?.clinicalToImage = []
        clinical?.defecto = defecto
        for item in imageData {
            viewContext.delete(item)
        }
        
        for image in selectedImages {
            let data = image.jpegData(compressionQuality: 0.3)
            let id = UUID()
            let imageData = ImageData(context: viewContext)
            imageData.id = id
            imageData.img = data
            imageData.imageToClinical = clinical
        }
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
        withAnimation {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

extension EditarView {
    var selectionImageView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                ForEach(0..<selectedImages.count, id: \.self) { i in
                    Image(uiImage: selectedImages[i])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 160)
                        .cornerRadius(8)
                        .overlay {
                            VStack {
                                HStack {
                                    Spacer()
                                    Button {
                                        if i < imageData.count {
                                            imageData.remove(at: i)
                                        }
                                        selectedImages.remove(at: i)
                                    } label: {
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .frame(width: 16, height: 16)
                                            .foregroundStyle(.white)
                                            .shadow(color: Color.black, radius: 3, y: 0)
                                            .padding(.all, 7)
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
}


struct EditarInfoView: View {
    var modalidad = ["Fluoro", "CXR", "US", "CT", "MG", "MR", "NM", "MedDev"]
    
    @Binding var defecto: String
    @Binding var título: String
    @Binding var centro: String
    @Binding var fecha: Date
    @Binding var cedula: String
    @Binding var area: String
    @State private var isFirstAppear = true
    
    var clinical : Clinical
    
    var body: some View {
        VStack {
            Text("Edita un caso de tu colección")
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
            
            DatePicker("Fecha del caso:", selection: $fecha, displayedComponents: [.date])
                .font(.subheadline.bold())
                .foregroundColor(Color("BotonTexto"))
                .padding(3)
                .padding(.leading, 7)
                .padding(.top, 15)
                .padding(.horizontal, 20)
            
            defectoView
        }
        .background(Color.theme.background)
    }
}

extension EditarInfoView {
    var defectoView: some View {
        
        HStack {
            
            Text("Modalidad diagnóstica del caso:")
                .font(.subheadline.bold())
                .foregroundColor(Color("BotonTexto"))
                .padding(.leading, 7)
                        
            Picker("", selection: $defecto) {
                ForEach(modalidad, id: \.self) {
                    Text($0)
                }
                                
                
            }
            .background(Color("BotonFondo").opacity(0.9).cornerRadius(8))
            .tint(.white)
            .pickerStyle(.menu)
            
        }
        
        .padding(.bottom, 15)
        .padding(.top, 15)
        
    }
    
}

struct SharingViewController: UIViewControllerRepresentable {
    @Binding var isPresenting: Bool
    var content: () -> UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresenting {
            uiViewController.present(content(), animated: true, completion: nil)
        }
    }
}




struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    private var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        // set up the UIScrollView
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator  // for viewForZooming(in:)
        scrollView.maximumZoomScale = 20
        scrollView.minimumZoomScale = 1
        scrollView.bouncesZoom = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        // create a UIHostingController to hold our SwiftUI content
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        scrollView.addSubview(hostedView)
        
        return scrollView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: self.content))
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // update the hosting controller's SwiftUI content
        context.coordinator.hostingController.rootView = self.content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>
        
        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
    }
}


