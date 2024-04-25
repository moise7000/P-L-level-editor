//
//  StringFunction.swift
//  levelEditor
//
//  Created by ewan decima on 21/04/2024.
//

import Foundation

func getImageNameFromResourceString(from ressourceString: String) -> String? {
    let components = ressourceString.components(separatedBy: "assets_")
    guard components.count > 1 else {
        print("[!] ERROR : impossible to get image_name from src_assets_<image_name>")
        return nil
    }
    return components[1]
}


func isInputValid(_ input: String) -> Bool {
    if input == "" {
        return false
    }
    if input.trimmingCharacters(in: .whitespaces).isEmpty {
        return false
    }
    
    return true
}


func getAssetNameFromAssetBashPath(form path: String) -> String? {
    let components = path.components(separatedBy: "_")
    guard components.count > 1 else {
        print("[!] ERROR : Impossible to get the image name from : \(path)")
        return nil
    }
    return components.last
}

func makeIdentifierFromString(from entityName: String) -> String {
    return entityName + "_" + UUID().uuidString
}
