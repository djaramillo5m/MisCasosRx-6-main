//
//  Persistence.swift
//  MisCasosRx
//
//  Created by NamTrinh on 11/07/2024.
//

import CoreData
import SwiftUI

class PersistenceController: ObservableObject {
    static let shared = PersistenceController()
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "MisCasosRx")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/files/local.sql")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
