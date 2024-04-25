//
//  ImageFunction.swift
//  levelEditor
//
//  Created by ewan decima on 19/04/2024.
//

import Foundation
import SwiftUI

func isImageSizeValid(_ imageName: String) -> Bool {
    if let image = NSImage(named: imageName) {
        return  image.size.height == 16 && image.size.width == 16
    } else {
        return false
    }

}


func getInvalidImageOffset(_ imageName: String) -> CGFloat?  {
    var yOffset: CGFloat = 0
    if let image = NSImage(named: imageName) {
        yOffset = (image.size.height - 16)/2
        return -yOffset
    } else {
        print("[!] ERROR : Can't create NSImage from this : \(imageName)")
        return nil
    }
}

func getSize(_ imageName: String) -> (CGFloat, CGFloat) {
    if let image = NSImage(named: imageName) {
        return  (image.size.width, image.size.height)
    }
    return (-1,-1)
}
