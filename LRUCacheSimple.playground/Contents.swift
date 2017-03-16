//: Playground - noun: a place where people can play

import UIKit

class Node<K,V: Comparable> {
  var key:K
  var value:V
  var cost:Double
  
  init(key:K, value:V, cost:Double) {
    self.key = key
    self.value = value
    self.cost = cost
  }
}

class LRUCache<K: Hashable,V: Comparable> {
  var array:[Node<K,V>]
  var hashMap:[K : Node<K,V>]
  var maxCost:Double
  
  init(maxCost:Double) {
    self.array = []
    self.hashMap = [:]
    self.maxCost = maxCost
  }
  
  func findArrayIndex(node:Node<K,V>) -> Int? {
    for i in 0..<array.count {
      let arrayNode = array[i]
      if (arrayNode.value == node.value && arrayNode.key == node.key) {
        return i
      }
    }
    return nil
  }
  
  func addToHead(node:Node<K,V>) {
    let i = self.findArrayIndex(node: node)
    if i != nil {
      // remove node
      print("remove node \(i!)")
      self.array.remove(at: i!)
    }
    self.array.insert(node, at: 0)
  }
  
  func checkCost() {
    var totalCost = 0.0
    for item in array {
      totalCost += item.cost
    }
    if totalCost > maxCost && array.count > 0 {
      // evict tail and check again
      let node = self.array.removeLast()
      print("evict \(node.key)")
      self.hashMap.removeValue(forKey: node.key)
      self.checkCost()
    }
  }
  
  func insert(key:K, value:V, cost:Double) {
    let node = Node<K,V>(key:key, value:value, cost:cost)
    self.hashMap[key] = node
    self.addToHead(node:node)
    self.checkCost()
  }
  
  func describe() {
    print("\narray :")
    var line = ""
    for item in array {
      line = "\(line) [\(item.key) : \(item.value)] "
    }
    print(line)
    print("\nhashMap :")
    for key in hashMap.keys {
      print("\(key) : \(hashMap[key]!.value) c -> \(hashMap[key]!.cost)")
    }
    print("\nmax cost : \(maxCost)")
  }
}

// insert
let l = LRUCache<String, String>(maxCost: 10)
l.insert(key: "one", value: "1", cost: 2.0)
l.insert(key: "two", value: "2", cost: 2.0)
l.insert(key: "three", value: "3", cost: 1.0)
l.insert(key: "four", value: "4", cost: 2.0)
l.insert(key: "five", value: "5", cost: 3.0)
l.describe()
l.insert(key: "six", value: "3", cost: 1.0)
l.describe()
l.insert(key: "seven", value: "4", cost: 5.0)
l.describe()

