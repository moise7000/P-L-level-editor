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


class AssetsFileMonitor: ObservableObject{
    @Published var files: [URL] = []
    @Published var EntitiesFiles: [URL] = []
    @Published var StrcuturesFiles: [URL] = []
    @Published var BackgroundFiles: [String] = []
    
}



