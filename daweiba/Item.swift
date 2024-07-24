//
//  Item.swift
//  daweiba
//
//  Created by 潘建勋 on 2024-07-24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
