//
//  AssetsDataModel.swift
//  levelEditor
//
//  Created by ewan decima on 25/04/2024.
//

import Foundation
import SwiftData


@Model
final class AssetsDataModel {
    var id: UUID
    var name:String
    var imageData: Data
    var imageAbsolutePath: String    //maybe url  or maybe is not pertinent
    var imageJsonPath: String
    var type: AssetsType
    
    init(name: String, imageAbsolutePath: String, imageJsonPath: String , type: AssetsType, imageData: Data) {
        self.id = UUID()
        self.name = name
        self.imageData = imageData
        self.imageAbsolutePath = imageAbsolutePath
        self.imageJsonPath = imageJsonPath
        self.type = type
    }
}
