// Dijkstra's Algorithm
// Shortest Path
//

import UIKit

let INF:Int = 999999

class Edge {
  var node:VertexNode
  var distance:Int
  
  init(node:VertexNode, distance:Int) {
    self.node = node
    self.distance = distance
  }
}

class VertexNode {
  var label:String
  var edges:[Edge] = []
  var cost:Int
  var parent:VertexNode?
  
  init(label:String) {
    self.label = label
    self.cost = INF
    self.parent = nil
  }
  
  func addEdge(node:VertexNode, distance:Int) {
    self.edges.append(Edge(node:node, distance:distance))
  }
}

class Graph {
  var nodes:[VertexNode]
  
  init() {
    self.nodes = []
  }
  
  func addNodeIfNecessary(n:VertexNode) {
    for node in nodes {
      if node.label == n.label {
        return
      }
    }
    nodes.append(n)
  }
  
  func connectNodes(n1:VertexNode, n2:VertexNode, distance:Int) {
    addNodeIfNecessary(n: n1)
    addNodeIfNecessary(n: n2)
    n1.addEdge(node:n2, distance: distance)
    n2.addEdge(node:n1, distance: distance)
  }
  
  func checkVertex(node:VertexNode) {
    print("\ncheckVertex = \(node.label)")
    for adjacentEdge in node.edges {
      let candidateCost = node.cost + adjacentEdge.distance
      print("edge to \(adjacentEdge.node.label)")
      print("candidateCost = \(candidateCost)")
      print("adjacentEdge.node.cost = \(adjacentEdge.node.cost)")
      if (candidateCost) < adjacentEdge.node.cost {
        print("replace cost to \(candidateCost) for \(adjacentEdge.node.label)")
        adjacentEdge.node.cost = candidateCost
        adjacentEdge.node.parent = node
      }
    }
  }
  
  func shortestPath(start:VertexNode, end:VertexNode) -> [VertexNode] {
    print("shortestPath \(start.label) to \(end.label)")
    //
    // Initially set all nodes except start to have infinite cost
    // This will assure that BFS propogates outward in order
    //
    var unvisited:[VertexNode] = []
    for node in nodes {
      if (node.label == start.label) {
        start.cost = 0
      } else {
        node.cost = INF
        unvisited.append(node)
      }
    }
    
    // cheack start node, the will lower cost for initial edge set and assure that they go next
    checkVertex(node:start)
    
    while (unvisited.count > 0) {
      // get lowest value node, this assures that it's already been visited and has an initial cost
      //
      var lowestValue:Int = INF
      var lowestValueNode:VertexNode = VertexNode(label: "")
      var i = 0
      for unvisitedNode in unvisited {
        if (unvisitedNode.cost <= INF) {
          lowestValue = unvisitedNode.cost
          lowestValueNode = unvisitedNode
        }
        i += i
      }
      // checkVertex to update the cost and parent node if the distance is lower
      checkVertex(node:lowestValueNode)
      
      // this node has now been visited
      unvisited.remove(at: i)
    }
    
    // walk path backwards for result
    var node:VertexNode? = end
    var returnNodes:[VertexNode] = []
    while(node != nil) {
      print("\(node!.label) : \(node!.cost) -> ")
      returnNodes.insert(node!, at: 0)
      node = (node!.parent != nil) ? node!.parent! : nil
    }
    return returnNodes
  }
  
  func describe() {
    for node in nodes {
      print("\(node.label)")
      for edge in node.edges {
        print("   \(edge.node.label) \(edge.distance)")
      }
    }
  }
}

// Test
//let n1 = VertexNode(label:"a")
//let n2 = VertexNode(label:"b")
//let n3 = VertexNode(label:"c")
//let n4 = VertexNode(label:"d")
//
//let g = Graph()
//  // outer edges
//  g.connectNodes(n1: n1, n2: n2, distance: 1)
//  g.connectNodes(n1: n2, n2: n4, distance: 10)
//  g.connectNodes(n1: n4, n2: n3, distance: 5)
//  g.connectNodes(n1: n1, n2: n3, distance: 2)
//
//g.describe()
//
//let nodes = g.shortestPath(start:n1, end:n4)
//print("Shortest Path")
//for node in nodes {
//  print("\(node.label) -> ")
//}

let n1 = VertexNode(label:"a")
let n2 = VertexNode(label:"b")
let n3 = VertexNode(label:"c")
let n4 = VertexNode(label:"d")
let n5 = VertexNode(label:"e")
let n6 = VertexNode(label:"f")

let g = Graph()
// outer edges
g.connectNodes(n1: n5, n2: n6, distance: 9)
g.connectNodes(n1: n4, n2: n5, distance: 6)
g.connectNodes(n1: n2, n2: n4, distance: 15)
g.connectNodes(n1: n1, n2: n2, distance: 1)
g.connectNodes(n1: n1, n2: n6, distance: 14)
// inner edges
g.connectNodes(n1: n3, n2: n6, distance: 2)
g.connectNodes(n1: n3, n2: n4, distance: 11)
g.connectNodes(n1: n3, n2: n2, distance: 10)
g.connectNodes(n1: n3, n2: n1, distance: 9)

g.describe()

let nodes = g.shortestPath(start: n1, end: n6)
print("Shortest Path")
for node in nodes {
  print("\(node.label) -> ")
}



