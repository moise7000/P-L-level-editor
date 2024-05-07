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

func getImageNameFromUrlString(from urlString: String) -> String? {
    let components = urlString.components(separatedBy: "/")
    guard components.count > 1 else {
        print("[!] ERROR : impossible to get imageName from url: \(urlString)")
        return nil
    }
    return components.last
}

func makeIdentifierFromString(from entityName: String) -> String {
    return entityName + "_" + UUID().uuidString
}


func isStringContaintsSubString(_ main:String, _ sub: String) -> Bool{
    return main.contains(sub)
}


func extractJsonPathFromUrlString(from urlString: String) -> String? {
    //Users/ewan/Documents/src/assets/entities/imageName.png ->src/assets/entities/imageName.png
    if let range = urlString.range(of: "src") {
        let nouveauChemin = String(urlString[range.lowerBound...])
        return nouveauChemin
    } else {
        print("[!] ERROR: The url string don't contains src ...")
        return nil
    }
    
}

func getTypeFromUrlString(from urlString: String) -> AssetsType? {
    // cut at "src/" and take the last
    let componentsAfterSRC_ASSETS = urlString.components(separatedBy: "src/assets/")
    let typePath = componentsAfterSRC_ASSETS.last
    // cut at all "/" and take the first
    let components = typePath?.components(separatedBy: "/")
    // convert the string type into a type
    let typeString = components?.first
    
    if typeString != nil {
        return getTypeFromString(from: typeString!)
    } else {
        return nil
    }
    
   
}

func urlPathToJsonFormatPath(_ url: String) -> String {       // src/assets/structures/imageName.png  ---> src_assets_structures_imageName.png
    return url.replacingOccurrences(of: "/", with: "_")
}

func removePNGExtension(from string: String) -> String {       // imageName.png ----> imageName
    if string.hasSuffix(".png") {
        let endIndex = string.index(string.endIndex, offsetBy: -4)
        return String(string[..<endIndex])
    }
    return string
}

func jsonFormatPathToUrlPath(_ jsonFormat: String) -> String {
    return jsonFormat.replacingOccurrences(of: "_", with: "/")
}

func fromUrlToString(from url: URL) -> String {
    return url.absoluteString
}

func fromStringToUrl(from string: String) -> URL? {
    return URL(string: string)
}

func deleteEnderWhiteSpace(_ input: String) -> String {
    return input.trimmingCharacters(in: .whitespacesAndNewlines)
}
func formatNextLevelNameForTeleporter(_ inputNextLevelName: String) -> String {
    var formatedNextLevelName: String = ""
    for char in inputNextLevelName{
        if char != " "{
            formatedNextLevelName.append(char)
        } else {
            formatedNextLevelName.append("_")
        }
    }
    return deleteEnderWhiteSpace(formatedNextLevelName)
}


func makeTeleporterToScene(nextLevelName: String, posX:Int, posY: Int) -> String {
    var out: String = ""
    out += formatNextLevelNameForTeleporter(nextLevelName)
    out += "_" + String(posX) + "_" + String(posY)
    return out
}



//MARK: For edit
//fromUrlToString
// - removePNGExtension
// - getImageNameFromUrlString
