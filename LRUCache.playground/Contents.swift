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

class lruCache<K : Hashable, V> : CustomStringConvertible {
  
  let capacity: Int
  var length = 0
  
  private let queue: LinkedList<K, V>
  private var hashtable: [K : Node<K, V>]
  
  /**
   Least Recently Used "LRU" Cache, capacity is the number of elements to keep in the Cache.
   */
  init(capacity: Int) {
    self.capacity = capacity
    
    self.queue = LinkedList()
    self.hashtable = [K : Node<K, V>](minimumCapacity: self.capacity)
  }
  
  subscript(index: K) -> V? {
    get {
      if self.hashtable[index] != nil {
        let node = self.hashtable[index]
        self.queue.addToHead(node: node!)
        return (node?.value)!
      } else {
        return nil
      }
    }
    set(newValue) {
      if let node = self.hashtable[index] {
        node.value = newValue
        self.queue.addToHead(node: node)
      } else {
        let n = Node(key: index, value: newValue)
        
        if (self.length > self.capacity) {
          self.queue.remove(node: self.queue.tail!)
          hashtable.removeValue(forKey: self.queue.tail!.key)
        } else {
          self.length += 1
        }
        
        self.queue.addToHead(node: n)
        self.hashtable[index] = n
      }
    }
  }
  
  var description: String {
    return "length : \(self.length) capacity : \(self.capacity) display : \(self.queue.display())"
  }
}


// test creating a node with values
//
//
let n = Node(key: "key1", value: "value1")
print(n.key)
print(n.value!)

// test LinkedList
//
//
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
// test lruCache
//
//
var lruC = lruCache<String, String>(capacity: 8)
print(lruC.description)
lruC["key1"] = "value1"
print(lruC.description)
lruC["key2"] = "value2"
lruC["key3"] = "value3"
lruC["key4"] = "value4"
lruC["key5"] = "value5"
lruC["key6"] = "value6"
lruC["key7"] = "value7"
lruC["key8"] = "value8"
print(lruC.description)
// move key3 to head by accessing
print(lruC["key3"]!)
print(lruC.description)
// add new object to overflow key1
lruC["key9"] = "value9"
print(lruC.description)
// overwrite key2 value
lruC["key2"] = "VALUE2"
print(lruC.description)
// overwrite key7 value
lruC["key7"] = "VALUE7"
print(lruC.description)














