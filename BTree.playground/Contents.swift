//: Playground - noun: a place where people can play

import UIKit

class BTree<T: Comparable> {
  var value:T
  var left: BTree?
  var right: BTree?
  
  init(value:T) {
    self.value = value
  }
  
  class func treeFrom(preorder:Array<T>, inorder:Array<T>) -> BTree? {
    if (preorder.count <= 0) { return nil }
    print("preorder :")
    var line = ""
    for item in preorder {
      line = "\(line) \(item)"
    }
    print(line)
    print("inorder :")
    line = ""
    for item in inorder {
      line = "\(line) \(item)"
    }
    print(line)
    let value = preorder[0]
    let bT = BTree(value:value)
    if (preorder.count == 1) { return bT }
    // divide inorder in half using value and recurse
    if let position = inorder.index(of: value) {
      let leftInorder = Array(inorder[0..<position])
      let leftPreorder = Array(preorder[1...leftInorder.count])
      bT.left = treeFrom(preorder:leftPreorder, inorder:leftInorder)
      
      let rightInorder = Array(inorder[position+1..<inorder.count])
      let rightPreorder = Array(preorder[leftInorder.count+1..<inorder.count])
      bT.right = treeFrom(preorder:rightPreorder, inorder:rightInorder)
    }
    return bT
  }
}

extension BTree: CustomStringConvertible {
  var description: String {
    if left != nil && right != nil {
      return "\(value) => [left: \(left!), right: \(right!)]"
    } else if left != nil && right == nil {
      return "\(value) => [left: \(left!), right:]"
    } else if left == nil && right != nil {
      return "\(value) => [left:, right: \(right!)]"
    } else {
      return "\(value)"
    }
  }
  
  func draw() {
    right?.draw(indent:"", " |  ", "    ")
    print("\(value)")
    left?.draw(indent:"", " |  ", "    ")
  }
  
  func draw(indent: String, _ leftIndent: String, _ rightIndent: String) {
    right?.draw(indent: rightIndent, rightIndent + "    ", rightIndent + " |  ")
    print(indent + " +- " + "\(value)")
    left?.draw(indent: leftIndent, leftIndent + " |  ", leftIndent + "    ")
  }
}

// Inorder sequence: D B E A F C
// Preorder sequence: A B D E C F
let inorder = ["D", "B", "E", "A", "F", "C"]
let preorder = ["A", "B", "D", "E", "C", "F"]
let bT = BTree.treeFrom(preorder: preorder, inorder: inorder)
print("\n")
bT?.draw()
print(bT?.description)

