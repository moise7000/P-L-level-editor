import SwiftUI
import AppKit

struct PlaygroundView: View {
    
//------------------Show------------------------//
    @State private var showSucces: Bool = false
    @State private var showJson: Bool = false
    


    
//--------------------Data to Export in EditView-------------//
    @State private var jsonSelected: [String:Any]? = nil
    @State private var dataGrid: LevelGridForItem? = nil
    @State private var grid: LevelGrid? = nil
    
    
//--------------------Chekmark------------------------//
    let a: CGFloat = 15
    let b: CGFloat = 20
    let c: CGFloat = 30
    let d: CGFloat = 15
    @State private var animate = false
    
    var body: some View {
        
        
        
        VStack{
            Spacer()
            HStack{
                Image("json_icon")
                    .resizable()
                    .frame(width: 30,height: 30)
                
                //NavigationLink
                if showJson && dataGrid != nil && dataGrid!.name != nil && grid != nil {
                    NavigationLink {
                        
                        EditLevelView(dataGrid: dataGrid!, grid: grid!)
                    } label: {
                        Text("Edit level : " + dataGrid!.name!)
                            .foregroundStyle(Color.green)
                    }

                } else {
                    Text("Select a JSON Level File")
                        .foregroundStyle(Color.pink)
                }
    
            }
           
            
            Spacer()
            
            
            Button{
                let panel = NSOpenPanel()
                panel.allowedFileTypes = ["json"]
                panel.begin { (result) in
                    if result == .OK {
                        let url = panel.url
                        // Utilisez l'URL pour lire le fichier JSON
                        if let url = url {
                            showJson = true
                            showSucces = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showSucces = false
                            }
                            
                            if let jsonLevel = readJSON(url: url) {
                                print(jsonLevel)
                                jsonSelected = jsonLevel
                                if let jsonLevelGrid = JSONToLevelGridForItem(jsonDictionary: jsonLevel){
                                    dataGrid = jsonLevelGrid
                                    
                                    guard dataGrid!.background != nil else {
                                        print("[!] ERROR : Impossible to get the backgroud name.")
                                        return
                                    }
                                    
                                    //let validBackgroundName = "getImageNameFromResourceString(from: dataGrid!.background!)"
                                
                                   
                                    //dataGrid?.setBackground(background: dataGrid?.background ?? "default_background")
                                    
                                    
                                } else {
                                    print("[!] ERROR : Impossible to convert JSON file into a LevelGridForItem instance.")
                                }
                                
                                if let jsonGrid = imageNamesGridFromJSON(from: jsonLevel) {
                                    grid = jsonGrid
                                } else {
                                    print("[!] ERROR: Impossible to get the grid (image grid) from JSON.")
                                }
                                
                            } else {
                                print("[!] ERROR : Impossible to read JSON file.")
                            }
                            
                           
                        }
                    }
                }

                
                
                
            } label: {
                Text(jsonSelected == nil ? "Open JSON File" : "Select another JSON File")
                    .padding()
                }
            .popover(isPresented: $showSucces) {
                VStack{
                    Text("Succes")
                        .bold()
                        .font(.title)
                        .padding()
                        .foregroundStyle(.green)
                    
                    GeometryReader { geometry in
                        let center = geometry.frame(in: .local).center
                        
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 8)
                                .frame(width: 150, height: 150)
                                .foregroundStyle(Color.green)

                            Path { path in
                                path.move(to: CGPoint(x: center.x - a, y: center.y))
                                path.addLine(to: CGPoint(x: center.x, y:center.y + b ))
                                path.addLine(to: CGPoint(x: center.x + c, y:center.y - b - d ))
                                
                            }
                            .stroke(lineWidth: 5)
                            .trim(from: 0, to: animate ? 1 : 0)
                            .animation(.easeInOut(duration: 0.5))
                            .foregroundStyle(Color.green)
                        }
                        
                    }
                        .onAppear {
                            withAnimation {
                                animate = true
                            }
                        }
                    Spacer()
                }
                .frame(width: 300, height: 300)
                
                    
                
                
                
            }
            
            
            Spacer()
            
        }
        .navigationTitle("JSON File")
        
        
        
        
        
    }
}

