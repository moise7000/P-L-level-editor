import SwiftUI
import Foundation
import AppKit


struct ContentView: View {
    
    @State private var selectedView: String = "New Level"
    
    
    var body: some View {
        
        let stringViewsV1 = ["New Level",
                           "Edit Level",
                           "Sounds",
                           "Assets Collection",
                           "Source Assets Folder"]
        let stringViewsV2 = ["New Level",
                           "Assets Collection",
                           "Source Assets Folder", "test"]
        
        NavigationSplitView {
            List(stringViewsV2, id: \.self, selection: $selectedView) { view in
                HStack{
                    Text(view)
                    if view == "Source Assets Folder" && (AssetsFileMonitorSingleton.shared.isAssetsMonitoredEmpty() || AssetsFileMonitorSingleton.shared.isFilesMonitoredEmpty()) {
                        Spacer()
                        NotificationBadgeView()
                    }
                }
                
            }
        } detail: {
            if selectedView == "test" {
                PickerTestView()
            }
            if selectedView == "New Level" {
                NewLevelView()
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


