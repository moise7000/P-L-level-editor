//
//  LevelsGraphMonitor.swift
//  P-L-Level-Editor
//
//  Created by ewan decima on 15/05/2024.
//

import Foundation
import SwiftUI
import Combine
import AppKit


class LevelsGraphFileMonitorSingleton {
    static let shared = LevelsGraphFileMonitorSingleton()
    
    
    @AppStorage("selectedLevelGraphDirectory") var selectedDirectory: String = ""
    
    
    @Published var files: [URL] = []
    private var edges: [String : [String]] = [:]
    private var nodes: [DraggableNode] = []
    
   
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
                if resourceValues.isRegularFile!, url.pathExtension == "json" {
                    files.append(url)
                    
                    
                }
            } catch {
                print("Erreur lors de la lecture des propriétés du fichier: \(error)")
            }
        }
    }
    
    private func removeData() -> Void {
        self.edges.removeAll()
        self.nodes.removeAll()
    }
    
    

    func getLevelsNumber() -> Int {
        return length(self.files)
    }
    
    
    private func transformJsonsIntoDicts() -> [[String:Any]] {
        var jsonDicts: [[String:Any]] = []
        for file in self.files {
            if let jsonDict = readJSON(url: file) {
                jsonDicts.append(jsonDict)
            } else {
                print("[!] ERROR : this \(file) can't be read.")
            }
        }
        return jsonDicts
    }
    
    func makeGraph() -> Void {
        self.removeData()
        
        let jsonDict = self.transformJsonsIntoDicts()
        let graph = createGraph(from: jsonDict)
        self.nodes = Array(graph.nodes.values)
        self.edges = graph.edges
    }
    
    
    func getEdges() -> [String : [String]]{
        return self.edges
    }
    func getNodes() -> [DraggableNode]{
        return self.nodes
    }
    
    func refresh() -> Void {
        self.removeData()
        self.loadFiles()
        self.makeGraph()
        
    }
    
    
    func isSelectedDirectory() -> Bool {
        return self.selectedDirectory != ""
    }
    
    func getDirectory() -> String {
        return self.selectedDirectory
    }
    
    
    func isFilesMonitoredEmpty() -> Bool {
        return self.files == []
    }
    
    func DEBUG() -> Void {
        print("[DEBUG] Edges: \(self.getEdges())")
        print("[DEBUG] Nodes: \(self.getNodes())")
        print("[DEBUG] graph: \(self.getEdges())")
        
    }
    
}
