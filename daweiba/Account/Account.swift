//
//  Account.swift
//  daweiba
//
//  Created by 潘建勋 on 2024-07-27.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class Account: Identifiable {
    
    // URL, company name, organization, or etc...
    var title: String = ""
    
    var username: String = ""
    
    var password: String = ""
    
    var server: String = ""
        
    @Relationship(deleteRule: .cascade)
    var info: [InfoEntry] = [InfoEntry]()
    
//    var imgs: [Image] = [Image]()
    
    // description
    var descr: String = ""
    
    var lastUpdated: Date
    
    @Attribute(.unique) let id: Int
            
    init() {
        let creationDate = Date()
        self.lastUpdated = creationDate
        self.id = creationDate.hashValue
    }
            
}
