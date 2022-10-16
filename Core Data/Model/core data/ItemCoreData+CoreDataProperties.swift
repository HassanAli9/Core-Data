//
//  ItemCoreData+CoreDataProperties.swift
//  Core Data
//
//  Created by Hassan on 20/05/2022.
//
//

import Foundation
import CoreData


extension ItemCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemCoreData> {
        return NSFetchRequest<ItemCoreData>(entityName: "ItemCoreData")
    }

    @NSManaged public var createdDate: String?
    @NSManaged public var details: String?
    @NSManaged public var image: Data?
    @NSManaged public var title: String?

}

extension ItemCoreData : Identifiable {

}
