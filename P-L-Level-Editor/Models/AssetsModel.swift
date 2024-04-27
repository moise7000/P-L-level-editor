//
//  Assets.swift
//  levelEditor
//
//  Created by ewan decima on 18/04/2024.
//

import Foundation


enum AssetsType: Codable, CaseIterable {
    case STRUCTURE
    case ENTITY
    case BACKGROUND
    case TELEPORTER
}


func getTypeFromString(from string:String) -> AssetsType? {
    if string == "entities" {
        return AssetsType.ENTITY
    }
    if string == "structures" {
        return AssetsType.STRUCTURE
    }
    if string == "background" {
        return AssetsType.BACKGROUND
    }
    return nil
}




struct Assets : Hashable, Codable {
    var id: String
    var type: AssetsType
    var image: String
    var url: URL?
}

func affectAssetsType(imageNames:[String], type: AssetsType) -> [Assets] {
    var out: [Assets] = []
    for imageName in imageNames {
        let assetId = imageName
        out.append(Assets(id: assetId, type: type, image: imageName))
    }
    return out
}


func getAssetsByType(_ assets: [Assets], assetType: AssetsType) -> [Assets] {
    var out: [Assets] = []
    for asset in assets {
        if asset.type == assetType {
            out.append(asset)
        }
    }
    return out 
}












//--------------------------------// ASSETS NAMES //-------------------------------------------------//

let STRUCTURE_NAMES: [String] =  []

let ENTITY_NAMES: [String] = []

let BACKGROUND_NAMES: [String] = []

//---------------------------------------------------------------------------------//
