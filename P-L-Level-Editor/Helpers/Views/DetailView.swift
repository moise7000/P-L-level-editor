//
//  DetailView.swift
//  levelEditor
//
//  Created by ewan decima on 18/04/2024.
//

import SwiftUI

struct DetailView: View {
    
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
            VStack{
                HStack{
                    Text("Position : (\(row),\(column))")
                    Spacer()
                }
                if dataGrid.getAsset(row, column) != nil {
                    
                    HStack{
                        Text("Type : \(dataGrid.getAssetType(row, column)!)")
                        Spacer()
                    }
                    HStack{
                        Text("Image : \(dataGrid.getImageName(row, column))")
                        Spacer()
                    }
                    
                    HStack{
                        Text("Size : \(getSize(dataGrid.getImageName(row, column))) ")
                        Spacer()
                    }
                }
                
                
                HStack{
                    if let aptValue = fromAPTToInt(from: aptData[row][column]) {
                        Text("APT : \(aptValue)")
                    } else {
                        Text("APT: ERROR ...")
                            .foregroundStyle(.pink)
                    }
                    Spacer()
                }
                HStack{
                    Text("Teleporter : None")
                    Spacer()
                }
                
                
                    
            }
            .padding()
            
            
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
        .padding()
        .frame(width: 400, height: 250)
    }
}

