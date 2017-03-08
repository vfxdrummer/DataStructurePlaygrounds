//
// BSTTree
//
//
//

public class BinarySearchTree<T: Comparable> {
  private(set) public var value: T
  private(set) public var parent: BinarySearchTree?
  private(set) public var left: BinarySearchTree?
  private(set) public var right: BinarySearchTree?
  
  public init(value: T) {
    self.value = value
  }
  
  public convenience init(array: [T]) {
    precondition(array.count > 0)
    self.init(value: array.first!)
    for v in array.dropFirst() {
      insert(value: v)
    }
  }
  
  public var isRoot: Bool {
    return parent == nil
  }
  
  public var isLeaf: Bool {
    return left == nil && right == nil
  }
  
  public var isLeftChild: Bool {
    return parent?.left === self
  }
  
  public var isRightChild: Bool {
    return parent?.right === self
  }
  
  public var hasLeftChild: Bool {
    return left != nil
  }
  
  public var hasRightChild: Bool {
    return right != nil
  }
  
  public var hasAnyChild: Bool {
    return hasLeftChild || hasRightChild
  }
  
  public var hasBothChildren: Bool {
    return hasLeftChild && hasRightChild
  }
  
  public var count: Int {
    return (left?.count ?? 0) + 1 + (right?.count ?? 0)
  }
  
  public func height() -> Int {
    if isLeaf {
      return 0
    } else {
      return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
    }
  }
  
  public func depth() -> Int {
    var node = self
    var edges = 0
    while case let parent? = node.parent {
      node = parent
      edges += 1
    }
    return edges
  }
  
  public func insert(value: T) {
    if value < self.value {
      if let left = left {
        left.insert(value: value)
      } else {
        left = BinarySearchTree(value: value)
        left?.parent = self
      }
    } else {
      if let right = right {
        right.insert(value: value)
      } else {
        right = BinarySearchTree(value: value)
        right?.parent = self
      }
    }
  }
    
  public func search(value: T) -> BinarySearchTree? {
    if value < self.value {
      return left?.search(value:
        value)
    } else if value > self.value {
      return right?.search(value: value)
    } else {
      return self  // found it!
    }
  }
  
  public func predecessor() -> BinarySearchTree<T>? {
    if let left = left {
      return left.maximum()
    } else {
      var node = self
      while case let parent? = node.parent {
        if parent.value < value { return parent }
        node = parent
      }
      return nil
    }
  }
  
  public func successor() -> BinarySearchTree<T>? {
    if let right = right {
      return right.minimum()
    } else {
      var node = self
      while case let parent? = node.parent {
        if parent.value > value { return parent }
        node = parent
      }
      return nil
    }
  }
  
  private func reconnectParentTo(node: BinarySearchTree?) {
    if let parent = parent {
      if isLeftChild {
        parent.left = node
      } else {
        parent.right = node
      }
    }
    node?.parent = parent
  }
  
  public func minimum() -> BinarySearchTree {
    var node = self
    while case let next? = node.left {
      node = next
    }
    return node
  }
  
  public func maximum() -> BinarySearchTree {
    var node = self
    while case let next? = node.right {
      node = next
    }
    return node
  }
  
  @discardableResult public func remove() -> BinarySearchTree? {
    let replacement: BinarySearchTree?
    
    // Replacement for current node can be either biggest one on the left or
    // smallest one on the right, whichever is not nil
    if let right = right {
      replacement = right.minimum()
    } else if let left = left {
      replacement = left.maximum()
    } else {
      replacement = nil
    }
    
    replacement?.remove()
    
    // Place the replacement on current node's position
    replacement?.right = right
    replacement?.left = left
    right?.parent = replacement
    left?.parent = replacement
    reconnectParentTo(node:replacement)
    
    // The current node is no longer part of the tree, so clean it up.
    parent = nil
    left = nil
    right = nil
    
    return replacement
  }
  
  public func printNode(node:BinarySearchTree) {
    let childLabel = (node.isLeftChild || node.isRightChild) ? (node.isLeftChild ? "left" : "right") : "root"
    print("-> (\(node.value) : \(node.height()) \(childLabel)")
  }
  
  public func printInOrder(node:BinarySearchTree) {
    node.left?.printInOrder(node: node.left!)
    let childLabel = (node.isLeftChild || node.isRightChild) ? (node.isLeftChild ? "left" : "right") : "root"
    print("-> (\(node.value) : \(node.height()) \(childLabel)")
    node.right?.printInOrder(node: node.right!)
  }
  
  public func printPreOrder(node:BinarySearchTree) {
    printNode(node:node)
    node.left?.printPreOrder(node: node.left!)
    node.right?.printPreOrder(node: node.right!)
  }
  
  public func printPostOrder(node:BinarySearchTree) {
    node.left?.printPostOrder(node: node.left!)
    node.right?.printPostOrder(node: node.right!)
    printNode(node:node)
  }
  
  public func map(formula: (T) -> T) -> [T] {
    var a = [T]()
    if let left = left { a += left.map(formula: formula) }
    a.append(formula(value))
    if let right = right { a += right.map(formula: formula) }
    return a
  }
  
  public func toArray() -> [T] {
    return map { $0 }
  }
}


extension BinarySearchTree: CustomStringConvertible {
  public var description: String {
    var s = ""
    if let left = left {
      s += "(\(left.description)) <- "
    }
    s += "\(value)"
    if let right = right {
      s += " -> (\(right.description))"
    }
    return s
  }
}

// Create tree nodes
//
//
let tree = BinarySearchTree<Int>(value: 7)
print(tree.count)
// Test tree insertion
//
//
tree.insert(value: 2)
tree.insert(value: 5)
tree.insert(value: 10)
tree.insert(value: 9)
tree.insert(value: 1)
tree.printInOrder(node: tree)
let tree2 = BinarySearchTree<Int>(array: [7, 2, 5, 10, 9, 1])
print("<---- In Order ---->")
tree.printInOrder(node: tree2)
print("<---- Pre Order ---->")
tree.printPreOrder(node: tree2)
print("<---- Post Order ---->")
tree.printPostOrder(node: tree2)
tree.search(value: 5)
tree.search(value: 1)
print(tree.minimum())
print(tree.maximum())
print(tree2.minimum())
print(tree2.maximum())
tree.search(value: 5)?.depth()
tree.printPreOrder(node: tree)
tree.search(value: 1)?.predecessor()
tree.search(value: 2)?.predecessor()
tree.search(value: 5)?.predecessor()
tree.search(value: 7)?.predecessor()
tree.search(value: 9)?.predecessor()
tree.search(value: 10)?.predecessor()
tree.insert(value: 6)
tree.search(value: 6)?.successor()
tree.search(value: 1)?.successor()
tree.search(value: 2)?.successor()
tree.search(value: 5)?.successor()
tree.search(value: 6)?.successor()
tree.search(value: 7)?.successor()
tree.search(value: 9)?.successor()
tree.search(value: 10)?.successor()
if let node1 = tree.search(1) {
  tree.isBST(minValue: Int.min, maxValue: Int.max)  // true
  node1.insert(100)                                 // EVIL!!!
  tree.search(100)                                  // nil
  tree.isBST(minValue: Int.min, maxValue: Int.max)  // false
}














