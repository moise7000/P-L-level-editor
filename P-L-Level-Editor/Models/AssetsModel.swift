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


struct Assets : Hashable, Codable {
    var id: String
    var type: AssetsType
    var image: String
}

func affectAssetsType(imageNames:[String], type: AssetsType) -> [Assets] {
    var out: [Assets] = []
    for imageName in imageNames {
        let assetId = imageName
        out.append(Assets(id: assetId, type: type, image: imageName))
    }
    return out
}












//--------------------------------// ASSETS NAMES //-------------------------------------------------//

let STRUCTURE_NAMES =  ["block_circles",
                        "ecocup",
                        "door",
                  
                        "plateforme_surelevee",
                        "random_block",
                        "sol_eclaire",
                        "sol",
                        "toolbox",
                        "wall",
                        "server",
                        "dirt_1",
                        "dirt_2",
                        "dirt_3",
                        "dirt_4",
                        "dirt_5",
                        "dirt_6",
                        "dirt_7",
                        "dirt_8",
                        "dirt_9",
                        "dirt_10",
                        "dirt_11",
                        "dirt_12",
                        "dirt_13",
                        "dirt_14",
                        "dirt_15",
                        "dirt_16",
                        "dirt_17",
                        "dirt_18",
                        "dirt_19",
                        "dirt_20",
                        "dirt_21",
                        "dirt_22",
                        "dirt_23",
                        "dirt_24",
                        "dirt_25",
                        "dirt_26",
                        "dirt_27",
                        "dirt_28",
                        "dirt_29",
                        "dirt_30",
                        "dirt_31",
                        "dirt_32",
                        "dirt_33",
                        "dirt_34",
                        "dirt_35",
                        "dirt_36",]

let ENTITY_NAMES = ["lombric_walk",
                    "bouth",
                    "duck_2",
                    "duck_3",
                    "duck_4_purple",
                    "psych_duck",
                    "tentacula",
                    "arrow",
                    "boss_canard",
                    "pnj"]

let BACKGROUND_NAMES = ["blurred_brick_background_with_floor",
                        "birck_background",
                        "title",
                        ]

//---------------------------------------------------------------------------------//
