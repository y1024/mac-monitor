//
//  ESXattrGetEvent+CoreDataProperties.swift
//  SutroESFramework
//
//  Created by Brandon Dalton on 11/17/25.
//
//

import Foundation
import CoreData


extension ESXattrGetEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ESXattrGetEvent> {
        return NSFetchRequest<ESXattrGetEvent>(entityName: "ESXattrGetEvent")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var extattr: String
    @NSManaged public var target: ESFile

}

extension ESXattrGetEvent : Identifiable {

}
