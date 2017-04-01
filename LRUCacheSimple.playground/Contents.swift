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


// Test 04.01.17
// LRUCache
//

// Api
//
// Node - value : cost
//
// Dictionary - K : V
//    total cost
//    exict when totalcost exceeds maximum
//

class Node<K,V:Comparable> {
    var key:K
    var value:V
    var cost:Int
    
    init(key:K, value:V, cost:Int) {
        self.key = key
        self.value = value
        self.cost = cost
    }
    
    func describe() {
        print("[key : \(key), value : \(value), cost : \(cost)]")
    }
}

class LRUCache<K:Hashable,V:Comparable> {
    var hash: [K : Node<K,V>]
    var lastUsed: [Node<K,V>]
    var maxCost: Int
    
    init(maxCost: Int) {
        self.hash = [:]
        self.lastUsed = []
        self.maxCost = maxCost
    }
    
    public func insert(key:K, value:V, cost:Int) {
        let node = Node<K,V>(key:key, value:value, cost:cost)
        lastUsed.append(node)
        hash[key] = node
        checkCost()
    }
    
    
    private func totalCost() -> Int {
        var totalCost:Int = 0
        for node in lastUsed {
            totalCost += node.cost
        }
        return totalCost
    }
    
    private func checkCost() {
        while (totalCost() > maxCost) {
            removeLastUsed()
        }
    }
    
    private func removeLastUsed() {
        print("removeLastUsed()")
        let node = lastUsed.remove(at: 0)
    }
    
    public func describe() {
        print("lastUsed : ")
        for node in lastUsed {
            node.describe()
        }
        
        print("hash : ")
        for key in hash.keys {
            print("key -> \(key)")
            if let node = hash[key] {
                node.describe()
            }
        }
        print("totalCost : \(totalCost())")
    }
}

// Test

// let n1 = Node<String, Int>(key:"ok", value:5, cost:1)
// n.describe()

let l = LRUCache<String, Int>(maxCost:10)
l.insert(key:"ok", value:5, cost:1)
l.describe()
l.insert(key:"ok", value:5, cost:9)
l.describe()
l.insert(key:"ok", value:5, cost:2)
l.describe()




