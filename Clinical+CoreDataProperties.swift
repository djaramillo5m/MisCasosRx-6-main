//
//  Clinical+CoreDataProperties.swift
//  MisCasosRx
//
//  Created by NamTrinh on 17/07/2024.
//
//

import Foundation
import CoreData


extension Clinical {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Clinical> {
        return NSFetchRequest<Clinical>(entityName: "Clinical")
    }

    @NSManaged public var area: String?
    @NSManaged public var cedula: String?
    @NSManaged public var centro: String?
    @NSManaged public var defecto: String?
    @NSManaged public var fecha: String?
    @NSManaged public var id: String?
    @NSManaged public var titulo: String?
    @NSManaged public var clinicalToImage: NSSet?

    public var images: [ImageData] {
        let set = clinicalToImage as? Set<ImageData> ?? []
        return set.sorted {
            $0.id?.uuidString ?? "" < $1.id?.uuidString ?? ""
        }
    }
}

// MARK: Generated accessors for clinicalToImage
extension Clinical {

    @objc(addClinicalToImageObject:)
    @NSManaged public func addToClinicalToImage(_ value: ImageData)

    @objc(removeClinicalToImageObject:)
    @NSManaged public func removeFromClinicalToImage(_ value: ImageData)

    @objc(addClinicalToImage:)
    @NSManaged public func addToClinicalToImage(_ values: NSSet)

    @objc(removeClinicalToImage:)
    @NSManaged public func removeFromClinicalToImage(_ values: NSSet)

}

extension Clinical : Identifiable {

}
