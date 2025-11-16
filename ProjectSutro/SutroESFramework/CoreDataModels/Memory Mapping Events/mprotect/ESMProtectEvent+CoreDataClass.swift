//
//  ESMProtectEvent+CoreDataClass.swift
//  SutroESFramework
//
//  Created by Brandon Dalton on 11/14/25.
//
//

import Foundation
import CoreData

@objc(ESMProtectEvent)
public class ESMProtectEvent: NSManagedObject {
    enum CodingKeys: CodingKey {
        case id
        case protection
        case address
        case size
        case hex_address
        case kb_size
        case flags
    }
    
    public var flags: [String] {
        get {
            return (try? JSONDecoder().decode([String].self, from: flagsData)) ?? []
        }
        set {
            flagsData = try! JSONEncoder().encode(newValue)
        }
    }
    
    // MARK: - Custom Core Data initilizer for ESMProtectEvent
    convenience init(from message: Message, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let event: MProtectEvent = message.event.mprotect!
        let description = NSEntityDescription.entity(forEntityName: "ESMProtectEvent", in: context)!
        self.init(entity: description, insertInto: context)
        self.id = event.id
        
        self.protection = event.protection
        self.address = event.address
        self.size = event.size
        
        self.hex_address = event.hex_address
        self.kb_size = event.kb_size
        self.flags = event.flags
    }
}

// MARK: - Encodable conformance
extension ESMProtectEvent: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(protection, forKey: .protection)
        try container.encode(address, forKey: .address)
        try container.encode(size, forKey: .size)
        
        try container.encode(hex_address, forKey: .hex_address)
        try container.encode(kb_size, forKey: .kb_size)
        try container.encode(flags, forKey: .flags)
    }
}
