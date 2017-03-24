// Dijkstra's Algorithm
// Shortest Path
//

import UIKit

class Edge {
  var v:VertexNode
  var distance:Int
  
  init(v:VertexNode, distance:Int) {
    self.v = v
    self.distance = distance
  }
}

class VertexNode {
  var label:String
  var edges:[Edge] = []
  
  init(label:String) {
    self.label = label
  }
  
  func addEdge(v:VertexNode, distance:Int) {
    self.edges.append(Edge(v:v, distance:distance))
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
    n1.addEdge(v:n2, distance: distance)
    n2.addEdge(v:n1, distance: distance)
  }
  
  func describe() {
    for node in nodes {
      print("\(node.label)")
      for edge in node.edges {
        print("   \(edge.v.label) \(edge.distance)")
      }
    }
  }
}

// Test
let n1 = VertexNode(label:"a")
let n2 = VertexNode(label:"b")
let n3 = VertexNode(label:"c")
let n4 = VertexNode(label:"d")
let n5 = VertexNode(label:"e")

let g = Graph()
g.connectNodes(n1: n1, n2: n2, distance: 10)
g.connectNodes(n1: n1, n2: n3, distance: 5)

g.describe()


