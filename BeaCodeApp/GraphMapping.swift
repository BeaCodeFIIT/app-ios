//
//  Graph.swift
//  IndoorNav
//
//  Created by Peter Augustín on 01.05.16.
//  Copyright © 2016 Peter Augustin. All rights reserved.
//

import UIKit

class GraphMapping: NSObject {
    
    static var sharedInstance = GraphMapping()
    var mappedPositions = [[Beacon]]()
    let graph = Graph()
 
    func createMapPositions(availableBeacons : [Beacon]) {
        
        for beacon in availableBeacons {
            
            let edgeBeacon = availableBeacons.filter({$0.minorValue as? Int == beacon.beaconEdge})
            
            let position = [beacon, edgeBeacon[0]]
            mappedPositions.append(position)
        }
        
    }
    
    func constructMap(sourceMinorValue : String, destMinorvalue : String) -> [String] {
        
        //var keyNote = graph.addNode(String(minorValue))
        var nodeArray = [Node]()
        
        for parents in mappedPositions {
                
                let node = graph.addNode(label: String(describing: parents[0].minorValue!))
                
                nodeArray.append(node)
                
        }
        for parents in mappedPositions {
            for nodeFromArray in nodeArray {
                for nodeFromGraph in graph.nodes {
                    
                    if nodeFromArray.label == String(describing: parents[0].minorValue!) {
                        
                        if nodeFromGraph.label == String(describing: parents[1].minorValue!) {
                            
                            graph.addEdge(source: nodeFromArray, neighbor: nodeFromGraph)
                            graph.addEdge(source: nodeFromGraph, neighbor: nodeFromArray)
                        }
                    }
                }
            }
        }
        
        var source : Node?
        
        for node in graph.nodes {
            
            if node.label == sourceMinorValue {
                
                source = node
                
            }
        }
        
        var nodesExplored = breadthFirstSearch(graph: graph, source: source!,dest: destMinorvalue)
        nodesExplored = nodesExplored.reversed()
        
        return nodesExplored
    }
    
    func breadthFirstSearch(graph: Graph, source: Node, dest : String) -> [String] {
        var queue = Queue<Node>()
        queue.enqueue(element: source)
        var finded = false
        var nodesExplored = [source]
        source.visited = true
        source.parent = nil
        
        while let node = queue.dequeue() {
            for edge in node.neighbors {
                let neighborNode = edge.neighbor
                if !neighborNode.visited {
                    queue.enqueue(element: neighborNode)
                    neighborNode.visited = true
                    neighborNode.parent = node
                    nodesExplored.append(neighborNode)
                }
                if neighborNode.label == dest {
                    
                    finded = true
                    break
                    
                }
            }
            
            if finded {
                
                break
            }
        }
        
        var tmpNode = nodesExplored.last
        var resultArray = [String]()
        
        while tmpNode?.parent != nil {
            
            resultArray.append((tmpNode?.label)!)
            tmpNode = tmpNode?.parent
            
        }
        
        resultArray.append((tmpNode?.label)!)
        
        return resultArray
    }
}
