import SwiftUI
import AppKit

struct FileManagerTesterView: View {
    @State private var images: [NSImage] = []
    

    var body: some View {
        VStack {

            
            GeometryReader { geometry in
                let columns = Int(geometry.size.width / 100)
                let gridLayout = Array(repeating: GridItem(.flexible()), count: columns)
                
                
                ScrollView {
                    LazyVGrid(columns: gridLayout, spacing: 20) {
                        ForEach(images.indices, id: \.self) { index in
                            Image(nsImage: self.images[index])
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                        }

                        Button{
                            print("button pressed")
                        } label: {
                            Text("Add Assets")
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.pink)
     
                        }
                        .opacity(0.5)

                    }
                    .padding(.all, 10)
                }
                .padding()
                
               
            }
            
            
            
            
            
            
            

            Button("Ouvrir") {
                
                let panel = NSOpenPanel()
                panel.canChooseDirectories = true
                panel.begin { (result) in
                    if result == NSApplication.ModalResponse.OK {
                        let url = panel.url!
                        let fileManager = FileManager.default
                        do {
                            let fileURLs = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
                            
                            images = fileURLs.compactMap { NSImage(contentsOf: $0) }
                            
                        } catch {
                            print("Erreur lors de la lecture du contenu du dossier: \(error)")
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}
