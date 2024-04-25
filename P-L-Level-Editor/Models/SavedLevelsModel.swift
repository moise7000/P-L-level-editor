//
//  SavedLevelsModel.swift
//  levelEditor
//
//  Created by ewan decima on 21/04/2024.
//


import Foundation
import SwiftData

@Model
final class SavedLevelsModel{
    var id: UUID
    var name: String
    var level: LevelGridForSwiftData
    
    init(name: String, level: LevelGridForSwiftData) {
        self.id = UUID()
        self.name = name
        self.level = level
    }
}
