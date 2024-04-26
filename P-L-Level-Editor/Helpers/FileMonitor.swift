import SwiftUI
import Combine
import AppKit

class FileMonitor: ObservableObject {
    var source: DispatchSourceFileSystemObject?
    @Published var files: [String] = []
    @Published var EntitiesFiles: [String] = []
    @Published var StrcuturesFiles: [String] = []
    @Published var BackgroundFiles: [String] = []
    
    
    var url: URL? {
        didSet {
            if let url = url {
                startMonitoringFolder(url: url)
                DispatchQueue.main.async {
                    self.printAllFilesInFolder(url: url)
                }
            }
        }
    }

    func startMonitoringFolder(url: URL) {
        let descriptor = open(url.path, O_EVTONLY)
        source = DispatchSource.makeFileSystemObjectSource(fileDescriptor: descriptor, eventMask: .write, queue: DispatchQueue.global())
        
        source?.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                self?.updateFiles(url: url)
            }
        }
        
        source?.setCancelHandler {
            close(descriptor)
        }
        
        source?.resume()
    }
    
    func updateFiles(url: URL) {
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
            DispatchQueue.main.async {
                self.files = fileURLs.map { $0.lastPathComponent }
            }
        } catch {
            print("Error while enumerating files \(url.path): \(error.localizedDescription)")
        }
    }
    
    func printAllFilesInFolder(url: URL) {
        let fileManager = FileManager.default
        let enumerator = fileManager.enumerator(atPath: url.path)
        
        while let file = enumerator?.nextObject() as? String {
            print(url.appendingPathComponent(file).path)
        }
    }
}


class AssetsFileMonitorSingleton {
    static let shared = AssetsFileMonitorSingleton()
    
    
    @AppStorage("selectedDirectory") var selectedDirectory: String = ""
    
    
    @Published var files: [URL] = []
    private var assets: [Assets] = []
   
    func updateDirectory(newDirectory: String) -> Void {
        self.selectedDirectory = newDirectory
    }
    
    
    
    
    private func loadFiles() -> Void {
        guard !selectedDirectory.isEmpty, let url = URL(string: selectedDirectory) else { return }
        
        let fileManager = FileManager.default
        let enumerator = fileManager.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [])
        
        files.removeAll()
        
        while let url = enumerator?.nextObject() as? URL {
            do {
                let resourceValues = try url.resourceValues(forKeys: [.isRegularFileKey])
                if resourceValues.isRegularFile!, url.pathExtension == "png" {
                    files.append(url)
                    
                    
                }
            } catch {
                print("Erreur lors de la lecture des propriétés du fichier: \(error)")
            }
        }
    }
    
    private func transformFilesIntoAssets() -> Void {
        self.loadFiles()
        self.assets.removeAll()
        for file in files {
            let urlString = fromUrlToString(from: file)
            if let type = getTypeFromUrlString(from: urlString) {
       
                if let imageName = getImageNameFromUrlString(from: urlString) {
                    let newAsset = Assets(id: imageName, type: type, image: imageName, url: file)
                   
                    self.assets.append(newAsset)
                } else {
                    print("[!] ERROR : Impossible to get the imageName of this file : \(file)")
                }
            } else {
                print("[!] ERROR : Impossible to get the type of this file : \(file)")
            }
            
        }
    }
    
    func loadAssets() -> Void {
        self.transformFilesIntoAssets()
    }
    
    func getAssets() -> [Assets] {
        return self.assets
    }
    
    func refresh() -> Void {
        self.loadFiles()
        self.loadAssets()
    }
    
    func DEBUG() -> Void {
        print("[DEBUG] Assets monitred : \(self.assets)")
        print("[DEBUG] files monitred : \(self.files)")
    }
    
    
    
    
    
    
    
    
    
    
}



