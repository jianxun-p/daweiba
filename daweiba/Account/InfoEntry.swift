//
//  InfoEntry.swift
//  daweiba
//
//  Created by 潘建勋 on 2024-07-30.
//

import Foundation
import SwiftData

@Model
final class InfoEntry: Identifiable, Hashable {
    
    let id: String
    
    var key: String = ""
    
    var value: String = ""
    
    init(id: String = Date().description, key: String = "", value: String = "") {
        self.id = id
        self.key = key
        self.value = value
    }
    
}


