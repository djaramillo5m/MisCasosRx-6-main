//
//  Misc.swift
//  MisCasosRx
//
//  Created by Diego Jaramillo Hernández on 25/05/22.
//

import SwiftUI

struct Misc: View {
    
    @State var index = 0
    
    var body: some View {

        ScrollView (.vertical, showsIndicators: false, content: {
            
            VStack {
                
                HStack (spacing: 10) {
                    
                    (
                        
                        Text("Mis")
                            .fontWeight(.bold)
                            .foregroundColor(.black.opacity(0.9))
                        
                        +
                        
                        Text ("Casos")
                            .foregroundColor(.black.opacity(0.6))
                        
                        +
                        
                        Text ("Rx")
                            .foregroundColor(.black.opacity(0.3))
                            .fontWeight(.light)
                    
                    
                    ).font(.largeTitle)
                    
                    Spacer(minLength: 0)
                    
                }
                .padding()
                
                HStack {
                    
                    VStack(spacing: 0){
                        
                        Rectangle()
                        .fill(Color("Color"))
                        .frame(width: 80, height: 3)
                        .zIndex(1)
                        
                        
                        // Perfil:
                        
                        Image("profile")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                        .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                    }
                    
                    VStack(alignment: .leading, spacing: 8){
                        
                        Text("Una app diseñada y desarrollada por:")
                            .font(.subheadline)
                            .fontWeight(.light)
                            .foregroundColor(Color.black.opacity(0.8))
                        
                        Text("Diego Jaramillo Hernández")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color.black.opacity(0.8))
                        
                        Text("Médico,\nEspecialista en Radiología e Imágenes Diagnósticas.")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.7))
                        
                        Text("djaramillo5m@gmail.com")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    .padding(.leading, 20)
                    
                    Spacer(minLength: 0)
                }
                .padding(.horizontal, 20)
                
// TARJETAS.
                
// 1) NOVEDADES DARIEGOLOAPPS:
                
                Text("[ Lo nuevo en RadioTools Studio]")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(Color.black.opacity(0.5))
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                
                HStack {
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        
                        HStack (spacing: 20) {
                            
                            // PRIMERA TARJETA:
                            
                            VStack (alignment: .leading) {
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://www.linkedin.com/in/fares-cherni-034262225")!)
                                    
                                }){
                                    
                                    Image("fares")
                                    .resizable()
                                                                                                            
                                }

                                Text("Fares Cherni")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("fares.cherni.31@gmail.com\nDesarrollador de aplicaciones móviles. Miembro del equipo de desarrollo RadioTools DT. Contáctalo aquí.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)

                            
                            // SEGUNDA TARJETA:
                            
                            VStack (alignment: .leading) {
                                    
                                    Image("registrate")
                                    .resizable()

                                Text("Inicia sesión")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("Diligencia los campos y presiona en Registrarse, se enviará un correo electrónico de verificación con el que podrás continuar con el proceso de registro.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            // TERCERA TARJETA:
                            
                            VStack (alignment: .leading)  {
                                    
                                    Image("busqueda")
                                    .resizable()

                                Text("Múltiples herramientas")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("Tienes a tu disposición una barra de búsqueda, un botón de sincronización y la posibilidad de ordenar tus casos por fecha, título del caso o centro de origen del caso.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            // CUARTA TARJETA:
                            
                            VStack (alignment: .leading) {
                                    
                                    Image("agrega")
                                    .resizable()

                                Text("Agregar un caso")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("Agregar un caso es muy simple, completa los campos de identificación, selecciona la modalidad diagnóstica, selecciona una imagen de tu galería o toma una foto con tu celular y listo.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            
                            // QUINTA TARJETA:
                            
                            VStack (alignment: .leading) {
                                    
                                    Image("misc")
                                    .resizable()

                                Text("Información general")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("En la ventana de información general, encontrarás fechas de congresos, sitios de interés, publicación de resultados de admisión, contenido patrocinado y mucho mas.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            // SEXTA TARJETA:
                            
                            VStack (alignment: .leading) {
                                    
                                    Image("nuclear")
                                    .resizable()

                                Text("Medicina Nuclear")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("Encontraras un fichero en el que podrás almacenar tus tarjetas con los casos de interés en medicina nuclear, una funcionalidad útil para los aspirantes y espcialistas en el área de la imagen molecular. Que esperas para iniciar tu colección?.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            // OCTAVA TARJETA:
                            
                            VStack (alignment: .leading) {
                                    
                                    Image("dispositivos")
                                    .resizable()

                                Text("Medical Devices")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("Podrás almacenar tarjetas con imagenes de todos los dispositivos médicos que encuentres en tu práctica diaria, de esa forma podrás estudiarlos y compararlos con otros que encuentres.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                        }
                        
                        .padding(.bottom, 20)
                        .padding(.horizontal, 10)
                        
                    }
                    
                }
                
// 2) UTILIDADES PARA RESIDENTES Y ASPIRANTES:

                Text("[ Utilidades para residentes y aspirantes ]")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(Color.black.opacity(0.5))
                    .padding(.horizontal, 10)
                
                HStack {
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        
                        HStack (spacing: 20) {
                            
                            // PRIMERA TARJETA:
                            
                            VStack (alignment: .leading) {
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://radiopaedia.org")!)
                                    
                                }){
                                    
                                    Image("radiopaedia")
                                        .resizable()
                                                                                                            
                                }

                                Text("Radiopaedia®")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("Radiopaedia’s mission is to create the best radiology reference the world has ever seen and to make it available for free, for ever, for all.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            // SEGUNDA TARJETA:
                            
                            VStack (alignment: .leading) {
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://radiologyassistant.nl")!)
                                    
                                }){
                                    
                                    Image("radiologyassist")
                                        .resizable()
                                                                                                            
                                }

                                Text("Radiology Assistant®")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("The Radiology Assistant is an initiative of the Radiology Society of the Netherlands to provide up-to-date radiological education for radiology residents and radiologists.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            // TERCERA TARJETA:
                            
                            VStack (alignment: .leading) {
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://www.ohsu.edu/school-of-medicine/diagnostic-radiology/pediatric-radiology-normal-measurements")!)
                                    
                                }){
                                    
                                    Image("pediatricnormalmeasurements")
                                        .resizable()
                                                                                                            
                                }

                                Text("Pediatric Measurements®")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("It´s a tool which that includes selections of all major organ systems and all imaging modalities, compiled by pediatric radiologists from several hospitals in North America..")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            // CUARTA TARJETA:
                            
                            VStack (alignment: .leading) {
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://app.statdx.com")!)
                                    
                                }){
                                    
                                    Image("stat")
                                        .resizable()
                                                                                                            
                                }

                                Text("STATdx®")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("Elsevier’s STATdx® is a diagnostic decision support system for radiologists and gives a instant access to the collective clinical experience and knowledge of renowned sub-specialists in every field of radiology.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            // QUINTA TARJETA:
                            
                            VStack (alignment: .leading) {
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://app.statdx.com")!)
                                    
                                }){
                                    
                                    Image("radiographics")
                                        .resizable()
                                                                                                            
                                }

                                Text("Radiographics®")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("Get help with access to your individual or institutional RSNA Journals subscription, Radiology Legacy Collection, RadioGraphics Legacy Collection or Radiology Select.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            // SEXTA TARJETA:
                            
                            VStack (alignment: .leading) {
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://app.statdx.com")!)
                                    
                                }){
                                    
                                    Image("radiology")
                                        .resizable()
                                                                                                            
                                }

                                Text("Radiology®")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("Obtain formal permission to reuse figures, tables, or text from Radiology, RadioGraphics and other RSNA publications; order article reprints or e-prints.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)



                        }
                        
                        .padding(.bottom, 20)
                        .padding(.horizontal, 10)
                        
                    }
                    
                }
                
// 3) CONGRESOS Y REUNIONES:
                
                Text("[ Congresos y reuniones ]")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(Color.black.opacity(0.5))
                
                HStack {
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        
                        HStack (spacing: 20) {
                            
                            // PRIMERA TARJETA:
                            
                            VStack (alignment: .leading) {
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://www.educacionacr.org/CCR2022")!)
                                    
                                }){
                                    
                                    Image("ccr2022")
                                        .resizable()
                                                                                                            
                                }

                                Text("CCR 2022 - Cartagena")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("El CCR es el más importante evento de la especialidad en Colombia. Los crecientes niveles de participación internacional lo han posicionado como uno de los más destacados en Latinoamérica.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            // SEGUNDA TARJETA:
                            
                            VStack (alignment: .leading) {
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "http://ecr-congress.org/")!)
                                    
                                }){
                                    
                                    Image("ecr2022")
                                        .resizable()
                                                                                                            
                                }

                                Text("ECR 2022 - Viena")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("Our SMART congress will deliver an ECR experience like no other, with a highly multidisciplinary programme, exciting summer social events, and a buzzing industry exhibition.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            // TERCERA TARJETA:
                            
                            VStack (alignment: .leading) {
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://www.rsna.org")!)
                                    
                                }){
                                    
                                    Image("rsna2022")
                                        .resizable()
                                                                                                            
                                }

                                Text("RSNA 2022 - Chicago")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("Whether you join your friends and colleagues in Chicago or attend from home, RSNA 2022 is the global radiology forum where the power of imaging, education and collaboration come to life.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            // CUARTA TARJETA:
                            
                            VStack (alignment: .leading) {
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://www.tecnoimagen.com.ar/2021/oncologiapulmonar/#introduccion")!)
                                    
                                }){
                                    
                                    Image("cursoFaardit")
                                        .resizable()
                                                                                                            
                                }

                                Text("Curso FAARDIT")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("El Curso Virtual de Oncología Torácica es organizado por la Federación Argentina de Radiología, Diagnóstico por Imágenes y Terapia Radiante (FAARDIT) y cuenta con 33 charlas grabadas (on demand) y 4 clases interactivas en vivo.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)

                        }
                        
                        .padding(.bottom, 20)
                        .padding(.horizontal, 10)
                        
                    }
                    
                }

// 4) CONTENIDO PATROCINADO:
                
                Text("[ Contenido patrocinado ]")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(Color.black.opacity(0.5))
                
                HStack {
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        
                        HStack (spacing: 20) {
                            
                            // PRIMERA TARJETA:
                            
                            VStack (alignment: .leading) {
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://libreriadelmedico.com/")!)
                                    
                                }){
                                    
                                    Image("lm")
                                        .resizable()
                                                                                                            
                                }

                                Text("Librería del médico")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("(57) 3164367923 - (57) 3163067392.\nLibrería especializada en textos médicos, con mas de 20 años de trayectoria, domicilios a nivel nacional.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)

                            
                            // SEGUNDA TARJETA:
                            
                            VStack (alignment: .leading) {
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://libreriadelmedico.com/etiqueta-producto/novedad/")!)
                                    
                                }){
                                    
                                    Image("novedades")
                                        .resizable()
                                                                                                            
                                }

                                Text("Librería del médico")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("Novedades.\nExtenso catálogo con las últimas publicaciones en todas las áreas de la medicina y sus especialidades.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            // TERCERA TARJETA:
                            
                            VStack (alignment: .leading) {
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://libreriadelmedico.com/etiqueta-producto/ebooks/")!)
                                    
                                }){
                                    
                                    Image("ebooks")
                                        .resizable()
                                                                                                            
                                }

                                Text("Librería del médico")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("E-Books.\nConoce las versiones digitales originales de los títulos mas importantes a nivel mundial.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                            // CUARTA TARJETA:
                            
                            VStack (alignment: .leading) {
                                    
                                    Image("pauta")
                                        .resizable()

                                Text("Pauta en MisCasosRx App")
                                    .font(.system(size: 15, weight: .medium, design: .serif))
                                    .foregroundColor(Color.blue)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)

                                Text("djaramillo5m@gmail.com\nEscribenos y pauta con nosotros en la primera aplicación de casos clínicos interesantes para radiólogos.")
                                    .font(.caption2)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .fontWeight(.light)
                                    .lineLimit(4)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                
                            }
                            .frame(maxWidth: 230, maxHeight: 320)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 8, y: 8)
                            
                        }
                        
                        .padding(.bottom, 17)
                        .padding(.horizontal, 10)
                        
                    }
                }
            }
            
            Text("MisCasosRx\nTodos los derechos reservados\n©")
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.gray.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(.bottom, 5)
                .padding(.horizontal, 30)
            
            .background(Color("Color1").edgesIgnoringSafeArea(.all))
        
        })
        
        .background(Color("Color1").edgesIgnoringSafeArea(.all))
    }
}

