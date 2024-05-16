import SwiftUI
import UniformTypeIdentifiers

struct LevelGraphView: View {
    
    @State private var levels = [URL]()
    @AppStorage("selectedLevelGraphDirectory") var selectedDirectory: String = ""
    
    var body: some View {
        
        NavigationStack{
            VStack {
                
                HStack{
                    Text("Current scenes selected folder : ")
                    Text("\(selectedDirectory)")
                        .foregroundStyle(.pink)
                    
                    Spacer()
                    Button {
                        let openPanel = NSOpenPanel()
                        openPanel.canChooseFiles = false
                        openPanel.canChooseDirectories = true
                        
                        if openPanel.runModal() == .OK {
                            selectedDirectory = openPanel.url!.path
                            loadLevels()
                            
                            LevelsGraphFileMonitorSingleton.shared.updateDirectory(newDirectory: selectedDirectory)
                            LevelsGraphFileMonitorSingleton.shared.refresh()
                            
                        }
                    } label: {
                        VStack{
                            Text("Choose the Scene Folder")
                        }
                        
                       
                        
                        
                    }
                    .padding()
                }
                
                HStack{
                    Text("Scenes : ")
                    Text("\(LevelsGraphFileMonitorSingleton.shared.getLevelsNumber())")
                        .foregroundStyle(.pink)
                    Spacer()
                    
                }
                
                List{
                    ForEach(levels, id:\.self) { levelUrl in
                        
                        Text(getLastElementFromUrlString(from: levelUrl.absoluteString))
                            .onTapGesture {
                                readJSON(url: levelUrl)
                            }
                            
                            
                            
                    }
                }
                .listStyle(.plain)
                .onAppear(perform:loadLevels)

            }
            .padding()
        }
        
        
       
    }
    
    func loadLevels() {
        guard !selectedDirectory.isEmpty, let url = URL(string: selectedDirectory) else { return }
        
        let fileManager = FileManager.default
        let enumerator = fileManager.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [])
        
        levels.removeAll()
        
        while let url = enumerator?.nextObject() as? URL {
            do {
                let resourceValues = try url.resourceValues(forKeys: [.isRegularFileKey])
                if resourceValues.isRegularFile!, url.pathExtension == "json" {
                    levels.append(url)
                    
                    
                }
            } catch {
                print("Erreur lors de la lecture des propriétés du fichier: \(error)")
            }
        }
        print(levels)
    }
    
    
}

