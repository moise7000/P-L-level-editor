//
//  ColisionsView.swift
//  levelEditor
//
//  Created by ewan decima on 19/04/2024.
//

import SwiftUI

struct CollisionsView: View {
    
    var dataGrid: LevelGridForItem
    var row: Int
    var column: Int
    
    var aptData: [[[DirectionAPT]]]
    
    var a: CGFloat
    var b: CGFloat
    var c: CGFloat
    var d: CGFloat
    
    
    var body: some View {
        
        HStack{
            GeometryReader { geometry in
                let center = geometry.frame(in: .local).center
                
                ZStack {
                    Rectangle()
                        .fill(Color.pink.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .border(Color.blue, width: 2)
                    
                    makeAllPassTroughNorth(center: center, a: a, b: b, c: c, d: d)
                        .fill(isIn(DirectionAPT.NORTH, in: aptData[row][column]) ? Color.green : Color.pink)
                    
                    makeAllPassTroughSouth(center: center, a: a, b: b, c: c, d: d)
                        .fill(isIn(DirectionAPT.SOUTH, in: aptData[row][column]) ? Color.green : Color.pink)
                    
                    makeAllPassTroughEast(center: center, a: a, b: b, c: c, d: d)
                        .fill(isIn(DirectionAPT.EAST, in: aptData[row][column]) ? Color.green : Color.pink)
                    
                    makeAllPassTroughWest(center: center, a: a, b: b, c: c, d: d)
                        .fill(isIn(DirectionAPT.WEST, in: aptData[row][column]) ? Color.green : Color.pink)
                    
                    
                }
                
            }
        }
        .frame(width: 300, height: 300)
        
        
    }
}

