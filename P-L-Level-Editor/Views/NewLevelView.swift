
//
//  TestView4.swift
//  levelEditor
//
//  Created by ewan decima on 15/04/2024.
//


import SwiftUI
import SwiftData
import AppKit

enum ActiveAlert {
    case resetAlert, jsonAlert, emptyLevelAlert, noTeleporter
}

struct NewLevelView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    let imageNames = STRUCTURE_NAMES
    let entityNames = ENTITY_NAMES
    let backgroundNames = BACKGROUND_NAMES
    
    
    let structureAssets = affectAssetsType(imageNames: STRUCTURE_NAMES , type: AssetsType.STRUCTURE)
    let entityAssets = affectAssetsType(imageNames: ENTITY_NAMES, type: AssetsType.ENTITY)
    let backgroundAssets = affectAssetsType(imageNames: BACKGROUND_NAMES, type: AssetsType.BACKGROUND)
    
    
    @State private var grid: LevelGrid = createGrid(rows: 8, columns: 16)                       //Grid = This grid contains the URL of all the level Images
    @State private var selectedImage: URL?
    @State private var selectedBackground: Assets?                                              //Must nbe URL?
    @State private var currentLevelName: String = ""
    
    
    @State private var dataGrid: LevelGridForItem = LevelGridForItem(rows: 8, columns: 16)
    @State private var selectedAsset: Assets?
    
    
    
    
    @State private var zoomLevel: CGFloat = 3.0
    @State private var isErazerSelected: Bool = false
    @State private var lastRow: Int?
    @State private var lastColumn: Int?
    
    @State private var showingEntity: Bool = false
    @State private var showingStructure: Bool = true
    @State private var showingBackground: Bool = false
    
    @State private var displayBackground: Bool = true
    @State private var displayForeground: Bool = true
    @State private var displayAllPassTrough: Bool = false
    @State private var displayGrid: Bool = true
    
    
    //--------------------// ALERT //--------------------//
    @State private var showResetAlert: Bool = false
    @State private var showJSONAlert: Bool = false
    
    @State private var showAlert: Bool = false
    @State private var activeAlert: ActiveAlert = .resetAlert
    //--------------------------------------------------//
    
    
    
    
    //--------------------// PopOver //--------------------//
    @State private var showNewLevelSucces = false
    @State private var showSelectedImageZOOM = false
    @State private var showLevelNamePopover = false
    @State private var showLevelNameJSONPopover = false
    @State private var showDetailPopover: [[Bool]]
    @State private var showEditAPTPopover: [[Bool]]
    @State private var showCollisionsPopover: [[Bool]]
    @State private var showTeleporterPopover: [[Bool]]
    
    @State private var aptData: [[[DirectionAPT]]]
    @State private var teleporterData: [[String]]
    @State private var teleporterDataPositions: [[(Int, Int)]]
    init() {
        _showDetailPopover = State(initialValue: Array(repeating: Array(repeating: false, count: 16), count: 8))
        _showEditAPTPopover = State(initialValue: Array(repeating: Array(repeating: false, count: 16), count: 8))
        _showCollisionsPopover = State(initialValue: Array(repeating: Array(repeating: false, count: 16), count: 8))
        _aptData = State(initialValue: Array(repeating: Array(repeating: [], count: 16), count: 8))
        _showTeleporterPopover = State(initialValue: Array(repeating: Array(repeating: false, count: 16), count: 8))
        _teleporterData = State(initialValue: Array(repeating: Array(repeating: "none", count: 16), count: 8))
        _teleporterDataPositions = State(initialValue: Array(repeating: Array(repeating: (-1,-1), count: 16), count: 8))
        
    }
    
    @State private var testBoolAPT: Bool = false
    
    //----------------------------------------------------//
    
    let a: CGFloat = 1.0
    let b: CGFloat = 70.0
    let c: CGFloat = 2.0
    let d: CGFloat = 10.0
    @State private var rotation: Double = 0
    
    var body: some View {
        let allAssets = AssetsFileMonitorSingleton.shared.getAssets()
        
        
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
                            ForEach(getAssetsByType(allAssets, assetType: AssetsType.ENTITY), id: \.self) { entityAsset in
                                if NSImage(contentsOf: entityAsset.url!) != nil {
                                    Image(nsImage: NSImage(contentsOf: entityAsset.url!)!)
                                        .resizable()
                                        .interpolation(.none)
                                        .frame(width: 32, height: 32)
                                        .padding()
                                        .onTapGesture {
                                            isErazerSelected = false
                                            self.selectedAsset = entityAsset
                                            self.selectedImage = entityAsset.url
                                            
                                        }
                                }
                                
                                
                            }
                            
                        }
                    }
                }
                
                if showingStructure{
                    ScrollView{
                        VStack{
                            ForEach(getAssetsByType(allAssets, assetType: AssetsType.STRUCTURE), id: \.self) { structureAsset in
                                if NSImage(contentsOf: structureAsset.url!) != nil {
                                    Image(nsImage: NSImage(contentsOf: structureAsset.url!)!)
                                        .resizable()
                                        .interpolation(.none)
                                        .frame(width: 32, height: 32)
                                        .padding()
                                        .onTapGesture {
                                            isErazerSelected = false
                                            self.selectedAsset = structureAsset
                                            self.selectedImage = structureAsset.url
                                            
                                        }
                                }
                                
                            }
                        }
                    }
                }
                
                if showingBackground{
                    ScrollView{
                        VStack{
                            ForEach(getAssetsByType(allAssets, assetType: AssetsType.BACKGROUND), id: \.self) { background in
                                if NSImage(contentsOf: background.url!) != nil {
                                    Image(nsImage: NSImage(contentsOf: background.url!)!)
                                        .resizable()
                                        .interpolation(.none)
                                        .frame(width: 128, height: 64)
                                        .padding()
                                        .onTapGesture {
                                            isErazerSelected = false
                                            self.selectedBackground = background
                                            dataGrid.background = background.url
                                            
                                        }
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
                        if selectedAsset != nil && selectedAsset!.url != nil && NSImage(contentsOf: selectedAsset!.url!) != nil{
                            HStack{
                                Text("Selected image : ")
                                Image(nsImage: NSImage(contentsOf: selectedAsset!.url!)!)
                                    .resizable()
                                    .interpolation(.none)
                                    .frame(width: 32,height: 32)
                                    .onTapGesture {
                                        showSelectedImageZOOM = true
                                    }
                                    .onHover { hovering in
                                        if hovering {
                                            NSCursor(image: NSImage(named: "zoom_loupe")!, hotSpot: NSPoint(x: 0, y: 0)).push()
                                        } else {
                                            NSCursor.pop()
                                        }
                                    }
                                    .popover(isPresented: $showSelectedImageZOOM){
                                        HStack{
                                            Image(nsImage: NSImage(contentsOf: selectedAsset!.url!)!)
                                                .resizable()
                                                .interpolation(.none)
                                                .scaledToFit()
                                                .frame(width: 300,height: 300)
                                        }
                                        .frame(width: 400, height: 400)
                                    }
                                Spacer()
                                
                                
                            }
                            
                            
                        } else {
                            HStack{
                                Text("Selected image : ")
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 16, height: 16)
                                Spacer()
                                
                            }
                            
                        }
                        
                        
                        if selectedBackground != nil && NSImage(contentsOf: selectedBackground!.url!) != nil {
                            HStack{
                                Text("Current background : ")
                                Image(nsImage: NSImage(contentsOf: selectedBackground!.url!)!)
                                    .resizable()
                                    .interpolation(.none)
                                    .frame(width: 64, height: 32)
                                Spacer()
                                Button{
                                    selectedBackground = nil
                                    // delete background from dataGrid
                                    dataGrid.background = nil
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
                                if selectedBackground != nil && NSImage(contentsOf: selectedBackground!.url!) != nil {
                                    Image(nsImage: NSImage(contentsOf: selectedBackground!.url!)!)
                                        .interpolation(.none)
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
                                                // display image if image exists
                                                if grid.images[row][column] != nil{
                                                    
                                                    if isImageSizeValid(grid.images[row][column]!) && NSImage(contentsOf: grid.images[row][column]!) != nil{
                                                        Image(nsImage: NSImage(contentsOf: grid.images[row][column]!)!)
                                                            .resizable()
                                                            .interpolation(.none)
                                                            .aspectRatio(contentMode: .fill)
                                                        
                                                    }
                                                    else {
                                                        let imageSize =  getSize(grid.images[row][column]!)
                                                        if NSImage(contentsOf: grid.images[row][column]!) != nil {
                                                            Image(nsImage: NSImage(contentsOf: grid.images[row][column]!)!)
                                                                .interpolation(.none)
                                                                .offset(y: getInvalidImageOffset(grid.images[row][column]!) ?? 0)
                                                        }
                                                    }
                                                    
                                                    
                                                }
                                            }
                                            .onTapGesture {
                                                
                                                if selectedImage != nil && selectedAsset != nil{
                                                    // Affect image to the right postion in the structure
                                                    grid.images[row][column] = selectedImage
                                                    lastRow = row
                                                    lastColumn = column
                                                    
                                                    // Add gridItem to the dataGrid
                                                    dataGrid.setAsset(row, column, asset: selectedAsset!)
                                                }
                                                
                                                
                                                
                                                if isErazerSelected {
                                                    // Delete the image from the grid
                                                    selectedImage = nil
                                                    grid.images[row][column] = nil
                                                    
                                                    // Delete the image from the dataGrid
                                                    selectedAsset = nil
                                                    dataGrid.eraze(row, column)
                                                    
                                                    //Delete the APT data
                                                    aptData[row][column] = []
                                                }
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                            }
                                        
                                            .contextMenu(ContextMenu(menuItems: {
                                                Button{
                                                    print("[DEBUG] is level empty ? : \(dataGrid.isEmpty())")
                                                    print(aptData[row][column])
                                                    print(dataGrid.gridItems[row][column])
                                                    print(isImageSizeValid(grid.images[row][column]!))
                                                    print("TeleporterToScene: \(teleporterData[row][column])")
                                                } label:{
                                                    Text("DEBUG")
                                                }
                                                
                                                
                                                Button{
                                                    selectedAsset = nil
                                                    selectedImage = nil
                                                    showDetailPopover[row][column] = true
                                                    
                                                } label :{
                                                    Text("Information")
                                                    
                                                }
                                                
                                                
                                                if grid.images[row][column] != nil {
                                                    Button{
                                                        selectedAsset = nil
                                                        selectedImage = nil
                                                        showCollisionsPopover[row][column] = true
                                                        
                                                    } label:{
                                                        Text("Show collisions")
                                                    }
                                                } else {
                                                    Text("Show collisions")
                                                }
                                                
                                                if grid.images[row][column] != nil {
                                                    Button{
                                                        showEditAPTPopover[row][column] = true
                                                    } label:{
                                                        Text("Edit collisions")
                                                    }
                                                } else {
                                                    Text("Edit colissions")
                                                }
                                                
                                                if grid.images[row][column] != nil{
                                                    Button{
                                                        showTeleporterPopover[row][column] = true
                                                    } label:{
                                                        Text("Add level teleporter ")
                                                        
                                                    }
                                                } else {
                                                    Text("Add level teleporter ")
                                                }
                                                
                                                
                                            }))
                                            .popover(isPresented: $showDetailPopover[row][column]) {
                                                DetailView(dataGrid: dataGrid,
                                                           row: row,
                                                           column: column,
                                                           aptData: aptData,
                                                           a: a, b: b, c: c, d: d)
                                                
                                            }
                                            .popover(isPresented: $showEditAPTPopover[row][column]) {
                                                HStack{
                                                    VStack{
                                                        Text("Select All Pass Through")
                                                            .padding()
                                                        
                                                        VStack{
                                                            
                                                            if isIn(DirectionAPT.NORTH, in: aptData[row][column]){
                                                                //MARK: Case NORTH already selected
                                                                Button{
                                                                    aptData[row][column] = customRemove(DirectionAPT.NORTH, from: aptData[row][column])
                                                                    // affect the changement to the dataGrid
                                                                    dataGrid.setAllAPT(data: aptData)
                                                                    
                                                                } label: {
                                                                    Text("Delete NORTH")
                                                                        .foregroundStyle(.pink)
                                                                }
                                                            } else {
                                                                //MARK: Case NORTH not selected
                                                                Button{
                                                                    aptData[row][column].append(DirectionAPT.NORTH)
                                                                    // affect the changement to the dataGrid
                                                                    dataGrid.setAllAPT(data: aptData)
                                                                } label: {
                                                                    Text("NORTH")
                                                                }
                                                                
                                                            }
                                                            
                                                            
                                                            
                                                            
                                                            HStack{
                                                                if isIn(DirectionAPT.WEST, in: aptData[row][column]){
                                                                    //MARK: Case WEST already selected
                                                                    Button{
                                                                        aptData[row][column] = customRemove(DirectionAPT.WEST, from: aptData[row][column])
                                                                        
                                                                        // affect the changement to the dataGrid
                                                                        dataGrid.setAllAPT(data: aptData)
                                                                    } label: {
                                                                        Text("Delete WEST")
                                                                            .foregroundStyle(.pink)
                                                                    }
                                                                } else {
                                                                    //MARK: Case WEST not selected
                                                                    Button{
                                                                        aptData[row][column].append(DirectionAPT.WEST)
                                                                        // affect the changement to the dataGrid
                                                                        dataGrid.setAllAPT(data: aptData)
                                                                    } label: {
                                                                        Text("WEST")
                                                                    }
                                                                    
                                                                }
                                                                
                                                                Spacer()
                                                                
                                                                if isIn(DirectionAPT.EAST, in: aptData[row][column]){
                                                                    //MARK: Case EAST already selected
                                                                    Button{
                                                                        aptData[row][column] = customRemove(DirectionAPT.EAST, from: aptData[row][column])
                                                                        // affect the changement to the dataGrid
                                                                        dataGrid.setAllAPT(data: aptData)
                                                                    } label: {
                                                                        Text("Delete EAST")
                                                                            .foregroundStyle(.pink)
                                                                    }
                                                                } else {
                                                                    //MARK: Case EAST not selected
                                                                    Button{
                                                                        aptData[row][column].append(DirectionAPT.EAST)
                                                                        // affect the changement to the dataGrid
                                                                        dataGrid.setAllAPT(data: aptData)
                                                                    } label: {
                                                                        Text("EAST")
                                                                    }
                                                                    
                                                                }
                                                            }
                                                            .padding()
                                                            
                                                            if isIn(DirectionAPT.SOUTH, in: aptData[row][column]){
                                                                //MARK: Case SOUTH already selected
                                                                Button{
                                                                    aptData[row][column] = customRemove(DirectionAPT.SOUTH, from: aptData[row][column])
                                                                    // affect the changement to the dataGrid
                                                                    dataGrid.setAllAPT(data: aptData)
                                                                } label: {
                                                                    Text("Delete EAST")
                                                                        .foregroundStyle(.pink)
                                                                }
                                                            } else {
                                                                //MARK: Case SOUTH not selected
                                                                Button{
                                                                    aptData[row][column].append(DirectionAPT.SOUTH)
                                                                    // affect the changement to the dataGrid
                                                                    dataGrid.setAllAPT(data: aptData)
                                                                } label: {
                                                                    Text("EAST")
                                                                }
                                                                
                                                            }
                                                            
                                                        }
                                                        .padding()
                                                        
                                                    }
                                                    GeometryReader { geometry in
                                                        let center = geometry.frame(in: .local).center
                                                        
                                                        ZStack {
                                                            Rectangle()
                                                                .fill(Color.pink.opacity(0.2))
                                                                .frame(width: 100, height: 100)
                                                                .border(Color.blue, width: 2)
                                                            
                                                            makeAllPassTroughNorth(center: center, a: a, b: b, c: c, d: d)
                                                                .fill(isIn(DirectionAPT.NORTH, in: aptData[row][column]) ? Color.green : Color.pink)
                                                            
                                                            makeAllPassTroughSouth(center: center, a: a, b: b, c: c, d: d)
                                                                .fill(isIn(DirectionAPT.SOUTH, in: aptData[row][column]) ? Color.green : Color.pink)
                                                            
                                                            makeAllPassTroughEast(center: center, a: a, b: b, c: c, d: d)
                                                                .fill(isIn(DirectionAPT.EAST, in: aptData[row][column]) ? Color.green : Color.pink)
                                                            
                                                            makeAllPassTroughWest(center: center, a: a, b: b, c: c, d: d)
                                                                .fill(isIn(DirectionAPT.WEST, in: aptData[row][column]) ? Color.green : Color.pink)
                                                            
                                                            
                                                        }
                                                        .rotationEffect(.degrees(rotation))
                                                    }
                                                }
                                                .frame(width: 600, height: 300)
                                                
                                                
                                            }
                                            .popover(isPresented: $showCollisionsPopover[row][column]){
                                                CollisionsView(dataGrid: dataGrid,
                                                               row: row,
                                                               column: column,
                                                               aptData: aptData,
                                                               a: a, b: b, c: c, d: d)
                                            }
                                            .popover(isPresented: $showTeleporterPopover[row][column]) {
                                                VStack{
                                                    TextField("Level name", text: $teleporterData[row][column])
                                                    HStack{
                                                        Picker("X Position", selection: $teleporterDataPositions[row][column].0) {
                                                            ForEach(0..<16) {
                                                                Text("\($0)")
                                                            }
                                                        }
                                                        
                                                        
                                                        Picker("Y Position", selection: $teleporterDataPositions[row][column].1) {
                                                            ForEach(0..<8) {
                                                                Text("\($0)")
                                                            }
                                                        }
                                                        
                                                        
                                                    }
                                                    .padding()
                                                    
                                                    Button{
                                                        let formatedInput = formatNextLevelNameForTeleporter(teleporterData[row][column])
                                                        let xPosition = teleporterDataPositions[row][column].0
                                                        let yPosition = teleporterDataPositions[row][column].1
                                                        let teleporter = makeTeleporterToScene(nextLevelName: formatedInput, posX: xPosition, posY: yPosition)
                                                        dataGrid.setTeleporterToScene(row,
                                                                                      column,
                                                                                      teleporterToScene: teleporter)
                                                        showTeleporterPopover[row][column] = false
                                                    } label: {
                                                        Text("Save")
                                                    }
                                                    .disabled(saveConditionForTeleporter(row, column: column))
                                                    .keyboardShortcut(.defaultAction)
                                                    
                                                    
                                                }
                                                .padding()
                                                .frame(width: 300, height: 300)
                                            }
                                            .border(displayGrid ? Color.black : Color.clear, width: 0.1)
                                        
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
                    
                    Toggle(isOn: $displayGrid) {
                        Text("Grid")
                    }
                    
                    //                    Toggle(isOn: $displayAllPassTrough) {
                    //                    Text("AllPassTrough")
                    //                }
                    
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
                        print("reset pressed")
                        activeAlert = .resetAlert
                        showAlert = true
                    } label: {
                        Text("Reset level")
                            .bold()
                            .foregroundStyle(.red)
                        
                    }
                    
                    
                    
                    Spacer()
                    Button {
                        showLevelNamePopover = true
                        //Pick a level Name
                        //save in Swiftdata
                    } label: {
                        Text("Save Localy")
                    }
                    .popover(isPresented: $showLevelNamePopover) {
                        VStack{
                            Text("Current Level")
                            TextField("Pick a fancy name", text: $currentLevelName)
                                .padding()
                            
                            if isInputValid(currentLevelName) {
                                Button {
                                    print("save button pressed")
                                    dataGrid.setName(name: currentLevelName)
                                    dataGrid.save(modelContext: modelContext)
                                    dismiss()
                                    
                                    
                                    //save
                                } label: {
                                    Text("Save")
                                }
                                .keyboardShortcut(.defaultAction)
                            }
                            
                            
                        }
                        .frame(width: 400, height: 400)
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    Button {
                        
                        dataGrid.setAllAPT(data: aptData)
                        
                        if dataGrid.isEmpty() {
                            activeAlert = .emptyLevelAlert
                            showAlert = true
                        } else {
                            if !dataGrid.containsTeleporter() {
                                activeAlert = .noTeleporter
                                showAlert = true
                            } else {
                                showLevelNamePopover = true
                            }
                            
                            
                        }
                        
                        
                        
                    } label: {
                        Text("Make JSON")
                    }
                    .popover(isPresented: $showLevelNameJSONPopover) {
                        VStack{
                            Text("Current Level")
                            TextField("Pick a fancy name", text: $currentLevelName)
                                .padding()
                            
                            if isInputValid(currentLevelName) {
                                Button {
                                    print("save button pressed")
                                    print("[DEBUG] level name before affectation: \(dataGrid.getName())")
                                    dataGrid.setName(name: currentLevelName)
                                    print("[DEBUG] level name afeter affectation: \(dataGrid.getName())")
                                    
                                    //dataGrid.save(modelContext: modelContext)
                                    
                                    dataGrid.setAllAPT(data: aptData)
                                    let serializedData = dataGrid.serializeForJSON()
                                    if let url = showSavePanel() {
                                        do {
                                            print("[DEBUG] Serialized data : \(serializedData)")
                                            let jsonData = try JSONSerialization.data(withJSONObject: serializedData, options: .prettyPrinted)
                                            try jsonData.write(to: url)
                                            print("JSON data was written to the file successfully.")
                                            
                                            
                                            
                                        } catch {
                                            print("Failed to write JSON data to the file: \(error)")
                                            activeAlert = .jsonAlert
                                            showAlert = true
                                        }
                                    }
                                    
                                    
                                    
                                    //save
                                } label: {
                                    Text("Save")
                                }
                                .keyboardShortcut(.defaultAction)
                            }
                            
                            
                        }
                        .frame(width: 400, height: 400)
                    }
                    
                    Spacer()
                    
                    
                }
                
            }
            Spacer()
            
            
        }
        .padding()
        .alert(isPresented: $showAlert) {
            switch activeAlert{
            case .resetAlert:
                return Alert(title: Text("Reset Level"),
                             message: Text("Are you sure ? Take a break and think ..."),
                             primaryButton: .destructive(Text("Reset level")){
                    // Reste the grid
                    grid = createGrid(rows: 8, columns: 16)
                    
                    //Reset the dataGrid
                    dataGrid.reset()
                },
                             secondaryButton: .cancel())
                
            case .jsonAlert:
                return Alert(title: Text("JSON ..."),
                             message: Text("Error during the export of JSON. Call 9-1-1 !"),
                             primaryButton: .cancel(),
                             secondaryButton: .default(Text(""))
                )
                
            case .emptyLevelAlert:
                return Alert(title: Text("Seriously ?"),
                             message: Text("You really want to make an empty level ? Think about it."),
                             primaryButton: .cancel(),
                             secondaryButton: .default(Text(""))
                )
                
                
            case .noTeleporter:
                return Alert(title: Text("[!] Teleporter To Scene [!]"),
                             message: Text("You have not added a teleporter... Are you sure about it ?"),
                             primaryButton: .cancel(Text("Add teleporter")),
                             secondaryButton: .default(Text("Let me cook"), action: {showLevelNameJSONPopover = true})
                             
                )
                
                
                
            }
        }
        .onAppear{
            //self.dataGrid = LevelGridForItem(rows: 8, columns: 16)
        }
        .navigationTitle("Level Editor")
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
    
    private func saveConditionForTeleporter(_ row: Int, column : Int) -> Bool {
        teleporterDataPositions[row][column].0 == -1 || teleporterDataPositions[row][column].1 == -1  || teleporterData[row][column] == "none" || !isInputValid(teleporterData[row][column])
        
    }
}

