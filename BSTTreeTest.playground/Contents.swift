// Tring BSTTree

import UIKit

class BSTreeNode<V: Comparable> {
  var value:V
  var parent:BSTreeNode?
  var left:BSTreeNode?
  var right:BSTreeNode?
  
  init(value:V) {
    self.value = value
    self.left = nil
    self.right = nil
  }
  
  func min() -> BSTreeNode {
    if (self.left != nil) {
      return self.left!.min()
    } else {
      return self
    }
  }
  
  func max() -> BSTreeNode {
    if (self.right != nil) {
      return self.right!.max()
    } else {
      return self    }
  }
  
  func connectToParent(node:BSTreeNode?) {
    if parent?.left?.value == self.value {
      parent?.left = node
    } else if parent?.right?.value == self.value {
      parent?.right = node
    }
    node?.parent = parent
  }
  
  func search(value:V) -> BSTreeNode? {
    if (value == self.value) {
      return self
    } else if (value < self.value) {
      return self.left?.search(value: value)
    } else {
      return self.right?.search(value: value)
    }
  }
  
  func insert(value:V) {
    if (value < self.value) {
      // if left, recurse, else add node
      if (self.left != nil) {
        self.left!.insert(value: value)
      } else {
        self.left = BSTreeNode(value: value)
        self.left!.parent = self
      }
    } else {
      // if right, recurse, else add node
      if (self.right != nil) {
        self.right!.insert(value: value)
      } else {
        self.right = BSTreeNode(value: value)
        self.right!.parent = self
      }
    }
  }
  
  func delete() -> BSTreeNode? {
    print("delete : \(value)")
    let replacement: BSTreeNode?
    
    if left != nil {
      replacement = left!.max()
    } else if right != nil {
      replacement = right!.min()
    } else {
      replacement = nil
    }
    
    print("replacement : \(replacement?.value)")
    replacement?.delete()
    replacement?.right = right
    replacement?.left = left
    right?.parent = replacement
    left?.parent = replacement
    connectToParent(node:replacement)
    
    right = nil
    left = nil
    parent = nil
    
    return replacement
  }
  
  func preorder() {
    print("\(self.value) ")
    self.left?.preorder()
    self.right?.preorder()
  }
  
  func inorder() {
    self.left?.inorder()
    print("\(self.value) ")
    self.right?.inorder()
  }
  
  func postorder() {
    self.left?.postorder()
    self.right?.postorder()
    print("\(self.value) ")
  }
  
  func description(indent:String) {
    print("\(indent)\(self.value)")
    print("\(indent)R ->")
    if (self.right != nil) {
      self.right?.description(indent: indent + " ")
    } else {
      print("\(indent)  nil")
    }
    print("\(indent)L ->")
    if (self.left != nil) {
      self.left?.description(indent: indent + " ")
    } else {
      print("\(indent)  nil")
    }
  }
}



// create ree and insert nodes
let root = BSTreeNode(value:20)
root.insert(value: 10)
root.insert(value: 30)
root.insert(value: 25)
root.insert(value: 27)
root.insert(value: 26)
root.description(indent: "")
root.search(value: 25)?.delete()
root.description(indent: "")
//root.delete(value: 26)
//root.description(indent: "")
//print("preorder")
//root.preorder()
//print("inorder")
//root.inorder()
//print("postorder")
//root.postorder()
