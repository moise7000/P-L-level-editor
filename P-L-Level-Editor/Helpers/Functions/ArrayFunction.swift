//
//  ArrayFunction.swift
//  levelEditor
//
//  Created by ewan decima on 19/04/2024.
//

import Foundation


func length<T>(_ array: [T] ) -> Int {
    return array.count
}


func reverseArray<T>(_ array: [T]) -> [T] {
    return array.reversed()
}


func arrayToInt(_ array: [Int]) -> Int {
    var out: Int = 0
    for (i,x) in array.enumerated() {
        out += x * Int(pow(10.0, Double(i)))
    }
    return out
}
func arrayToBinaryInt(_ array: [Int]) -> Int {
    var out: Int = 0
    for (i,x) in array.enumerated() {
        out += x * Int(pow(2.0, Double(i)))
    }
    return out
}


func isIn<T: Equatable>(_ target: T, in array: [T]) -> Bool {
    return array.contains(target)
}


func remove<T: Equatable>(_ target: T, from array: inout [T]) -> Void {
    array.removeAll(where: { $0 == target })
}

func customRemove(_ target: DirectionAPT, from array: [DirectionAPT]) -> [DirectionAPT] {
    var out: [DirectionAPT] = []
    
    for direction in array {
        if direction != target {
            out.append(direction)
        }
    }
    return out
}
