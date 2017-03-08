//
// LinkedList
//
//
//

public class LinkedList<T : Equatable> {
  var value:T
  var next:LinkedList?
  
  init(value:T) {
    self.value = value
    self.next = nil
  }
  
  public convenience init(array: [T]) {
    precondition(array.count > 0)
    self.init(value: array.first!)
    var node = self
    for v in array.dropFirst() {
      let newNode = LinkedList<T>(value: v)
      node.addNode(node: newNode)
      node = newNode
    }
  }
  
  func addNode(node:LinkedList<T>) {
    next = node
  }
  
  func findPreviousNode(value:T) -> LinkedList? {
    var node:LinkedList? = self
    var previous:LinkedList? = nil
    while (node != nil) {
      if (node!.value == value) {
        return previous
      }
      previous = node
      node = node?.next
    }
    return nil
  }
  
  func findNode(value:T) -> LinkedList? {
    var node:LinkedList? = self
    while (node != nil) {
      if (node!.value == value) {
        return node
      }
      node = node?.next
    }
    return nil
  }
  
  func copyNode(node:LinkedList?) {
    if (node == nil) { return }
    self.value = node!.value
    self.next = node!.next
  }
  
  func deleteNode(value:T) {
    // assumes that self is root
    let node = findPreviousNode(value: value)
    if (node == nil) {
      if (next != nil) {
        // copy next node over root
        self.copyNode(node: next!)
      }
      return
    }
    // set pointer to jump node to delete
    // leave deleted node to be cleaned up by ARC
    node?.next = node?.next?.next
  }
  
  func display() -> String {
    var node:LinkedList? = self
    var displayString = ""
    while (node != nil) {
      print("")
      displayString += "\(node!.value) -> "
      node = node?.next
    }
    return displayString
  }
}


// create linkedlist nodes
let n1 = LinkedList<Int>(value: 7)
print(n1.value)
// add node
n1.addNode(node:LinkedList<Int>(value: 9))
n1.display()
n1.findNode(value: 9)?.value
n1.findPreviousNode(value: 9)?.value
n1.deleteNode(value: 9)
n1.display()
let n2 = LinkedList<Int>(array:[1,2,3,4,5,6,7,8])
n2.display()
n2.deleteNode(value: 4)
n2.display()
n2.deleteNode(value: 1)
n2.display()





