//
//  JSONFunction.swift
//  levelEditor
//
//  Created by ewan decima on 20/04/2024.
//

import Foundation


func readJSON(url: URL) -> [String: Any]? {
    do {
        let data = try Data(contentsOf: url)
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        if let jsonResult = jsonResult as? Dictionary<String, Any> {
            return jsonResult
        }
    } catch {
        print("[!] ERROR while reading and/or exporting the JSON file")
        return nil
    }
    return nil
}


// MARK: For json resource
// - fromUrlToString
// - extractJsonPathFromUrlString
// - urlPathToJsonFormatPath
// - removePNGExtension

func setStructureNameForJson(url: URL) -> String? {
    let urlString = fromUrlToString(from: url)
    if let jsonPath = extractJsonPathFromUrlString(from: urlString) {
        let jsonFormatPath = urlPathToJsonFormatPath(jsonPath)
        let final = removePNGExtension(from: jsonFormatPath)
        return final
    } else {
        print("[!] ERROR : can't get the JSON path from this url : \(url)")
        return nil
    }
}

func setBackgroundNameForJSon(url: URL) -> String? {
    let urlString = fromUrlToString(from: url)
    if let jsonPath = extractJsonPathFromUrlString(from: urlString) {
        let jsonFormatPath = urlPathToJsonFormatPath(jsonPath)
        let final = removePNGExtension(from: jsonFormatPath)
        return final
    } else {
        print("[!] ERROR : can't get the JSON path from this url : \(url)")
        return nil
    }
}


func makeEntityIdentifierForJson(url: URL) -> String? {
    let urlString = fromUrlToString(from: url)
    if let imageNamePNG = getImageNameFromUrlString(from: urlString) {
        let imageName = removePNGExtension(from: imageNamePNG)
        return imageName
    } else {
        print("[!] ERROR : Can't get imageName from this url : \(url)")
        return nil
    }
    
}

// MARK: For json identifier
// - fromUrlToString
// - removePNGExtension
// - getImageNameFromUrlString






func JSONStructureToLevelGridItem(jsonStructure: [String: Any]) -> LevelGridItem? {
    var xPosition: Int?
    var yPosition: Int?
    var asset: Assets?
    var allowPassThrough: Int?
    var teleportToScene: String?
    

    
    for (key, value) in jsonStructure {
        if key == "x" {
            if let x = value as? Int {
                xPosition = x
            } else {
                print("[!] ERROR: In JSONStructureToLevelGridItem, immpossible to get xPosition")
                return nil
            }
        }
        
        if key == "y" {
            if let y = value as? Int {
                yPosition = y
            } else {
                print("[!] ERROR: In JSONStructureToLevelGridItem, immpossible to get yPosition")
                return nil
            }
        }
        
        if key == "resource" {
            if let assetName = value as? String {
                asset = Assets(id: assetName + UUID().uuidString, type: AssetsType.STRUCTURE, image: assetName)
            } else {
                print("[!] ERROR: In JSONStructureToLevelGridItem, immpossible to get RESOURCE")
                return nil
            }
        }
        
        if key == "teleport_to_scene" {
            if let TTS = value as? String {
                teleportToScene = TTS == "none" ? nil : TTS
            } else {
                print("[!] ERROR: In JSONStructureToLevelGridItem, immpossible to get TELEPORT_TO_SCENE")
                return nil
            }
        }
        
        if key == "allow_pass_through" {
            if let APT = value as? Int { // Case where allow_path_through is an integer
                allowPassThrough = APT
            } else {
                if let APT = value as? String {
                    if APT == "none" {
                        print("WARNING: For this structure ALLOW_PASS_THROUGH is equal to NONE.")
                        allowPassThrough = nil
                    } else {
                        print("[!] ERROR: For This structure ALLOW_PASS_THROUGH is equal to STRING that is not NONE. ")
                        return nil
                    }
                } else {
                    print("[!] ERROR: In JSONStructureToLevelGridItem, impossible to handle ALLOW_PASS_THROUGH key. ")
                    return nil
                }
            }
        }
        
    }
    
    if teleportToScene == nil || allowPassThrough == nil {
        if teleportToScene == nil {
            print("WARNING: For this structure TELEPORT_TO_SCENE will equal to NIL in LevelGridForItem.")
        }
        if allowPassThrough == nil {
            print("WARNING: For this structure ALLOW_PASS_THROUGH will equal to NIL in LevelGridForItem.")
        }
        
    }
    
    if xPosition == nil || yPosition == nil || asset == nil  {
        print("xPosition: \(xPosition)")
        print("yPosition: \(yPosition)")
        print("asset: \(asset)")
        print("allPassThrough: \(allowPassThrough)")
        print("teleporToScene: \(teleportToScene)")
        print("[!] ERROR: In JSONStructureToLevelGridItem, failed the end test.")
        return nil
    }
    
    return LevelGridItem(xPostion: xPosition!,
                         yPositon: yPosition!,
                         assets: asset,
                         allowPassTrough: allowPassThrough,
                         teleportToScene: teleportToScene,
                         showAllowPassTrough: false,
                         showLevelTeleporter: false)
}

func JSONEntityToLevelGridItem(jsonStructure: [String: Any]) -> LevelGridItem? {
    var xPosition: Int?
    var yPosition: Int?
    var asset: Assets?
    
    for (key, value) in jsonStructure {
        if key == "x" {
            if let x = value as? Int {
                xPosition = x
            } else {
                return nil
            }
        }
        
        if key == "y" {
            if let y = value as? Int {
                yPosition = y
            } else {
                return nil
            }
        }
        
        if key == "identifier" {
            if let assetName = value as? String {
                asset = Assets(id: assetName + UUID().uuidString, type: AssetsType.ENTITY, image: assetName)
            } else {
                return nil
            }
        }
        
        
    }
    
    if xPosition == nil || yPosition == nil || asset == nil {
        return nil
    }
    
    return LevelGridItem(xPostion: xPosition!,
                         yPositon: yPosition!,
                         assets: asset,
                         allowPassTrough: nil,
                         teleportToScene: nil,
                         showAllowPassTrough: false,
                         showLevelTeleporter: false)
}

func getJSONValueCoordinate(jsonStructure: [String: Any]) -> (Int, Int)? {
    var structureCoordinate: (Int?,Int?)
    
    for (key, value) in jsonStructure {
        if key == "x" {
            if let column = value as? Int {
                structureCoordinate.0 = column
            } else {
                return nil
            }
        }
        if key == "y" {
            if let row = value as? Int {
                structureCoordinate.1 = row
            } else {
                return nil
            }
        }
    }
    
    if structureCoordinate.0 == nil || structureCoordinate.1 == nil {
        return nil
    }
    
    return structureCoordinate as! (Int, Int)
}

func JSONToLevelGridForItem(jsonDictionary jsonD: [String: Any]) -> LevelGridForItem? {
    var levelGrid = LevelGridForItem(rows: 8, columns: 16)
    for (key, value) in jsonD {
        
        if key == "name" {
            if let name = value as? String {
                levelGrid.name = name
            } else {
                return nil
            }
        }
        
        if key == "background" {
            if let background = value as? String {
                levelGrid.background = fromStringToUrl(from: background)
            } else {
                return nil
            }
        }
        
        
        if key == "structures" { // The assicated value to this key is a list of dictionaries for STRUCTURES.
            //Handle value with for-in loop. [!] Value is it a sequence or not ? Yes of course.
            if let structureArrayDictionary = value as? [[String: Any]] {
                for structureDictionay in structureArrayDictionary {
                    if let (x, y) = getJSONValueCoordinate(jsonStructure: structureDictionay) {
                        if let levelGridItem = JSONStructureToLevelGridItem(jsonStructure: structureDictionay) {
                            
                            levelGrid.gridItems[y][x] = levelGridItem
                        } else {
                            print("[!] ERROR in JSON file : impossible to convert the current STRUCTURE into a LevelGridItem instance. ")
                            return nil
                        }
                    } else {
                        print("[!] ERROR in JSON file : impossible to get the current STRUCTURE's coordinates.")
                        return nil
                    }
                }
            } else {
                print("[!] ERROR in JSON file : the STRUCTURES section is not a array of dictionary.")
                return nil
            }
        }
        
        
        
        if key == "entities" { // The assicated value to this key is a list of dictionaries for ENTITIES.
            //Handle value with for-in loop. [!] Value is it a sequence or not ? Yes of course.
            if let entitiesArrayDictionary = value as? [[String: Any]] {
                for entitiyDictionary in entitiesArrayDictionary {
                    if let (x,y) = getJSONValueCoordinate(jsonStructure: entitiyDictionary) {
                        if let levelGridItem = JSONEntityToLevelGridItem(jsonStructure: entitiyDictionary) {
                            levelGrid.gridItems[y][x] = levelGridItem
                        } else {
                            print("[!] ERROR in JSON file : impossible to convert the current ENTITY into a LevelGridItem instance. ")
                            return nil
                        }
                    } else {
                        print("[!] ERROR in JSON file : impossible to get the current ENTITY's coordinates.")
                        return nil
                    }
                }
            } else {
                print("[!] ERROR in JSON file : the ENTITIES section is not a array of dictionary.")
                return nil
            }
            
        }
        
        
        
    }
    return levelGrid
}


func getImageNameFromJSONStrucutreDictionary(_ dictionary: [String: Any]) -> String? {
    var imageName: String?
    for (key, value) in dictionary{
        if key == "resource" {
            if let imageLongName = value as? String{
                if let extractImageName = getImageNameFromResourceString(from: imageLongName) {
                    imageName = extractImageName
                } else {
                    return nil
                }
            } else {
                print("[!] ERROR in JSON file : impossible to get the resource string.")
            }
        }
    }
    
    if imageName == nil {
        print("[!] ERROR : getImageNameFromJSONDictionary failed.")
        return nil
    }
    
    return imageName
}

func getImageNameFromJSONEntityDictionary(_ dictionary: [String: Any]) -> String? {
    var imageName: String?
    for (key, value) in dictionary{
        if key == "identifier" {
            if let imageNameIdentifier = value as? String {
                imageName = imageNameIdentifier
            } else {
                print("[!] ERROR : cannot get the image name from IDENTIFIER in entity section")
                return nil
            }
        }
    }
    
    if imageName == nil {
        print("[!] ERROR : getImageNameFromJSONDictionary failed.")
        return nil
    }
    
    return imageName
}


func imageNamesGridFromJSON(from json: [String: Any]) -> LevelGrid? {
    var grid: LevelGrid = createGrid(rows: 8, columns: 16)
    for (key, value) in json {
        if key == "structures" {
            if let structureArrayDictionary = value as? [[String: Any]] {
                for structureDictionary in structureArrayDictionary {
                    if let (x, y) = getJSONValueCoordinate(jsonStructure: structureDictionary) {
                        if let imageName = getImageNameFromJSONStrucutreDictionary(structureDictionary) {
                            //Add image to grid with coordinates
                            grid.images[y][x] = fromStringToUrl(from: imageName)!
                        } else {
                            print("[!] ERROR : Cannot imageName from getImageNameFromJSONDictionary.")
                            return nil
                        }
                        
                    } else {
                        print("[!] ERROR in JSON file : impossible to get the current STRUCTURE's coordinates.")
                        return nil
                    }
                }
            } else {
                print("[!] ERROR in JSON file : the STRUCTURES section is not a array of dictionary.")
                return nil
            }
        }
        
        
        if key == "entities" {
            if let entitiesArrayDictionary = value as? [[String: Any]] {
                for entityDictionary in entitiesArrayDictionary {
                    if let (x, y) = getJSONValueCoordinate(jsonStructure: entityDictionary) {
                        if let imageName = getImageNameFromJSONEntityDictionary(entityDictionary){
                            grid.images[y][x] = fromStringToUrl(from: imageName)!
                        } else {
                            print("[!] ERROR : Cannot imageName from getImageNameFromJSONDictionary.")
                            return nil
                        }
                    } else {
                        print("[!] ERROR in JSON file : impossible to get the current ENTITY's coordinates.")
                        return nil
                    }
                }
            } else {
                print("[!] ERROR in JSON file : the ENTITIES section is not a array of dictionary.")
                return nil
            }
        }
    }
    
    
    return grid
}
