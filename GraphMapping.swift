public class Edge : Equatable {
    public var neighbor: Node
    
    public init(neighbor: Node) {
        self.neighbor = neighbor
    }
}

public func ==(lhs: Edge, rhs: Edge) -> Bool {
    return lhs.neighbor == rhs.neighbor
}

// MARK: - Node

public class Node : CustomStringConvertible, Equatable {
    public var neighbors: [Edge]
    public var parent : Node?
    public private(set) var label: String
    public var distance: Int?
    public var visited: Bool
    
    public init(label: String) {
        self.label = label
        neighbors = []
        visited = false
    }
    
    public var description: String {
        if let distance = distance {
            return "Node(label: \(label), distance: \(distance))"
        }
        return "Node(label: \(label), distance: infinity)"
    }
    
    public var hasDistance: Bool {
        return distance != nil
    }
    
    public func remove(edge: Edge) {
        neighbors.remove(at: neighbors.index{ $0 === edge }!)
    }
}

public func ==(lhs: Node, rhs: Node) -> Bool {
    return lhs.label == rhs.label && lhs.neighbors == rhs.neighbors
}

// MARK: - Graph

public class Graph : CustomStringConvertible, Equatable {
    public private(set) var nodes: [Node]
    
    public init() {
        self.nodes = []
    }
    
    public func addNode(label: String) -> Node {
        let node = Node(label: label)
        nodes.append(node)
        return node
    }
    
    public func addEdge(source: Node, neighbor: Node) {
        let edge = Edge(neighbor: neighbor)
        source.neighbors.append(edge)
    }
    
    public var description: String {
        var description = ""
        
        for node in nodes {
            if !node.neighbors.isEmpty {
                description += "[node: \(node.label) edges: \(node.neighbors.map{ $0.neighbor.label})]"
            }
        }
        return description
    }
    
    public func findNodeWithLabel(label: String) -> Node {
        return nodes.filter{ $0.label == label }.first!
    }
    
    public func duplicate() -> Graph {
        let duplicated = Graph()
        
        for node in nodes {
            duplicated.addNode(label: node.label)
        }
        
        for node in nodes {
            for edge in node.neighbors {
                let source = duplicated.findNodeWithLabel(label: node.label)
                let neighbour = duplicated.findNodeWithLabel(label: edge.neighbor.label)
                duplicated.addEdge(source: source, neighbor: neighbour)
            }
        }
        
        return duplicated
    }
}

public func ==(lhs: Graph, rhs: Graph) -> Bool {
    return lhs.nodes == rhs.nodes
}

class GraphMapping {
    
    static var sharedInstance = GraphMapping()
    var mappedPositions = [[BeaconL]]()
    let graph = Graph()
    
    func createMapPositions(availableBeacons : [BeaconL]) {
        
        for beacon in availableBeacons {
            
            let edgeBeacon = availableBeacons.filter({$0.minorValue == beacon.beaconEdge})
            
            let position = [beacon, beacon]
            mappedPositions.append(position)
        }
        
    }
    
    func constructMap(sourceMinorValue : String, destMinorvalue : String) -> [String] {
        
        //var keyNote = graph.addNode(String(minorValue))
        var nodeArray = [Node]()
        
        for parents in mappedPositions {
            
            let node = graph.addNode(label: String(parents[0].minorValue!))
            
            nodeArray.append(node)
            
        }
        for parents in mappedPositions {
            for nodeFromArray in nodeArray {
                for nodeFromGraph in graph.nodes {
                    
                    if nodeFromArray.label == String(parents[0].minorValue!) {
                        
                        if nodeFromGraph.label == String(parents[1].minorValue!) {
                            
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
