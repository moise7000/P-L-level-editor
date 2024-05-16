//
//  GraphModel.swift
//  P-L-Level-Editor
//
//  Created by ewan decima on 16/05/2024.
//

import Foundation


struct DraggableNode: Identifiable {
    let id: Int
    var position: CGPoint
    var label: String
}

struct Edge: Identifiable, Hashable {
    let id: Int
    let start: Int
    let end: Int
}



private func getEdgeIds(edges: [Edge]) -> [Int] {
    var ids:[Int] = []
    for edge in edges {
        ids.append(edge.id)
    }
    return ids
}

func makeNewEdgeId(edges: [Edge]) -> Int {
    let edgeIds = getEdgeIds(edges: edges)
    
    var max = 0
    for id in edgeIds {
        if id > max {
            max = id
        }
    }
    return max + 1
}

func getIdByLabel(_ nodes: [DraggableNode], label: String) -> Int {
    for node in nodes {
        if node.label == label {
            return node.id
        }
    }
    return -1
}




struct Level: Codable {
    let name: String
    var destinations:[String]
}



struct Graph {
    var nodes: [String: DraggableNode]
    var edges: [String: [String]]

    init() {
        self.nodes = [:]
        self.edges = [:]
    }

    mutating func addLevel(_ level: Level, position: CGPoint) {
        let node = DraggableNode(id: level.name.hashValue, position: position, label: level.name)
        nodes[level.name] = node
        edges[level.name] = []
    }

    mutating func addEdge(from: String, to: String) {
        edges[from]?.append(to)
    }

    mutating func buildGraph(levels: [Level]) {
        for (index, level) in levels.enumerated() {
            let position = CGPoint(x: 50*(index + 1), y: 50*(index + 1)) // Change this to set the initial position of the nodes
            addLevel(level, position: position)
            for destination in level.destinations {
                addEdge(from: level.name, to: destination)
            }
        }
    }
}

func createGraph(from jsonDicts: [[String:Any]]) -> Graph {
    var graph = Graph()
    var currentLevels: [Level] = []
    var i = 0
    for jsonDict in jsonDicts {
        var currentName: String?
        var currentDestinations: [String] = []
        
        //create level
        for (key, value) in jsonDict {
            if key == "name" {
                if let name = value as? String {
                    print("Debug name in the dict is \(name)")
                    currentName = name
                } else {
                    print("[WARNING] Can't get the level name from this file : \(jsonDict)")
                }
            }
            
            if key == "structures" {
                if let structuresArray = value as? [[String:Any]] {
                    for currentStructure in structuresArray {
                        for (structureKey,structureValue) in currentStructure{
                            if structureKey == "teleport_to_scene" {
                                if let TTS = structureValue as? String {
                                    if TTS != "none"{
                                        currentDestinations.append(getLevelNameFromTeleportToScene(TTS)) // format the tts to avoid the coordinates
                                    }
                                }
                            }
                        }
                    }
                } else {
                    print("[WARNING] Can't get the strcutres list from this file : \(jsonDict)")
                }
            }
            
            
            
        }
        
        if currentName != nil {
            let currentLevel = Level(name: currentName!, destinations: currentDestinations)
            graph.addLevel(currentLevel, position: CGPoint(x: 100*i, y: 100*i))
            currentLevels.append(currentLevel)
            i += 1
        } else {
            print("[DEBUG] Name : \(currentName), Destinations : \(currentDestinations)")
            print("[WARNING] This level will not be in the graph: \(jsonDict)")
        }
        
        
    }
    
    //build the graph
//    let levels = Array(graph.nodes.values.map { Level(name: $0.label, destinations: []) })
    graph.buildGraph(levels: currentLevels)
    
    return graph
}
