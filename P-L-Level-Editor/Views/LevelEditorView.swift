//
//  TestView4.swift
//  levelEditor
//
//  Created by ewan decima on 15/04/2024.
//

import SwiftUI

struct LevelEditoirView: View {
    
    let imageNames = ["block_circles",
                      "ecocup",
                      "door",
                      "dirt",
                      "plateforme_surelevee",
                      "random_block",
                      "sol_eclaire",
                      "sol",
                      "toolbox",
                      "wall",
                      "server" ]
    
    
    let entityNames = ["lombric_walk",
                       "bouth",
                       "duck_2",
                       "duck_3",
                       "duck_4_purple",
                       "psych_duck",
                       "tentacula",
                       "arrow",
                       "boss_canard"]
    
    let backgroundNames = ["blurred_brick_background_with_floor",
                           "birck_background"]
    
    
   
    
    @State private var grid: LevelGrid = createGrid(rows: 8, columns: 16)
    @State private var selectedImage: String?
    
    
    
    @State private var zoomLevel: CGFloat = 4.0
    
    @State private var lastRow: Int?
    @State private var lastColumn: Int?
    
    @State private var showingEntity: Bool = false
    @State private var showingStructure: Bool = true
    @State private var showingBackground: Bool = false
   
    
    @State private var displayBackground: Bool = true
    @State private var displayForeground: Bool = true
    @State private var displayAllPassTrough: Bool = false
    
    @State private var selectedBackground: String?
    
    @State private var isErazerSelected: Bool = false
    
    
    @State private var showResetAlert: Bool = false
    
    
    var body: some View {
        
        
        
        
        HStack{
            VStack{
                HStack{
                    Button{
                        showingBackground = false
                        showingEntity = false
                        showingStructure = true
                    } label: {
                        Text("Structure")
                    }
                    
                    Button{
                        showingBackground = false
                        showingStructure = false
                        showingEntity = true
                    } label: {
                        Text("Entity")
                    }
                    
                    Button{
                        showingEntity = false
                        showingStructure = false
                        showingBackground = true
                    } label: {
                        Text("Backround")
                    }
                }
            
                if showingEntity{
                    ScrollView{
                        VStack{
                            ForEach(entityNames, id: \.self) { entityName in
                                Image(entityName)
                                    .scaleEffect(1.25)
                                    .padding()
                                    .onTapGesture {
                                        isErazerSelected = false
                                        self.selectedImage = entityName
                                        
                                    }
                            }
                        }
                    }
                }
                
                if showingBackground{
                    ScrollView{
                        VStack{
                            ForEach(backgroundNames, id: \.self) { backgroundName in
                                Image(backgroundName)
                                    .scaleEffect(1.25)
                                    .padding()
                                    .onTapGesture {
                                        isErazerSelected = false
                                        self.selectedBackground = backgroundName
                                        
                                    }
                            }
                        }
                    }
                }
                
                if showingStructure{
                    ScrollView{
                        VStack{
                            ForEach(imageNames, id: \.self) { imageName in
                                Image(imageName)
                                    .scaleEffect(1.25)
                                    .padding()
                                    .onTapGesture {
                                        isErazerSelected = false
                                        self.selectedImage = imageName
                                        
                                    }
                            }
                        }
                    }
                }
            }
            Spacer()
            
            //MARK: Level Environement
            VStack{
                HStack{
                    HStack{
                        if selectedImage != nil && selectedImage != ""{
                            HStack{
                                Text("Selected image : ")
                                Image(selectedImage!)
                                Spacer()
                            }
                            
                                
                        }else{
                            HStack{
                                Text("Selected image : ")
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 16, height: 16)
                                Spacer()
                            }
                           
                        }
                        
                    
                        
                        if selectedBackground != nil {
                            HStack{
                                Text("Current background : ")
                                Image(selectedBackground!)
                                    .scaleEffect(0.7)
                                Spacer()
                                Button{
                                    selectedBackground = nil
                                    } label: {
                                        Text("Delete")
                                            
                                            .foregroundStyle(.pink)
                                }
                                    
                            }
                            
                            
                        }
                    }
                    
                    
                    
                    Spacer()
                }
                Spacer()
                
                ZStack{
                    
                    if displayBackground {
                        Rectangle()
                            .fill(getColorBackground())
                            .frame(width: 16 * 16, height: 8 * 16)
                            .border(Color.pink)
                        
                            .overlay {
                                if selectedBackground != nil {
                                    Image(selectedBackground!)
                                }
                            }
                            
                    }
                    
                    if displayForeground {
                        VStack(spacing: 0.01) {
                            ForEach(0..<grid.rows, id: \.self) { row in
                                HStack(spacing: 0.01) {
                                    ForEach(0..<grid.columns, id: \.self) { column in
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.01))
                                            .frame(width: 16, height: 16)
                                            .overlay {
                                                if grid.images[row][column] != "" && grid.images[row][column] != nil{
                                                    Image(grid.images[row][column]!)
                                                }
                                            }
                                            .onTapGesture {
                                                
                                                if isErazerSelected {
                                                    print("Erazer selected : \(isErazerSelected)")
                                                    selectedImage = nil
                                                    grid.images[row][column] = ""
                                                }
                                               
                                                if let image = self.selectedImage {
                                                    grid.images[row][column] = image
                                                    lastRow = row
                                                    lastColumn = column
                                                }
                                            }
                                            .contextMenu(ContextMenu(menuItems: {
                                                Button{
                                                    
                                                } label:{
                                                    Text("Show collisions")
                                                }
                                               
                                                Button{
                                                    
                                                } label:{
                                                    Text("Edit collisions")
                                                }
                                                
                                                Button{
                                                    
                                                } label:{
                                                    Text("Add level teleporter ")
                                                }
                                            }))
  
                                            .border(Color.black, width: 0.1)

                                    }
                                }
                            }
                        }
                       
                    }
                    
                    
                    
                    
                    
                }
                .scaleEffect(zoomLevel)
                
                
               
                
                    
                
                
                Spacer()
                
                HStack{
                    
                    Spacer()
                    
                    
                    
                    Toggle(isOn: $displayBackground) {
                        Text("Background")
                    }
                    
                    Toggle(isOn: $displayForeground) {
                        Text("Foreground")
                    }
                   
                    Toggle(isOn: $displayAllPassTrough) {
                    Text("AllPassTrough")
                }
                    
                    Button(action: {zoomLevel += 0.1}) {Text("+")}
                    
                    Button(action: {zoomLevel -= 0.1}) {Text("-")}
                    
                    Button(action: {zoomLevel = 1.0}) {Text("Real Size")}
                    
                    Button{
                        isErazerSelected.toggle()
                    } label: {
                        Text("Erazer")
                            .foregroundStyle(getErazerColor())
                    }
                    
                    Button{
                        showResetAlert = true
                    } label: {
                        Text("Reset level")
                            .bold()
                            .foregroundStyle(.red)
                            
                    }
                    
                    
                    if lastRow != nil && lastColumn != nil{
                        Button(action: {grid.images[lastRow!][lastColumn!] = ""}) {Text("Ctrl Z")}
                    }
                    
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text("Make JSON")
                    }
                    Spacer()
                    
                    
                }
                
            }
            Spacer()
            
            
        }
        .padding()
        .alert(isPresented: $showResetAlert, content: {
            Alert(title: Text("Reset Level"),
                  message: Text("Are you sure. Take a brake and Think ..."),
                  primaryButton: .destructive(Text("Reset level")){grid = createGrid(rows: 8, columns: 16)},
                  secondaryButton: .cancel())
                        
        })
    }
    
    
    
    
    private func getColorBackground() -> Color {
        if selectedBackground == nil {
            return Color.pink.opacity(0.1)
        } else {
            return Color.clear
        }
    }
    
    
    private func getErazerColor() -> Color {
        if isErazerSelected{
            return Color.pink
        } else {
            return Color.green
        }
    }
    
    
}

