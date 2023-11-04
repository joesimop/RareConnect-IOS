//
//  Item.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 11/4/23.
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
