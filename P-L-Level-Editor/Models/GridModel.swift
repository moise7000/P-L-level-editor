//
//  GridView.swift
//  levelEditor
//
//  Created by ewan decima on 15/04/2024.
//

import Foundation
import AppKit
import UniformTypeIdentifiers
import SwiftData

struct LevelGrid {
    var rows: Int
    var columns: Int
    var images: [[URL?]]
    
}



class LevelGridForItem : Codable {
    var rows: Int
    var columns: Int
    var background: String?
    var name: String?
    var gridItems: [[LevelGridItem]]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.background = nil
        self.name = nil
        self.gridItems = createGridWithItemForClass(rows: self.rows, columns: self.columns)
        
    }
    
    func get(_ row: Int, _ column: Int) -> LevelGridItem {
        return gridItems[row][column]
    }
    
    
    func getName() -> String?{
        return self.name
    }
    
    func setName(name: String?) -> Void {
        self.name = name
        
    }
    
    func getBackground() -> String? {
        return self.background
    }
    
    func setBackground(background: String?) -> Void {
        self.background = background
    }
    
    func getGridItems() -> [[LevelGridItem]] {
        return self.gridItems
    }
    
    func setGridItems(gridItems: [[LevelGridItem]]) -> Void {
        self.gridItems = gridItems
    }
    
    func printItems() -> Void {
        for row in  0..<self.rows{
            for column in 0..<self.columns{
                if gridItems[row][column].assets != nil {
                    print(gridItems[row][column])
                }
            }
        }
    }
    
    func getImageName(_ row:Int, _ column:Int) -> String {
        return self.get(row, column).assets!.image
    }
    
    func getAsset(_ row: Int, _ column: Int) -> Assets? {
        return self.get(row, column).assets
    }
    
    func setAsset(_ row: Int, _ column: Int, asset: Assets) -> Void {
        self.gridItems[row][column].assets = asset
    }
    
    func getAssetType(_ row: Int, _ column: Int) -> AssetsType? {
        return self.gridItems[row][column].assets?.type
    }
    
    func setAssetType(_ row: Int, _ column: Int, assetType: AssetsType) -> Void {
        if self.gridItems[row][column].assets == nil {
            return
        } else {
            self.gridItems[row][column].assets?.type = assetType
        }
        
    }
    
    func isEmpty() -> Bool {
        for row in 0..<self.rows {
            for column in 0..<self.columns {
                if !isLevelGridItemEmpty(self.gridItems[row][column]){
                    return false
                }
            }

        }
        return true
    }
    
    func containsSomeAPT() -> Bool {
        for row in 0..<self.rows {
            for column in 0..<self.columns {
                if self.gridItems[row][column].allowPassTrough != nil  {
                    return true
                }
            }
        }
        return false
    }
    
    func containsTeleporter() -> Bool {
        for row in 0..<self.rows {
            for column in 0..<self.columns {
                if self.gridItems[row][column].teleportToScene != nil {
                    return false
                }
            }
        }
        return false
    }
    
    func eraze(_ row: Int, _ column: Int) -> Void {
        self.gridItems[row][column] = LevelGridItem(xPostion: column,
                                                    yPositon: row,
                                                    assets: nil,
                                                    showAllowPassTrough: false,
                                                    showLevelTeleporter: false)
    }
    
    func reset() -> Void {
        self.gridItems = createGridWithItemForClass(rows: self.rows, columns: self.columns)
    }
    
    func showAPT(_ row: Int, _ column: Int) -> Void {
        self.gridItems[row][column].showAllowPassTrough = true
    }
    
    func hideAPT(_ row: Int, _ column: Int) -> Void {
        self.gridItems[row][column].showAllowPassTrough = false
    }
    
    func showAllowPassThroughForAll() -> Void {
        for row in 0..<self.rows {
            for column in 0..<self.columns {
                self.showAPT(row, column)
            }
        }
    }
    
    func hideAllowPassThroughForAll() -> Void {
        for row in 0..<self.rows {
            for column in 0..<self.columns {
                self.hideAPT(row, column)
            }
        }
    }
    
    func getAPT(_ row: Int, _ column: Int) -> Int?{
        return self.gridItems[row][column].allowPassTrough
    }
    
    private func setAPT(_ row: Int, _ column: Int, apt: Int) -> Void {
        self.gridItems[row][column].allowPassTrough = apt
    }
    
    func setAllAPT(data: [[[DirectionAPT]]]) -> Void {
        for row in 0..<self.rows {
            for column in 0..<self.columns {
                self.gridItems[row][column].allowPassTrough = fromAPTToInt(from: data[row][column])
            }
        }
    }
    
    func getTeleporterToScene(_ row: Int, _ column: Int) -> String? {
        return self.gridItems[row][column].teleportToScene
    }
    
    func setTeleporterToScene(_ row: Int, _ column: Int, teleporterToScene: String) -> Void {
        self.gridItems[row][column].teleportToScene = teleporterToScene
    }
    
    func deleteTeleporterToScene(_ row: Int, _ column: Int) -> Void {
        self.gridItems[row][column].teleportToScene = nil
    }
    
    func getImageNamesGrid() -> [[String]] {
        return [[""]]
    }
    
    private func getItemByAssetsType(assetType: AssetsType) -> [LevelGridItem]{
        var out: [LevelGridItem] = []
        for row in self.gridItems {
            for item in row{
                if item.assets?.type == assetType {
                    out.append(item)
                }
            }
        }
        return out
    }
    
    private func getAllEntities() -> [LevelGridItem] {
        return getItemByAssetsType(assetType: AssetsType.ENTITY)
    }
    
    private func getAllStructure() -> [LevelGridItem] {
        return getItemByAssetsType(assetType: AssetsType.STRUCTURE)
    }

    func serializeForJSON() -> [String: Any] {
           var out: [String: Any] = [:]
       
           out["background"] = self.background ?? "default_background"
           out["name"] = self.name ?? "level_without_name_dumbass_" + UUID().uuidString
           out["structures"] = multipleSerializeSTRUCTUREForJSON(self.getAllStructure())
           out["entities"] = multipleSerializeENTITYForJSON(self.getAllEntities())
           return out
       }

    func exportJSON(url: URL) -> Bool {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self.serializeForJSON(), options: .prettyPrinted)
            try jsonData.write(to: url)
            print("JSON data was written to the file successfully.")
            return true
        } catch {
            return false
        }
        
    }
    
    func serializeForSwiftData() -> LevelGridForSwiftData {
        return LevelGridForSwiftData(rows: self.rows,
                                     columns: self.columns,
                                     background: self.background,
                                     name: self.name,
                                     gridItems: self.gridItems)
    }
    
   
    func save(modelContext: ModelContext) -> Void {
        
        //serialize
        let serializedLevel  = self.serializeForSwiftData()
        
        //Save the level in SwiftData
        modelContext.insert(SavedLevelsModel(name: self.name ?? "Undefined",
                                             level: serializedLevel))
        
        print("[v] SUCCESS : Level stored in SwiftData")
        
    }
    
}












func showSavePanel() -> URL? {
    let savePanel = NSSavePanel()
    savePanel.allowedContentTypes = [.json]
    savePanel.canCreateDirectories = true
    savePanel.isExtensionHidden = false
    savePanel.title = "Save the level as JSON file"
    savePanel.message = "Choose a folder and a name to store the JSON file."
    savePanel.nameFieldLabel = "JSON file name:"
    
    let response = savePanel.runModal()
   
    return response == .OK ? savePanel.url : nil
}






func createGrid(rows: Int, columns: Int) -> LevelGrid {
    var images = [[URL?]]()
    for _ in 0..<rows {
        var box: [URL?] = []
            for _ in 0..<columns {
                box.append(nil)
            }
            images.append(box)
        }
    
    return LevelGrid(rows: rows, columns: columns, images: images)
}



func createGridWithItemForClass(rows: Int, columns: Int) -> [[LevelGridItem]] {
    var gridItems = [[LevelGridItem]]()
    
    
    for row in 0..<rows {
        var box: [LevelGridItem] = []
        for column in 0..<columns {
            let newLevelGridItem = LevelGridItem(xPostion: column,
                                                 yPositon: row,
                                                 assets: nil,
                                                 allowPassTrough: nil,
                                                 teleportToScene: nil,
                                                 showAllowPassTrough: false,
                                                 showLevelTeleporter: false)
            box.append(newLevelGridItem)
        }
        gridItems.append(box)
        
    }
    
    return gridItems
}








