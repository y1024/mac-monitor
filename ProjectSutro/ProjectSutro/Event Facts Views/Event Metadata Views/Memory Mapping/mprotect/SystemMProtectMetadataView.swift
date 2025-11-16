//
//  SystemMProtectMetadataView.swift
//  ProjectSutro
//
//  Created by Brandon Dalton on 11/14/25.
//

import SwiftUI
import SutroESFramework

struct SystemMProtectMetadataView: View {
    var esSystemEvent: ESMessage
    @State private var showAuditTokens: Bool = false
    
    private var event: ESMProtectEvent {
        esSystemEvent.event.mprotect!
    }
    
    private var protection: Int32 {
        event.protection
    }
    
    private var address: Int64 {
        event.address
    }
    
    private var size: Int64 {
        event.size
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // MARK: Event label
            IntelligentEventLabelView(message: esSystemEvent)
                .font(.title2)
            
            GroupBox {
                VStack(alignment: .leading) {
                    HStack {
                        Text("\u{2022} **Protection:**")
                        GroupBox {
                            Text("`\(protection)`")
                        }
                        
                        Text("\u{2022} **Address:**")
                        GroupBox {
                            Text("`\(String(address))`")
                        }
                        
                        Text("\u{2022} **Size:**")
                        GroupBox {
                            Text("`\(size)`")
                        }
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Divider()
            
            Label("**Context items**", systemImage: "folder.badge.plus").font(.title2).padding([.leading], 5.0)
            GroupBox {
                HStack {
                    Button("**Audit tokens**") {
                        showAuditTokens.toggle()
                    }
                }.frame(maxWidth: .infinity, alignment: .center).padding(.all)
            }
        }.sheet(isPresented: $showAuditTokens) {
            AuditTokenView(
                audit_token: esSystemEvent.process.audit_token_string,
                responsible_audit_token: esSystemEvent.process.responsible_audit_token_string,
                parent_audit_token: esSystemEvent.process.parent_audit_token_string
            )
            Button("**Dismiss**") {
                showAuditTokens.toggle()
            }.padding(.bottom)
        }
    }
}
