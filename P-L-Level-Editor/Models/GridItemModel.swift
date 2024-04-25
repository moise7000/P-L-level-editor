//
//  LevelGridItem.swift
//  levelEditor
//
//  Created by ewan decima on 18/04/2024.
//

import Foundation


struct LevelGridItem: Codable {
    var xPostion: Int
    var yPositon: Int
    var assets: Assets?
    var allowPassTrough: Int?
    var teleportToScene: String?
    var showAllowPassTrough: Bool
    var showLevelTeleporter: Bool
    
}



func isLevelGridItemEmpty(_ item: LevelGridItem) -> Bool {
    return item.assets == nil
}


func serializeSTRUCTUREForJSON(_ levelGridItem: LevelGridItem) -> [String: Any] { //-----------------------------------------> NIL ?
    var out: [String : Any] = [:]
    out["identifier"] = (levelGridItem.assets != nil ? levelGridItem.assets!.id : "") + "_" + UUID().uuidString
    out["x"] = levelGridItem.xPostion
    out["y"] = levelGridItem.yPositon
    out["resource"] = "src_assets_" + (levelGridItem.assets != nil ? levelGridItem.assets!.image : "")
    out["allow_pass_through"] = levelGridItem.allowPassTrough ?? "none"
    out["teleport_to_scene"] = levelGridItem.teleportToScene ?? "none"
    
    return out
    
}

func serializeENTITYForJSON(_ levelGridItem: LevelGridItem) -> [String: Any]? {
    var out: [String : Any] = [:]
    if levelGridItem.assets != nil {
        out["identifier"] = levelGridItem.assets!.image
        out["x"] = levelGridItem.xPostion
        out["y"] = levelGridItem.yPositon
        
        return out
    } else {
        return nil
    }
}

func multipleSerializeSTRUCTUREForJSON(_ levelGridItems: [LevelGridItem]) -> [[String:Any]] {
    var out: [[String:Any]] = []
    for levelGridItem in levelGridItems {
        out.append(serializeSTRUCTUREForJSON(levelGridItem))
    }
    return out
}

func multipleSerializeENTITYForJSON(_ levelGridItems: [LevelGridItem]) -> [[String:Any]] {
    var out: [[String:Any]] = []
    for levelGridItem in levelGridItems {
        if let serializedItem = serializeENTITYForJSON(levelGridItem) {
            out.append(serializedItem)
        }
    }
    
    return out
}
