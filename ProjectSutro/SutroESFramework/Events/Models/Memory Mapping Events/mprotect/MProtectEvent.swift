//
//  MProtectEvent.swift
//  ProjectSutro
//
//  Created by Brandon Dalton on 11/14/25.
//

import Foundation


private func decodeProtectionFlags(_ protection: Int32) -> [String] {
    guard protection != VM_PROT_NONE else { return ["VM_PROT_NONE"] }
    
    var flags: [String] = []
    /// `VM_PROT_DEFAULT = (VM_PROT_READ | VM_PROT_WRITE)` — it's a convenience constant
    // if protection & VM_PROT_DEFAULT != 0 { flags.append("VM_PROT_DEFAULT") }
    if protection & VM_PROT_NONE != 0 { flags.append("VM_PROT_NONE") }
    if protection & VM_PROT_READ != 0 { flags.append("VM_PROT_READ") }
    if protection & VM_PROT_WRITE != 0 { flags.append("VM_PROT_WRITE") }
    if protection & VM_PROT_EXECUTE != 0 { flags.append("VM_PROT_EXECUTE") }
    if protection & VM_PROT_RORW_TP != 0 { flags.append("VM_PROT_RORW_TP") }
    if protection & VM_PROT_NO_CHANGE_LEGACY != 0 { flags.append("VM_PROT_NO_CHANGE_LEGACY") }
    if protection & VM_PROT_NO_CHANGE != 0 { flags.append("VM_PROT_NO_CHANGE") }
    if protection & VM_PROT_COPY != 0 { flags.append("VM_PROT_COPY") }
    if protection & VM_PROT_WANTS_COPY != 0 { flags.append("VM_PROT_WANTS_COPY") }
    if protection & VM_PROT_IS_MASK != 0 { flags.append("VM_PROT_IS_MASK") }
    if protection & VM_PROT_STRIP_READ != 0 { flags.append("VM_PROT_STRIP_READ") }
    if protection & VM_PROT_EXECUTE_ONLY != 0 { flags.append("VM_PROT_EXECUTE_ONLY") }
    if protection & VM_PROT_TPRO != 0 { flags.append("VM_PROT_TPRO") }
    if protection & VM_PROT_ALLEXEC != 0 { flags.append("VM_PROT_ALLEXEC") }
    
    return flags
}


/// @brief Control protection of pages
/// A type for an event that indicates a change to protection of memory-mapped pages.
/// https://developer.apple.com/documentation/endpointsecurity/es_event_mprotect_t
public struct MProtectEvent: Identifiable, Codable, Hashable {
    public var id: UUID = UUID()
    
    public var protection: Int32
    public var address, size: Int64
    
    /// @note Mac Monitor enrichment
    public var hex_address: String
    public var kb_size: Int64
    public var flags: [String] = []
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: MProtectEvent, rhs: MProtectEvent) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(from rawMessage: UnsafePointer<es_message_t>) {
        let event: es_event_mprotect_t = rawMessage.pointee.event.mprotect
        
        self.protection = event.protection
        self.address = Int64(event.address)
        self.size = Int64(event.size)
        
        self.hex_address = ProcessHelpers
            .toHex(target: String(event.address))
        self.kb_size = Int64(ProcessHelpers
            .sizeFromHexNormalized(size: Double(event.size)))
        self.flags = decodeProtectionFlags(event.protection)
    }
}
