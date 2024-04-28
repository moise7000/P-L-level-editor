//
//  ImageFunction.swift
//  levelEditor
//
//  Created by ewan decima on 19/04/2024.
//

import Foundation
import SwiftUI


func getSize(_ imageUrl: URL) -> (CGFloat, CGFloat) {
    if let image = NSImage(contentsOf: imageUrl),
       let rep = image.representations.first {
        return (CGFloat(rep.pixelsWide), CGFloat(rep.pixelsHigh))
    }
    return (-1, -1)
}


func getImageSize(_ imageUrl: URL) -> (CGFloat, CGFloat)? {
    if let image = NSImage(contentsOf: imageUrl),
       let rep = image.representations.first,
       rep.pixelsWide > 16 || rep.pixelsHigh > 16 {
        return (CGFloat(rep.pixelsWide), CGFloat(rep.pixelsHigh))
    }
    return nil
}


func isImageSizeValid(_ imageUrl: URL) -> Bool {
    if let image = NSImage(contentsOf: imageUrl),
       let rep = image.representations.first {
        return (CGFloat(rep.pixelsWide), CGFloat(rep.pixelsHigh)) == (16,16)
    }
    
    return false


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

