//
//  ESXattrListEvent+CoreDataProperties.swift
//  SutroESFramework
//
//  Created by Brandon Dalton on 11/19/25.
//
//

import Foundation
import CoreData

extension ESXattrListEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ESXattrListEvent> {
        return NSFetchRequest<ESXattrListEvent>(entityName: "ESXattrListEvent")
    }

    @NSManaged public var id: UUID
    @NSManaged public var target: ESFile

}

extension ESXattrListEvent : Identifiable {

}
