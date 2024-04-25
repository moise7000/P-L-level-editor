//
//  AssetsCollectionTypedView.swift
//  levelEditor
//
//  Created by ewan decima on 25/04/2024.
//

import SwiftUI
import SwiftData

struct AssetsCollectionTypedView: View {
    
    var type: AssetsType
    @Query() private var typedAssets: [AssetsDataModel]
    
    
    var body: some View {
        
        NavigationStack{
            GeometryReader { geometry in
                let columns = Int(geometry.size.width / 100)
                let gridLayout = Array(repeating: GridItem(.flexible()), count: columns)

                ScrollView {
                    LazyVGrid(columns: gridLayout, spacing: 20) {
                        
                        ForEach(getAllAssetsByType(assets: typedAssets, type: type)) { asset in
                            Text(asset.imageJsonPath)
                                
                                
                        }
                        
                        
                        Button{
                            print("button pressed")
                        } label: {
                            Text("+")
                                .font(.title)
                                .frame(width: 70, height: 70)
                                .foregroundStyle(.pink)
     
                        }
                        .padding()
                        .opacity(0.5)
                        
                        
                        
                        
                        
                        
                    }
                    .padding(.all, 10)
                }
            }
            .navigationTitle("\(type)")
        }
       
        
        
    }
}

