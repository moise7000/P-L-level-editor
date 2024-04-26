import SwiftUI
import Foundation
import AppKit


struct ContentView: View {
    
    var body: some View {
        
        NavigationStack{
            VStack{
                Image("background")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit()
                    .cornerRadius(20.0)
                
                
                
                NavigationLink(destination: NewLevelView()) {
                    Text("Pakbo & Lombric Level Editor")
                        .padding()
                        .onHover { hovering in
                            if hovering {
                                NSCursor(image: NSImage(named: "lombric_mouse")!, hotSpot: NSPoint(x: 0, y: 0)).push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                    
                }
                
                
                
                NavigationLink(destination: SoundEditorView()) {
                    Text("Pakbo & Lombric SoundPlayer")
                        .padding()
                        .onHover { hovering in
                            if hovering {
                                NSCursor(image: NSImage(named: "lombric_mouse_dead")!, hotSpot: NSPoint(x: 0, y: 0)).push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                    
                }
                
                NavigationLink(destination: PlaygroundView()) {
                    Text("Pakbo & Lombric & JSON")
                        .padding()
                        .onHover { hovering in
                            if hovering {
                                NSCursor(image: NSImage(named: "lombric_mouse_dead")!, hotSpot: NSPoint(x: 0, y: 0)).push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                    
                }
                
                NavigationLink(destination: AssetsCollectionView()) {
                    Text("Pakbo & Lombric & Assets")
                        .padding()
                        .onHover { hovering in
                            if hovering {
                                NSCursor(image: NSImage(named: "lombric_mouse")!, hotSpot: NSPoint(x: 0, y: 0)).push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                    
                    
                    
                    
                    
                    
                    
                }
                
                NavigationLink(destination: FileManagerTesterView()) {
                    Text("Pakbo & Lombric & TESTER")
                        .foregroundStyle(.pink)
                        .padding()
                        .onHover { hovering in
                            if hovering {
                                NSCursor(image: NSImage(named: "lombric_mouse")!, hotSpot: NSPoint(x: 0, y: 0)).push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                }
                
                NavigationLink(destination: AssetsCollectionView()) {
                    Text("Pakbo & Lombric & ASSETS")
                        
                        .padding()
                        .onHover { hovering in
                            if hovering {
                                NSCursor(image: NSImage(named: "lombric_mouse")!, hotSpot: NSPoint(x: 0, y: 0)).push()
                            } else {
                                NSCursor.pop()
                            }
                        }
 
                }
                
                NavigationLink(destination: FileMonitorTestView()) {
                    Text("Pakbo & Lombric & TEST")
                        
                        .padding()
                        .onHover { hovering in
                            if hovering {
                                NSCursor(image: NSImage(named: "lombric_mouse")!, hotSpot: NSPoint(x: 0, y: 0)).push()
                            } else {
                                NSCursor.pop()
                            }
                        }
 
                }
                
                
                
                
                
                
                
                
            }
        }
    }
}


