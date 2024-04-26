import SwiftUI
import UniformTypeIdentifiers

struct FileMonitorTestView: View {
    @State private var images = [URL]()
    @AppStorage("selectedDirectory") var selectedDirectory: String = ""
    
    var body: some View {
        VStack {
            Button("Choisir un dossier") {
                let openPanel = NSOpenPanel()
                openPanel.canChooseFiles = false
                openPanel.canChooseDirectories = true
                
                if openPanel.runModal() == .OK {
                    selectedDirectory = openPanel.url!.path
                    loadImages()
                }
            }
            
            List(images, id: \.self) { url in
                Image(nsImage: NSImage(contentsOf: url)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .onAppear(perform: loadImages)
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

