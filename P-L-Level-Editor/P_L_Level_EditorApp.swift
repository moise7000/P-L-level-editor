//
//  P_L_Level_EditorApp.swift
//  P-L-Level-Editor
//
//  Created by ewan decima on 25/04/2024.
//

import SwiftUI
import SwiftData

@main
struct levelEditorApp: App {
    
    @ObservedObject var assetsMonitor = AssetsFileMonitor()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SavedLevelsModel.self, AssetsDataModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .onAppear{
                    //Load all the asset if the userdefault exists
                    assetsMonitor.initMonitor()
                }
        }
        .modelContainer(sharedModelContainer)
        
    }
}
