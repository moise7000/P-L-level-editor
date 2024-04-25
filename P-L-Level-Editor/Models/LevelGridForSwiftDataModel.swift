//
//  LevelGridForSwiftDataModel.swift
//  levelEditor
//
//  Created by ewan decima on 21/04/2024.
//

import Foundation



   
struct LevelGridForSwiftData : Codable {
    var rows: Int
    var columns: Int
    var background: String?
    var name: String?
    var gridItems: [[LevelGridItem]]
}


func convertLevelGridForSwiftDataIntoForItem(_ level: LevelGridForSwiftData ) -> LevelGridForItem {
    var levelItem: LevelGridForItem = LevelGridForItem(rows: level.rows, columns: level.columns)
    levelItem.setName(name: level.name)
    levelItem.setBackground(background: level.background)
    levelItem.setGridItems(gridItems: level.gridItems)
    return levelItem

}
