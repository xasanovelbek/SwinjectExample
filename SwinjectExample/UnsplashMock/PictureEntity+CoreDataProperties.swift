//
//  PictureEntity+CoreDataProperties.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 12/01/22.
//
//

import Foundation
import CoreData


extension PictureEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PictureEntity> {
        return NSFetchRequest<PictureEntity>(entityName: "PictureEntity")
    }

    @NSManaged public var picture: Data?
    @NSManaged public var id: String?

}

extension PictureEntity : Identifiable {

}
