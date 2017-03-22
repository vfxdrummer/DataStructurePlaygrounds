//We have a xml parser converting this xml to a csv format, open means open tag, close means close tag, inner is just inner text.
//
//[
//"open,story",
//"open,id",
//"inner,1234",
//"close,id",
//"open,snaps",
//"open,snap",
//"close,snap",
//"open,snap",
//"close,snap",
//"open,snap",
//"close,snap",
//"open,snap",
//"close,snap",
//"close,snaps",
//"close,story"
//]

import UIKit

class XMLNode {
  var name:String
  var value:String?
  var parent:XMLNode?
  var children:[XMLNode]
  
  init(name:String) {
    self.name = name
    self.value = nil
    self.parent = nil
    self.children = []
  }
  
  func description(indent:String) {
    print("\(indent)<\(name) \(value)> ")
    for child in children {
      child.description(indent:indent + " ")
    }
  }
}

func parseList(list:Array<String>) -> XMLNode {
  let root = XMLNode(name: "root")
  var node = root
  
  for item in list {
    var toks = item.characters.split{$0 == ","}
    switch(String(toks[0])) {
    case "open":
      let childNode = XMLNode(name: String(toks[1]))
      childNode.parent = node
      node.children.append(childNode)
      node = childNode
    case "inner":
      node.value = String(toks[1])
    case "close":
      if (node.parent != nil) {
        node = node.parent!
      }
    default:
      print("default")
    }
  }
  
  return root
}

let list = ["open,story",
"open,id",
"inner,1234",
"close,id",
"open,snaps",
"open,snap",
"close,snap",
"open,snap",
"close,snap",
"open,snap",
"close,snap",
"open,snap",
"close,snap",
"close,snaps",
"close,story"
]

let root = parseList(list: list)
root.description(indent: "")

