//
//  SoundEditorView.swift
//  levelEditor
//
//  Created by ewan decima on 17/04/2024.
//

import SwiftUI
import AVFoundation
import AppKit
import UniformTypeIdentifiers

struct SoundEditorView: View {
    
    let a: CGFloat = 1.0
    let b: CGFloat = 70.0
    let c: CGFloat = 2.0
    let d: CGFloat = 10.0
    @State private var rotation: Double = 0
    
    @State private var audioPlayer: AVAudioPlayer?
    @State private var showPopover: Bool = false
    
    @State private var selectedFileURL: URL?
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Button {
                    let sound = Bundle.main.path(forResource: "animal_bird_duck_quack_001", ofType: "mp3")
                    
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                        audioPlayer?.play()
                    } catch {
                        return
                    }
                    
                } label: {
                    Text("Press-me and listen")
                        .padding()
                }
                
                Button {
                    let sound = Bundle.main.path(forResource: "animal_bird_duck_quack_003", ofType: "mp3")
                    
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                        audioPlayer?.play()
                    } catch {
                        print("erreur")
                    }
                    
                } label: {
                    Text("Press-me and listen")
                        .padding()
                }
                
                Button {
                    let sound = Bundle.main.path(forResource: "mainTheme", ofType: "wav")
                    
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                        audioPlayer?.play()
                    } catch {
                        print("[!] ERROR: Can't play this sound.")
                    }
                    
                } label: {
                    Text("Press-me and listen")
                        .padding()
                }
                
//                Button {
//                    showPopover.toggle()
//                } label: {
//                    Text("PopOver")
//                        .padding()
//                }
//                .popover(isPresented: $showPopover) {
//
//                    HStack{
//                        VStack{
//                            HStack{
//                                Text("Coordonée : (0,0)")
//                                Spacer()
//                            }
//                            HStack{
//                                Text("Structure")
//                                Spacer()
//                            }
//                            HStack{
//                                Text("dirt.png")
//                                Spacer()
//                            }
//                            HStack{
//                                Text("APT : 1011")
//                                Spacer()
//                            }
//                            HStack{
//                                Text("Teleporter : None")
//                                Spacer()
//                            }
//
//
//
//                        }
//                        .padding()
//
//
//                        GeometryReader { geometry in
//                            let center = geometry.frame(in: .local).center
//
//                            ZStack {
//                                Rectangle()
//                                    .fill(Color.pink.opacity(0.2))
//                                    .frame(width: 100, height: 100)
//                                    .border(Color.blue, width: 2)
//
//                                makeAllPassTroughNorth(center: center, a: a, b: b, c: c, d: d)
//                                    .fill(Color.pink)
//
//                                makeAllPassTroughSouth(center: center, a: a, b: b, c: c, d: d)
//                                    .fill(Color.green)
//
//                                makeAllPassTroughEast(center: center, a: a, b: b, c: c, d: d)
//                                    .fill(Color.green)
//
//                                makeAllPassTroughWest(center: center, a: a, b: b, c: c, d: d)
//                                    .fill(Color.green)
//
//
//                            }
//                            .rotationEffect(.degrees(rotation))
//                        }
//                    }
//                    .padding(/*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/)
//                    .frame(width: 350, height: 350)
//
//
//                }
//
            
                
//                Button {
//
//                    let data = [
//                        "key1": "value1",
//                        "key2": "value2"
//                    ]
//                    if let url = showSavePanel() {
//                        do {
//                                let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
//                                try jsonData.write(to: url)
//                                print("JSON data was written to the file successfully.")
//                            } catch {
//                                print("Failed to write JSON data to the file: \(error)")
//                                showAlert = true
//                            }
//                    }
//
//
//
//                } label: {
//                    Text("Export JSON")
//                        .padding()
//                }
                
                Spacer()
            }
            .navigationTitle("Sounds")
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("JSON ..."),
                      message: Text("Error during the export of JSON"),
                      primaryButton: .cancel(),
                      secondaryButton: .default(Text(""))
                )
                            
            })
        }
        
        
    }
}






