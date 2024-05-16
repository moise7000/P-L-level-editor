import SwiftUI
import Foundation
import AppKit


struct ContentView: View {
    
    @State private var selectedView: String = "New Level"
    
    
    var body: some View {
        

        let stringViewsV2 = ["New Level",
                             "Assets Collection",
                             "Levels Architecture",
                             "Source Assets Folder",
                             "Source Scenes Folder"]
        
    
        NavigationSplitView {
            List(stringViewsV2, id: \.self, selection: $selectedView) { view in
                HStack{
                    Text(view)
                    if view == "Source Assets Folder" && (AssetsFileMonitorSingleton.shared.isAssetsMonitoredEmpty() || AssetsFileMonitorSingleton.shared.isFilesMonitoredEmpty()) {
                        Spacer()
                        NotificationBadgeView()
                    }
                    
                    if view == "Source Scenes Folder" && LevelsGraphFileMonitorSingleton.shared.isFilesMonitoredEmpty(){
                        Spacer()
                        NotificationBadgeView()
                    }
                }
                
            }
            
            
            
        } detail: {
            if selectedView == "New Level" {
                NewLevelView()
            }
            
            if selectedView == "Levels Architecture" {
                
                let g = LevelsGraphFileMonitorSingleton.shared.makeGraph()
                let nodes = LevelsGraphFileMonitorSingleton.shared.getNodes()
                let edges = LevelsGraphFileMonitorSingleton.shared.getEdges()
                
                
                GraphTestView2(nodes: nodes, edges: edges)
                
                
            }
            
            if selectedView == "Edit Level" {
                PlaygroundView()
            }
            if selectedView == "Assets Collection" {
                AssetsCollectionView()
            }
            if selectedView == "Sounds" {
                SoundEditorView()
            }
            if selectedView == "Source Assets Folder" {
                FileMonitorTestView()
            }
            
            if selectedView == "Source Scenes Folder" {
                LevelGraphView()
            }



                
        }

        
        
        



        
//        NavigationStack{
//            VStack{
//                Image("background")
//                    .resizable()
//                    .frame(width: 200, height: 200)
//                    .scaledToFit()
//                    .cornerRadius(20.0)
//                
//                
//                
//                NavigationLink(destination: NewLevelView()) {
//                    Text("Pakbo & Lombric Level Editor")
//                        .padding()
//                        .onHover { hovering in
//                            if hovering {
//                                NSCursor(image: NSImage(named: "lombric_mouse")!, hotSpot: NSPoint(x: 0, y: 0)).push()
//                            } else {
//                                NSCursor.pop()
//                            }
//                        }
//                    
//                }
//                
//                
//                
//                NavigationLink(destination: SoundEditorView()) {
//                    Text("Pakbo & Lombric SoundPlayer")
//                        .padding()
//                        .onHover { hovering in
//                            if hovering {
//                                NSCursor(image: NSImage(named: "lombric_mouse_dead")!, hotSpot: NSPoint(x: 0, y: 0)).push()
//                            } else {
//                                NSCursor.pop()
//                            }
//                        }
//                    
//                }
//                
//                NavigationLink(destination: PlaygroundView()) {
//                    Text("Pakbo & Lombric & JSON")
//                        .padding()
//                        .onHover { hovering in
//                            if hovering {
//                                NSCursor(image: NSImage(named: "lombric_mouse_dead")!, hotSpot: NSPoint(x: 0, y: 0)).push()
//                            } else {
//                                NSCursor.pop()
//                            }
//                        }
//                    
//                }
//                
//                NavigationLink(destination: AssetsCollectionView()) {
//                    Text("Pakbo & Lombric & Assets")
//                        .padding()
//                        .onHover { hovering in
//                            if hovering {
//                                NSCursor(image: NSImage(named: "lombric_mouse")!, hotSpot: NSPoint(x: 0, y: 0)).push()
//                            } else {
//                                NSCursor.pop()
//                            }
//                        }
//                    
//                    
//                    
//                    
//                    
//                    
//                    
//                }
//                
//                NavigationLink(destination: FileManagerTesterView()) {
//                    Text("Pakbo & Lombric & TESTER")
//                        .foregroundStyle(.pink)
//                        .padding()
//                        .onHover { hovering in
//                            if hovering {
//                                NSCursor(image: NSImage(named: "lombric_mouse")!, hotSpot: NSPoint(x: 0, y: 0)).push()
//                            } else {
//                                NSCursor.pop()
//                            }
//                        }
//                }
//                
//                NavigationLink(destination: AssetsCollectionView()) {
//                    Text("Pakbo & Lombric & ASSETS")
//                        
//                        .padding()
//                        .onHover { hovering in
//                            if hovering {
//                                NSCursor(image: NSImage(named: "lombric_mouse")!, hotSpot: NSPoint(x: 0, y: 0)).push()
//                            } else {
//                                NSCursor.pop()
//                            }
//                        }
// 
//                }
//                
//                NavigationLink(destination: FileMonitorTestView()) {
//                    Text("Pakbo & Lombric & TEST")
//                        
//                        .padding()
//                        .onHover { hovering in
//                            if hovering {
//                                NSCursor(image: NSImage(named: "lombric_mouse")!, hotSpot: NSPoint(x: 0, y: 0)).push()
//                            } else {
//                                NSCursor.pop()
//                            }
//                        }
// 
//                }
//                
//                
//                
//                
//                
//                
//                
//                
//            }
//        }
    }
}


