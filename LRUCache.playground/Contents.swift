//: Playground - noun: a place where people can play

// https://developer.apple.com/reference/swift/dictionary
// Dictionary minimumCapacity
//
// A dictionary’s indices stay valid across additions to the dictionary as long as the dictionary has enough capacity to store the added values without allocating more buffer. When a dictionary outgrows its buffer, existing indices may be invalidated without any notification.
// When you know how many new values you’re adding to a dictionary, use the init(minimumCapacity:) initializer to allocate the correct amount of buffer.

// Thoughts :
// LRUCache is a combination of a dictionary for storage and a linkedList
// for sorting usage
// Build linked list nodes with generics, store them in hashtable
//

class Node<K, V> {
  var next: Node?
  var previous: Node?
  var key: K
  var value: V?
  
  init(key: K, value: V?) {
    self.key = key
    self.value = value
  }
  
  func display() -> String {
    var displayString = "[\(self.key) "
    if (self.value != nil) {
      displayString += "\(self.value!)"
    } else {
      displayString += "nil"
    }
    displayString += "]"
    return displayString
  }
}

class LinkedList<K, V> {
  
  var head: Node<K, V>?
  var tail: Node<K, V>?
  
  init() {
    
  }
  
  func addToHead(node: Node<K, V>) {
    if (head == nil) {
      // no head, so LinkedList is empty
      // this is the first node, both the head and tail
      self.head = node
      self.tail = node
      self.tail?.previous = node
    } else {
      if (self.head! === node) {
        // bail if head is already node
        return
      } else if (self.tail! === node) {
        // node is tail, make a new one
        if (node.previous != nil) {
          self.tail = node.previous
          self.tail?.next = nil
        }
      } else if (node.next != nil && node.previous != nil) {
        // node is somewhere in the middle of the chain
        // connect previos and next
        node.previous?.next = node.next
        node.next?.previous = node.previous
        node.previous = nil
      }
      
      // ensure node previous is nil
      node.previous = nil
      // previous head's previous becomes node
      head!.previous = node
      // node is the new head
      node.next = head
      self.head = node
    }
  }
  
  func remove(node: Node<K, V>) {
    if (self.head! === node) {
      // node is head
      if (node.next != nil) {
        self.head = node.next
        self.head!.previous = nil
      } else {
        // if head has no next, it must also be the tail
        // erase both head and tail
        self.head = nil
        self.tail = nil
      }
    } else if (self.tail! === node) {
      if (self.tail?.previous != nil) {
        self.tail = self.tail?.previous
        self.tail?.next = nil
      }
    } else if (node.next != nil && node.previous != nil) {
      // node is in the middle
      node.previous?.next = node.next
      node.next?.previous = node.previous
    }
    
    // delete pointers to ensure node will be removed by ARC
    node.next = nil
    node.previous = nil
  }
  
  
  func display() -> String {
    var displayString : String = ""
    var nodes : Array<Node<K, V>> = []
    if (self.head != nil) {
      nodes.append(self.head!)
      var node = self.head
      while (node?.next != nil) {
        node = node?.next
        nodes.append(node!)
      }
    }
    for node in nodes {
      displayString += node.display()
    }
    
    return displayString
  }
  
}


// test creating a node with values
let n = Node(key: "key1", value: "value1")
print(n.key)
print(n.value!)

// test LinkedList
let l = LinkedList<String, String>()
print(l.display())
l.addToHead(node: n)
print(l.display())
// add same node to head again
l.addToHead(node: n)
print(l.display())
// add second node
let n2 = Node(key: "key2", value: "value2")
l.addToHead(node: n2)
print(l.display())
// add third node
let n3 = Node(key: "key3", value: "value3")
l.addToHead(node: n3)
print(l.display())
// move 2nd node to head
l.addToHead(node: n2)
print("head : \(l.head!.display())")
print("tail : \(l.tail!.display())")
// remove head
l.remove(node: l.head!)
print(l.display())
// remove tail
print("head : \(l.head!.display())")
print("head.next : \(l.head!.next!.display())")
print("tail : \(l.tail!.display())")
print("tail.previous : \(l.tail!.previous!.display())")
l.remove(node: l.tail!)
print(l.display())
l.remove(node: l.tail!)
print(l.display())











