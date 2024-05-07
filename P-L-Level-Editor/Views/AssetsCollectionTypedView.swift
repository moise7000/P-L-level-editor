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
    
    
    
    var body: some View {
        
        NavigationStack{
            GeometryReader { geometry in
                let columns = Int(geometry.size.width / 100)
                let gridLayout = Array(repeating: GridItem(.flexible()), count: columns)
                let allAssets = AssetsFileMonitorSingleton.shared.getAssets()
                
                ScrollView {
                    LazyVGrid(columns: gridLayout, spacing: 20) {
                        
                        ForEach(getAssetsByType(allAssets, assetType: type), id:\.self) { asset in
                            VStack{
                                if NSImage(contentsOf: asset.url!) != nil {
                                    Image(nsImage: NSImage(contentsOf: asset.url!)!)
                                        .resizable()
                                        .interpolation(.none)
                                        .aspectRatio(contentMode: .fit)
                                    Text(removePNGExtension(from: asset.image))
                                }
                                
                            }
                            
                        }
  
                    }
                    .padding(.all, 10)
                }
            }
            .navigationTitle("\(type)")
        }
       
        
        
        
        
       
        
        
    }
}

