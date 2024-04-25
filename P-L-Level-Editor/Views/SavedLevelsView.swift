//
//  SavedLevelsView.swift
//  levelEditor
//
//  Created by ewan decima on 21/04/2024.
//

import SwiftUI
import SwiftData

struct SavedLevelsView: View {
    @Query() private var savedLevels: [SavedLevelsModel]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(savedLevels, id: \.self) { savedLevel in
                    NavigationLink {
                        let validLevelToEdit = convertLevelGridForSwiftDataIntoForItem(savedLevel.level)
                        //EditLevelView(dataGrid: validLevelToEdit , grid: [[""]])
                    } label: {
                        Text(savedLevel.name)
                            .padding()
                    }

                }
            }
            .navigationTitle("Saved Levels")
        }
        
        
    }
}

