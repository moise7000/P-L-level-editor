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

                ScrollView {
                    LazyVGrid(columns: gridLayout, spacing: 20) {
                        
                        ForEach(getAssetsByType(AssetsFileMonitorSingleton.shared.getAssets(), assetType: type), id:\.self) { asset in
                            Image(nsImage: NSImage(contentsOf: asset.url!)!)
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    .padding(.all, 10)
                }
            }
            .navigationTitle("\(type)")
        }
        .onAppear{
            AssetsFileMonitorSingleton.shared.refresh()
        }
        
       
        
        
    }
}

