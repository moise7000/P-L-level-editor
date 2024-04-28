//
//  ImageFunction.swift
//  levelEditor
//
//  Created by ewan decima on 19/04/2024.
//

import Foundation
import SwiftUI

func isImageSizeValid(_ imageUrl: URL) -> Bool {
    if let image = NSImage(contentsOf: imageUrl) {
        return  image.size.height == 16 && image.size.width == 16
    } else {
        return false
    }

}


func getInvalidImageOffset(_ imageUrl: URL) -> CGFloat?  {
    var yOffset: CGFloat = 0
    if let image = NSImage(contentsOf: imageUrl) {
        yOffset = (image.size.height - 16)/2
        return -yOffset
    } else {
        print("[!] ERROR : Can't create NSImage from this : \(imageUrl)")
        return nil
    }
}

func getSize(_ imageUrl: URL) -> (CGFloat, CGFloat) {
    if let image = NSImage(contentsOf: imageUrl) {
        return  (image.size.width, image.size.height)
    }
    return (-1,-1)
}
