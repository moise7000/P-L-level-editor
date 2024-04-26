import SwiftUI
import UniformTypeIdentifiers

struct FileMonitorTestView: View {
    
    @State private var images = [URL]()
    @AppStorage("selectedDirectory") var selectedDirectory: String = ""
    
    var body: some View {
        
        NavigationStack{
            VStack {
                Button {
                    let openPanel = NSOpenPanel()
                    openPanel.canChooseFiles = false
                    openPanel.canChooseDirectories = true
                    
                    if openPanel.runModal() == .OK {
                        selectedDirectory = openPanel.url!.path
                        loadImages()
                        
                        AssetsFileMonitorSingleton.shared.updateDirectory(newDirectory: selectedDirectory)
                        AssetsFileMonitorSingleton.shared.refresh()
                        
                    }
                } label: {
                    VStack{
                        Text("Choose an Assets Folder")
                        Text("Choose src !")
                            .foregroundStyle(.pink)
                            .font(.caption)
                    }
                   
                    
                    
                }
                .padding()
                
                
                GeometryReader { geometry in
                    let columns = Int(geometry.size.width / 100)
                    let gridLayout = Array(repeating: GridItem(.flexible()), count: columns)

                    ScrollView {
                        LazyVGrid(columns: gridLayout, spacing: 20) {
                            
                            ForEach(images, id:\.self) { url in
                                Image(nsImage: NSImage(contentsOf: url)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    
                                    
                            }
      
                            
                        }
                        .padding(.all, 10)
                    }
                    .onAppear(perform: loadImages)
                }
                
                
                
            }
            .padding()
        }
        
        
       
    }
    
    func loadImages() {
        guard !selectedDirectory.isEmpty, let url = URL(string: selectedDirectory) else { return }
        
        let fileManager = FileManager.default
        let enumerator = fileManager.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [])
        
        images.removeAll()
        
        while let url = enumerator?.nextObject() as? URL {
            do {
                let resourceValues = try url.resourceValues(forKeys: [.isRegularFileKey])
                if resourceValues.isRegularFile!, url.pathExtension == "png" {
                    images.append(url)
                    
                    
                }
            } catch {
                print("Erreur lors de la lecture des propriétés du fichier: \(error)")
            }
        }
    }
}

