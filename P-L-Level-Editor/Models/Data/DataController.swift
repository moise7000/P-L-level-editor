//
//  DataController.swift
//  levelEditor
//
//  Created by ewan decima on 25/04/2024.
//

import Foundation
import SwiftData




func addAssetData(modelContext:ModelContext, name: String, imageData: Data, absolutePath:String, jsonPath:String, type:AssetsType) -> Void {
    let newAsset = AssetsDataModel(name: name, imageAbsolutePath: absolutePath, imageJsonPath: jsonPath, type: type, imageData: imageData)
    modelContext.insert(newAsset)
    print("[SUCCESS] New Assest stored successfully in SwiftData.")
}

func editAssetData(_ asset: AssetsDataModel, name: String, absolutePath: String, jsonPath: String, type: AssetsType) -> Void {
    asset.name = name
    asset.imageAbsolutePath = absolutePath
    asset.imageJsonPath = jsonPath
    asset.type = type
    print("[SUCCESS] Asset edited successfully.")
}

func editMultipleAssetsJsonPath(_ assets:[AssetsDataModel], jsonPath: String) -> Void {
    for asset in assets {
        asset.imageJsonPath = jsonPath
    }
    print("[SUCCES] Assets JSON path edited successfully.")
}



func deleteAssetData(_ asset: AssetsDataModel, modelContext: ModelContext) -> Void {
    modelContext.delete(asset)
    print("[SUCCESS] Asset deleted successfully")
}




func getAllAssetsByType(assets: [AssetsDataModel], type: AssetsType) -> [AssetsDataModel] {
    var out: [AssetsDataModel] = []
    for asset in assets {
        if asset.type == type {
            out.append(asset)
        }
    }
    return out
}

func getAllEntitiesAsset(_ assets: [AssetsDataModel]) -> [AssetsDataModel] {
    return getAllAssetsByType(assets: assets, type: AssetsType.ENTITY)
}


func getAllBackgroundsAsset(_ assets: [AssetsDataModel]) -> [AssetsDataModel] {
    return getAllAssetsByType(assets: assets, type: AssetsType.BACKGROUND)
}


func getAllStructuresAsset(_ assets: [AssetsDataModel]) -> [AssetsDataModel] {
    return getAllAssetsByType(assets: assets, type: AssetsType.STRUCTURE)
}





