//
//  AssetsTypeModel.swift
//  P-L-Level-Editor
//
//  Created by ewan decima on 28/04/2024.
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
    if string == "backgrounds" {
        return AssetsType.BACKGROUND
    }
    return nil
}
