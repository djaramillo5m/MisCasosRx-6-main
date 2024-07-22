//
//  ListView.swift
//  MisCasosRx
//
//  Created by Diego Jaramillo Hernández on 11/05/22.
//

import SwiftUI

struct ListView: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Clinical.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Clinical.id, ascending: true)]) var clinicals: FetchedResults<Clinical>
    
    func getColumns() -> Int {
        return (device == .pad) ? 5 : ((device == .phone && width == .regular) ? 5 : 3)
        
    }
    var defecto : String
    
    @State var buscar : String = ""
    @State var selection: String = "título"
    @State private var first = false
    @State private var date: Date?
    @State private var down = true
    @State private var rotation : Int = 0
    @State private var showEditar = false
    @State private var refreshingID = UUID()
    
    @State private var selectedClinical: Clinical?
    
    @State private var filterData = [Clinical]()
    
    var onReload: ((String) -> Void)
    
    private var dataSuper: [Clinical] {
        switch defecto {
        case "Fluoro":
            return clinicals.filter { $0.defecto == "Fluoro" }
        case "CXR":
            return clinicals.filter { $0.defecto == "CXR" }
        case "US":
            return clinicals.filter { $0.defecto == "US" }
        case "CT":
            return clinicals.filter { $0.defecto == "CT" }
        case "MG":
            return clinicals.filter { $0.defecto == "MG" }
        case "MR":
            return clinicals.filter { $0.defecto == "MR" }
        case "NM":
            return clinicals.filter { $0.defecto == "NM" }
        case "MedDev":
            return clinicals.filter { $0.defecto == "MedDev" }
        default:
          return []
        }
    }
    
    var filterDataSuper: [Clinical] {
        var result: [Clinical] = dataSuper
        if !buscar.isEmpty {
            result = result.filter({
                if selection == "título" {
                    return  $0.titulo?.lowercased() ?? "" >= buscar.lowercased()
                }
                else  if selection == "centro" {
                    return  $0.centro?.lowercased() ?? "" >= buscar.lowercased()
                }
                return false
            })
            .sorted(by: { c1, c2 in
                if selection == "título"  {
                    return  c1.titulo?.lowercased() ?? "" < c2.titulo?.lowercased() ?? ""
                }
                else if selection == "centro" {
                    return  c1.centro?.lowercased() ?? "" < c2.centro?.lowercased() ?? ""
                }
                return false
            })
        }
        
        if let date = date {
            result = result
                .filter({
                    if down {
                        return getTime(time: $0.fecha ?? "") <= date
                    }
                    else {
                        return getTime(time: $0.fecha ?? "") >= date
                    }
                })
        }

        return result
    }
    
    var body: some View {
        
        Text("Tienes \(dataSuper.count) casos en tu lista de \(defecto)")
            .font(.footnote)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.gray)
            .padding(.horizontal, 5)
            .padding(.top, 2)
        
        HStack {
            
        TextField("Buscar un caso filtrado por:", text: $buscar)
                .foregroundColor(Color.theme.accent)
                .font(.system(size: 14, weight: .light))
            
            Picker("", selection: $selection) {
                ForEach(["título","centro"], id: \.self) {
                    Text($0)
                }
            }
            .accentColor(.blue)
        }
        .padding(3)
        .padding(.horizontal, 10)
        .background(Color.gray.opacity(0.3).cornerRadius(10))
        .padding(.horizontal, 6)
        
/*
        
        HStack {
            
            Spacer()
        
            HStack {
                Text("Mostrar casos a partir del:")
                    .foregroundColor(Color.theme.accent)
                    .font(.system(size: 14, weight: .light))

                Spacer()
                
                DatePickerInputView(date: $date, placeholder: "Elige la fecha")
                    .frame(width: 130, height: 28)
                    .padding(2)
                    .overlay {
                        HStack {
                            Spacer()
                            VStack {
                                if date != nil {
                                    Button {
                                        self.date = nil
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundStyle(.gray)
                                    }
                                    .offset(x: 3, y: -5)
                                }
                                
                                Spacer()
                            }
                        }
                    }
            }
            
            

        }
        .padding(.top, 5)
        .padding(.horizontal, 6.5)
        
        
*/
        
        
        ScrollView (.vertical, showsIndicators: false) {
            
            
/*            
 
            VStack {
                
                Text ("Con el apoyo de:")
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
            
*/
            
            LazyVGrid (columns: Array(repeating: GridItem(.flexible(), spacing: 7), count: getColumns()), spacing: 7) {
                ForEach(filterDataSuper, id : \.id) { item in
                    CardView(index: item, onDelete: deleteItem(item: ))
                        .tag(item.id)
                        .padding(.all)
                        .onTapGesture {
                            selectedClinical = item
                            withAnimation {
                                showEditar.toggle()
                            }
                        }
                }
            }
        }
        .sheet(isPresented: $showEditar, content: {
            EditarView(clinical: $selectedClinical)
        })
       
    }
    
    func deleteItem(item: Clinical) {
        withAnimation {
            viewContext.delete(item)
            
            for item in item.images {
                viewContext.delete(item)
            }
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
