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
  
  public convenience init(array: [T]) {
    precondition(array.count > 0)
    self.init(value: array.first!)
    for v in array.dropFirst() {
      insert(value: v)
    }
  }
  
  public func printInOrder(node:BinarySearchTree, level:Int) {
    if (node.left != nil) {
      printInOrder(node: node.left!, level: level+1)
    }
    let childLabel = (node.isLeftChild || node.isRightChild) ? (node.isLeftChild ? "left" : "right") : "root"
    print("-> (\(node.value) : \(level) \(childLabel)")
    if (node.right != nil) {
      printInOrder(node: node.right!, level: level+1)
    }
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
tree.printInOrder(node: tree, level: 0)
let tree2 = BinarySearchTree<Int>(array: [7, 2, 5, 10, 9, 1])
tree.printInOrder(node: tree2, level: 0)
tree.search(value: 5)
tree.search(value: 1)















