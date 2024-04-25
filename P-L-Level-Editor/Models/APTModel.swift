//
//  APTModel.swift
//  levelEditor
//
//  Created by ewan decima on 19/04/2024.
//

import Foundation



enum DirectionAPT{
    case NORTH
    case SOUTH
    case WEST
    case EAST
}


func fromAPTToInt(from apt:[DirectionAPT]) -> Int? {
    if length(apt) > 4 {
        return nil
    }
    var temp : [Int] = [0,0,0,0]
    for direction in apt{
        if direction == DirectionAPT.WEST {
            temp[0] = 1
        }
        
        if direction == DirectionAPT.NORTH{
            temp[1] = 1
        }
        if direction == DirectionAPT.EAST{
            temp[2] = 1
        }
        
        if direction == DirectionAPT.SOUTH{
            temp[3] = 1
        }
    }
    
    let tempReversed = reverseArray(temp)
    
    return arrayToBinaryInt(tempReversed)
}


