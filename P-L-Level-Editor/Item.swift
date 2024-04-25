//
//  Item.swift
//  P-L-Level-Editor
//
//  Created by ewan decima on 25/04/2024.
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
