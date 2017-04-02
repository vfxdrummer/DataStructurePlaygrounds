// Dijkstra's Algorithm
// Shortest Path
//

import UIKit

//let INF:Int = 999999
//
//class Edge {
//  var node:VertexNode
//  var distance:Int
//  
//  init(node:VertexNode, distance:Int) {
//    self.node = node
//    self.distance = distance
//  }
//}
//
//class VertexNode {
//  var label:String
//  var edges:[Edge] = []
//  var cost:Int
//  var parent:VertexNode?
//  
//  init(label:String) {
//    self.label = label
//    self.cost = INF
//    self.parent = nil
//  }
//  
//  func addEdge(node:VertexNode, distance:Int) {
//    self.edges.append(Edge(node:node, distance:distance))
//  }
//}
//
//class Graph {
//  var nodes:[VertexNode]
//  
//  init() {
//    self.nodes = []
//  }
//  
//  func addNodeIfNecessary(n:VertexNode) {
//    for node in nodes {
//      if node.label == n.label {
//        return
//      }
//    }
//    nodes.append(n)
//  }
//  
//  func connectNodes(n1:VertexNode, n2:VertexNode, distance:Int) {
//    addNodeIfNecessary(n: n1)
//    addNodeIfNecessary(n: n2)
//    n1.addEdge(node:n2, distance: distance)
//    n2.addEdge(node:n1, distance: distance)
//  }
//  
//  func checkVertex(node:VertexNode) {
//    print("\ncheckVertex = \(node.label)")
//    for adjacentEdge in node.edges {
//      let candidateCost = node.cost + adjacentEdge.distance
//      print("edge to \(adjacentEdge.node.label)")
//      print("candidateCost = \(candidateCost)")
//      print("adjacentEdge.node.cost = \(adjacentEdge.node.cost)")
//      if (candidateCost) < adjacentEdge.node.cost {
//        print("replace cost to \(candidateCost) for \(adjacentEdge.node.label)")
//        adjacentEdge.node.cost = candidateCost
//        adjacentEdge.node.parent = node
//      }
//    }
//  }
//  
//  func shortestPath(start:VertexNode, end:VertexNode) -> [VertexNode] {
//    print("shortestPath \(start.label) to \(end.label)")
//    //
//    // Initially set all nodes except start to have infinite cost
//    // This will assure that BFS propogates outward in order
//    //
//    var unvisited:[VertexNode] = []
//    for node in nodes {
//      if (node.label == start.label) {
//        start.cost = 0
//      } else {
//        node.cost = INF
//        unvisited.append(node)
//      }
//    }
//    
//    // cheack start node, the will lower cost for initial edge set and assure that they go next
//    checkVertex(node:start)
//    
//    while (unvisited.count > 0) {
//      // get lowest value node, this assures that it's already been visited and has an initial cost
//      //
//      var lowestValue:Int = INF
//      var lowestValueNode:VertexNode = VertexNode(label: "")
//      var i = 0
//      for unvisitedNode in unvisited {
//        if (unvisitedNode.cost <= INF) {
//          lowestValue = unvisitedNode.cost
//          lowestValueNode = unvisitedNode
//        }
//        i += i
//      }
//      // checkVertex to update the cost and parent node if the distance is lower
//      checkVertex(node:lowestValueNode)
//      
//      // this node has now been visited
//      unvisited.remove(at: i)
//    }
//    
//    // walk path backwards for result
//    var node:VertexNode? = end
//    var returnNodes:[VertexNode] = []
//    while(node != nil) {
//      print("\(node!.label) : \(node!.cost) -> ")
//      returnNodes.insert(node!, at: 0)
//      node = (node!.parent != nil) ? node!.parent! : nil
//    }
//    return returnNodes
//  }
//  
//  func describe() {
//    for node in nodes {
//      print("\(node.label)")
//      for edge in node.edges {
//        print("   \(edge.node.label) \(edge.distance)")
//      }
//    }
//  }
//}
//
//let n1 = VertexNode(label:"a")
//let n2 = VertexNode(label:"b")
//let n3 = VertexNode(label:"c")
//let n4 = VertexNode(label:"d")
//let n5 = VertexNode(label:"e")
//let n6 = VertexNode(label:"f")
//
//let g = Graph()
//// outer edges
//g.connectNodes(n1: n5, n2: n6, distance: 9)
//g.connectNodes(n1: n4, n2: n5, distance: 6)
//g.connectNodes(n1: n2, n2: n4, distance: 15)
//g.connectNodes(n1: n1, n2: n2, distance: 1)
//g.connectNodes(n1: n1, n2: n6, distance: 14)
//// inner edges
//g.connectNodes(n1: n3, n2: n6, distance: 2)
//g.connectNodes(n1: n3, n2: n4, distance: 11)
//g.connectNodes(n1: n3, n2: n2, distance: 10)
//g.connectNodes(n1: n3, n2: n1, distance: 9)
//
//g.describe()
//
//let nodes = g.shortestPath(start: n1, end: n6)
//print("Shortest Path")
//for node in nodes {
//  print("\(node.label) -> ")
//}


// Test 04.01.17
// Shortest Path - Dijkstra's
//
// Api
//  - Graph Node
//      location name
//  - Edge
//      cost
//
//  Algorithm
//      input :
//          startNode
//          endNode
//      Mark all nodes with infinite distance
//      Mark startNode 0 distance
//      get unvisited node with lowest distance
//          BFS : children
//              if distance < current distance for node, replace
//      if you reach endNode, done
//

class Node<T> {
    var value:T
    var edges:[Edge<T>]
    var parent:Node<T>?
    var distance:Int
    var visited:Bool
    
    init(value: T) {
        self.value = value
        self.edges = []
        self.distance = 0
        self.visited = false
    }
    
    func connectNode(node:Node<T>, distance:Int) {
        let edge = Edge(node:node, distance:distance)
        edges.append(edge)
    }
    
    func describe() {
        print("Node : \(value)")
        for edge in edges {
            edge.describe()
        }
    }
}

class Edge<T> {
    var node:Node<T>
    var distance:Int
    
    init (node:Node<T>, distance:Int) {
        self.node = node
        self.distance = distance
    }
    
    func describe() {
        print("[Edge : \(node.value) \(distance)")
    }
}

class Graph<T:Hashable> {
    var nodes:[T:Node<T>]
    
    init() {
        nodes = [:]
    }
    
    func insert(value: T) {
        let node = Node<T>(value:value)
        nodes[value] = node
    }
    
    func connect(value1:T, value2:T, distance:Int) {
        if let node1 = nodes[value1], let node2 = nodes[value2] {
            node1.connectNode(node:node2, distance:distance)
            node2.connectNode(node:node1, distance:distance)
        }
    }
    
    func resetVisited() {
        for key in nodes.keys {
            let node = nodes[key]!
            node.visited = false
        }
    }
    
    func BFS(start:T) {
        var unvisited:[Node<T>] = []
        resetVisited()
        
        unvisited.append(nodes[start]!)
        nodes[start]!.visited = true
        
        while(unvisited.count > 0) {
            let node = unvisited.remove(at:0)
            print("Visit \(node.value)")
            for edge in node.edges {
                let child = edge.node
                if (child.visited == false) {
                    child.visited = true
                    unvisited.append(edge.node)
                }
            }
        }
    }
    
    func nodeArray() -> [Node<T>] {
        var nodeList:[Node<T>] = []
        for key in nodes.keys {
            nodeList.append(nodes[key]!)
        }
        return nodeList
    }
    
    func shortestPath(start:T, end:T) -> [Node<T>] {
        let startNode = nodes[start]!
        let endNode = nodes[end]!
        var visited: [Node<T>] = []
        var unvisited: [Node<T>] = []
        
        for node in nodeArray() {
            node.distance = 999999
            node.visited = false
            unvisited.append(node)
        }
        startNode.visited = true
        startNode.distance = 0
        
        while (unvisited.count > 0) {
            var node:Node<T>
            var shortest = 999999
            var i = 0
            var j = 0
            for unvisitedNode in unvisited {
                if (unvisitedNode.distance < shortest) {
                    shortest = unvisitedNode.distance
                    j = i
                }
                i += 1
            }
            // get unvisited node
            node = unvisited.remove(at:j)
            if (node.value == end) {
                print("At end node")
                var parent:Node<T>? = node
                var returnNodes:[Node<T>] = []
                while(parent != nil) {
                    returnNodes.append(parent!)
                    print("\(parent!.value) -> ")
                    parent = parent!.parent
                }
                return returnNodes
            }
            
            print("Visiting \(node.value)")
            for edge in node.edges {
                let child = edge.node
                print("\(node.distance + edge.distance) -> \(child.distance)")
                if (node.distance + edge.distance) < child.distance {
                    print("Setting \(child.value).distance = \(node.distance + edge.distance)")
                    print("\(child.value)->\(node.value)")
                    child.distance = (node.distance + edge.distance)
                    child.parent = node
                }
            }
            
        }
        
        
        
        return []
    }
    
    func describe() {
        for key in nodes.keys {
            nodes[key]!.describe()
        }
    }
    
}

// Test
// let n1 = Node<String>(value:"A")
// let n2 = Node<String>(value:"B")
// n1.connectNode(node:n2, cost:1)
// n1.describe()
// let e1 = Edge(node1:n1, node2:n2, cost:1)

let g = Graph<String>()
g.insert(value:"A")
g.insert(value:"B")
g.insert(value:"C")
g.insert(value:"D")
// g.describe()
g.connect(value1:"A", value2:"B", distance:1)
g.connect(value1:"B", value2:"D", distance:1)
g.connect(value1:"A", value2:"C", distance:2)
g.connect(value1:"C", value2:"D", distance:2)
g.describe()
// g.BFS(start:"A")


let nodes = g.shortestPath(start:"A", end:"D")
var pathStr = ""
for node in nodes.reversed() {
    pathStr += ("\(node.value) -> ")
}
print(pathStr)





