//: Playground - noun: a place where people can play

import UIKit

class Node<T : Hashable> {
  var value:T
  var edges:[Edge<T>]
  var visited:Bool
  
  init(value:T) {
    self.value = value
    self.edges = []
    self.visited = false
  }
  
  private func addEdge(edge:Edge<T>) {
    self.edges.append(edge)
  }
  
  func connectToNode(node:Node<T>) {
    addEdge(edge:Edge(node:node))
  }
  
  func describe() {
    print("\(value)")
    for edge in edges {
      print("   \(edge.node.value)")
    }
  }
  
}

class Edge<T : Hashable> {
  var node:Node<T>
  
  init(node:Node<T>) {
    self.node = node
  }
}

class Graph<T : Hashable> {
  var nodes:[T:Node<T>]
  
  init() {
    self.nodes = [:]
  }
  
  func addNode(value:T) -> Node<T> {
    let node = Node(value:value)
    self.nodes[value] = node
    return node
  }
  
  func connect(value1:T, value2:T) {
    if let n1 = nodes[value1], let n2 = nodes[value2] {
      n1.connectToNode(node:n2)
    }
  }
  
  func setUnVisited() {
    for key in nodes.keys {
      if let node = nodes[key] {
        node.visited = false
      }
    }
  }
  
  func BFS(start:T) {
    var queue:[Node<T>] = []
    setUnVisited()
    if let node = nodes[start] {
      queue.append(node)
    }
    while (queue.count > 0) {
      let node = queue.removeFirst()
      node.visited = true
      print("Visit \(node.value)")
      
      for edge in node.edges {
        if (edge.node.visited == false) {
          print("   Add child \(edge.node.value)")
          edge.node.visited = true
          queue.append(edge.node)
        }
      }
    }
  }
  
  func describe() {
    for key in nodes.keys {
      if let node = nodes[key] {
        node.describe()
      }
    }
  }
}

// Test
let g1 = Graph<Int>()
let n1 = g1.addNode(value:5)
let n2 = g1.addNode(value:10)
let n3 = g1.addNode(value:15)
let n4 = g1.addNode(value:20)
let n5 = g1.addNode(value:25)
let n6 = g1.addNode(value:30)
let n7 = g1.addNode(value:35)
let n8 = g1.addNode(value:40)

n1.connectToNode(node:n2)
n1.connectToNode(node:n3)
n2.connectToNode(node:n3)
n2.connectToNode(node:n4)
n2.connectToNode(node:n8)
n2.connectToNode(node:n5)
n3.connectToNode(node:n4)
n3.connectToNode(node:n1)
n4.connectToNode(node:n1)
n4.connectToNode(node:n2)
n4.connectToNode(node:n8)
n4.connectToNode(node:n7)
n4.connectToNode(node:n6)
n4.connectToNode(node:n5)
n4.connectToNode(node:n2)

// n1.describe()
// n2.describe()
// n3.describe()
// n4.describe()

g1.describe()

g1.BFS(start:5)
