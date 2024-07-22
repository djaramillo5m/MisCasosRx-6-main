//
//  ImageData+CoreDataProperties.swift
//  MisCasosRx
//
//  Created by NamTrinh on 17/07/2024.
//
//

import Foundation
import CoreData


extension ImageData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageData> {
        return NSFetchRequest<ImageData>(entityName: "ImageData")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var img: Data?
    @NSManaged public var imageToClinical: Clinical?

}

extension ImageData : Identifiable {

}
