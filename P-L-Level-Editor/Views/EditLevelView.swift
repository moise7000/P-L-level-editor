//
//  EditLevelView.swift
//  levelEditor
//
//  Created by ewan decima on 20/04/2024.
//

import SwiftUI



struct EditLevelView: View {
//----------------------------// VAR //----------------------------//
    @State var dataGrid: LevelGridForItem
    @State var grid: LevelGrid
    
    

    


//------------------//Assets//-------------------------------------------------------------------------//
    let structureAssets = affectAssetsType(imageNames: STRUCTURE_NAMES , type: AssetsType.STRUCTURE)
    let entityAssets = affectAssetsType(imageNames: ENTITY_NAMES, type: AssetsType.ENTITY)
    let backgroundAssets = affectAssetsType(imageNames: BACKGROUND_NAMES, type: AssetsType.BACKGROUND)
    @State private var selectedImage: URL?
    @State private var selectedBackground: URL?
    @State private var selectedAsset: Assets?
    

    let backgroundNames = BACKGROUND_NAMES

//-------------------------------//Environement//------------------------------------------------------//
    @State private var zoomLevel: CGFloat = 4.0
    @State private var isErazerSelected: Bool = false
    @State private var showingEntity: Bool = false
    @State private var showingStructure: Bool = true
    @State private var showingBackground: Bool = false
    @State private var displayBackground: Bool = true
    @State private var displayForeground: Bool = true
    @State private var displayAllPassTrough: Bool = false
    @State private var displayGrid: Bool = true
    
    
    @State private var levelNameInView: String = "noNameLevel"
    @State private var isEditing: Bool = false
    
//--------------------// ALERT //-------------------------------------//
    @State private var showResetAlert: Bool = false
    @State private var showJSONAlert: Bool = false
    @State private var showAlert: Bool = false
    @State private var activeAlert: ActiveAlert = .resetAlert

    
    
//--------------------// PopOver //--------------------//
    @State private var showSelectedImageZOOM = false
    @State private var showLevelNamePopover = false
    @State private var showDetailPopover: [[Bool]] =  Array(repeating: Array(repeating: false, count: 16), count: 8)
    @State private var showEditAPTPopover: [[Bool]] = Array(repeating: Array(repeating: false, count: 16), count: 8)
    @State private var showCollisionsPopover: [[Bool]] = Array(repeating: Array(repeating: false, count: 16), count: 8)
    @State private var showTeleporterPopover: [[Bool]] = Array(repeating: Array(repeating: false, count: 16), count: 8)
    @State private var aptData: [[[DirectionAPT]]] = Array(repeating: Array(repeating: [], count: 16), count: 8)
    @State private var teleporterData: [[String]] = Array(repeating: Array(repeating: "none", count: 16), count: 8)
    
    
    
    
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
                
                
                
                //MARK: ENTITIES Scrollbar
                if showingEntity{
                    ScrollView{
                        VStack{
                            ForEach(getAssetsByType(allAssets, assetType: AssetsType.ENTITY), id: \.self) { entityAsset in
                                Image(nsImage: NSImage(contentsOf: entityAsset.url!)!)
                                    .resizable()
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
                
                
                //MARK: STRUCTURES Scrollbar
                if showingStructure{
                    ScrollView{
                        VStack{
                            ForEach(getAssetsByType(allAssets, assetType: AssetsType.STRUCTURE), id: \.self) { structureAsset in
                                Image(nsImage: NSImage(contentsOf: structureAsset.url!)!)
                                    .resizable()
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
                
                
                //MARK: BACKGROUND Scrollbar
                if showingBackground{
                    ScrollView{
                        VStack{
                            ForEach(getAssetsByType(allAssets, assetType: AssetsType.BACKGROUND), id: \.self) { background in
                                Image(nsImage: NSImage(contentsOf: background.url!)!)
                                    .resizable()
                                    .interpolation(.none)
                                    .scaleEffect(1.25)
                                    .padding()
                                    .onTapGesture {
                                        isErazerSelected = false
                                        self.selectedBackground = background.url
                                        dataGrid.background = background.url
                                        
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
                        
                        VStack{
                            if dataGrid.getName() != nil || dataGrid.getName() != "" {
                                HStack{
//                                    Text("Current level name : ")
//                                    Text(dataGrid.getName()!)
//                                        .foregroundStyle(.pink)
                                    
                                        if isEditing {
                                            TextField("Entrez du texte", text: $levelNameInView, onCommit: {
                                                isEditing = false
                                            })
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .onTapGesture(count: 2) {
                                                isEditing = true
                                            }
                                        } else {
                                            Text(levelNameInView)
                                                .foregroundStyle(.pink)
                                                .onTapGesture(count: 2) {
                                                    isEditing = true
                                                }
                                            }
                                        
                                    Spacer()
                                }
                                .onAppear{
                                    levelNameInView = dataGrid.name ?? "noNameLevel"
                                }
                            } else {
                                // No level name
                            }
                            
                            if selectedAsset != nil {
                                HStack{
                                    Text("Selected image : ")
                                    Image(nsImage: NSImage(contentsOf: selectedAsset!.url!)!)
                                        .resizable()
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
                                                    .scaledToFit()
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
                        }
                       
                        
                    
                        
                        if selectedBackground != nil {
                            HStack{
                                Text("Current background : ")
                                Image(nsImage: NSImage(contentsOf: selectedBackground!)!)
                                    .resizable()
                                    .interpolation(.none)
                                    
                                    .scaleEffect(0.7)
                                Spacer()
                                Button{
                                    selectedBackground = nil
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
                                if selectedBackground != nil {
                                    Image(nsImage: NSImage(contentsOf: selectedBackground!)!)
                                        .resizable()
                                        .interpolation(.none)
                                        .scaleEffect(1.25)
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
                                                if grid.images[row][column] != nil {
                                                    
                                                    if isImageSizeValid(grid.images[row][column]!){
                                                        Image(nsImage: NSImage(contentsOf: grid.images[row][column]!)!)
                                                        
                                                    } else {
                                                        Image(nsImage: NSImage(contentsOf: grid.images[row][column]!)!)
                                                            .offset(y: -8)
                                                    }
                                                    
                                                    
                                                }
                                            }
                                            .onTapGesture {
                                                
                                                if selectedImage != nil && selectedAsset != nil{
                                                    // Affect image to the right postion in the structure
                                                    grid.images[row][column] = selectedImage

                                                    
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
//                                                Button{
//                                                    print(aptData[row][column])
//                                                } label:{
//                                                    Text("DEBUG")
//                                                }

                                                
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
                                                                    
                                                                    // Affect the changement to the dataGrid
                                                                    dataGrid.setAllAPT(data: aptData)
                                                                } label: {
                                                                    Text("Delete NORTH")
                                                                        .foregroundStyle(.pink)
                                                                }
                                                            } else {
                                                                //MARK: Case NORTH not selected
                                                                Button{
                                                                    aptData[row][column].append(DirectionAPT.NORTH)
                                                                    
                                                                    // Affect the changement to the dataGrid
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
                                                                        
                                                                        // Affect the changement to the dataGrid
                                                                        dataGrid.setAllAPT(data: aptData)
                                                                    } label: {
                                                                        Text("Delete WEST")
                                                                            .foregroundStyle(.pink)
                                                                    }
                                                                } else {
                                                                    //MARK: Case WEST not selected
                                                                    Button{
                                                                        aptData[row][column].append(DirectionAPT.WEST)
                                                                        
                                                                        // Affect the changement to the dataGrid
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
                                                                        
                                                                        // Affect the changement to the dataGrid
                                                                        dataGrid.setAllAPT(data: aptData)
                                                                    } label: {
                                                                        Text("Delete EAST")
                                                                            .foregroundStyle(.pink)
                                                                    }
                                                                } else {
                                                                    //MARK: Case EAST not selected
                                                                    Button{
                                                                        aptData[row][column].append(DirectionAPT.EAST)
                                                                        
                                                                        // Affect the changement to the dataGrid
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
                                                                    
                                                                    // Affect the changement to the dataGrid
                                                                    dataGrid.setAllAPT(data: aptData)
                                                                } label: {
                                                                    Text("Delete EAST")
                                                                        .foregroundStyle(.pink)
                                                                }
                                                            } else {
                                                                //MARK: Case SOUTH not selected
                                                                Button{
                                                                    aptData[row][column].append(DirectionAPT.SOUTH)
                                                                    
                                                                    // Affect the changement to the dataGrid
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
                                                HStack{
                                                    Text("Comming Soon !")
                                                        .padding()
                                                }
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
                        print(dataGrid.isEmpty())
                        dataGrid.setAllAPT(data: aptData)
                        dataGrid.setName(name: levelNameInView)
                        
//---------------------------------------------------------------------------------------------//
                        // Handle ERROR//
                        
                        if dataGrid.isEmpty() {
                            activeAlert = .emptyLevelAlert
                            showAlert = true
                        } else {
                            if !dataGrid.containsTeleporter() {
                                //MARK: [!] HERE [!]
                                
//                                activeAlert = .noTeleportern
//                                showAlert = true
                            } else {
                                // JSON Stuff
                            }
                            
                            let serializedData = dataGrid.serializeForJSON()
                            if let url = showSavePanel() {
                                do {
                                    let jsonData = try JSONSerialization.data(withJSONObject: serializedData, options: .prettyPrinted)
                                    try jsonData.write(to: url)
                                    print("JSON data was written to the file successfully.")
                                } catch {
                                    print("Failed to write JSON data to the file: \(error)")
                                    activeAlert = .jsonAlert
                                    showAlert = true
                                }
                            }
                            
                        }
                        
//---------------------------------------------------------------------------------------------//
                        
                        
                        print("MakeJson pressed")
                        
                        
                        
                        
                    } label: {
                        Text("Make JSON")
                    }
                    
                    Spacer()
                    
                    
                }
                
            }
            .onAppear{
                self.selectedBackground = dataGrid.background ?? nil
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
                             message: Text("Error during the export of JSON"),
                             primaryButton: .cancel(),
                             secondaryButton: .default(Text(""))
                       )
            case .emptyLevelAlert:
                return Alert(title: Text("Serioulsy ?"),
                             message: Text("You really want to make an empty level ? Think about it."),
                             primaryButton: .cancel(),
                             secondaryButton: .default(Text(""))
                       )
            
                              
            case .noTeleporter:
                return Alert(title: Text("[!] Teleporter To Scene [!]"),
                             message: Text("You have not added a teleporter... Are you sure about it ?"),
                             primaryButton: .cancel(Text("Add teleporter")),
                             secondaryButton: .default(Text("Let me cook"), action:{print("Here")})
                             
                       )
           
            
            }
        }
        .navigationTitle("Level Editor")
        
    }
    
    
    
    
    //MARK: Private functions
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

