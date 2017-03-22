//: Playground - noun: a place where people can play

import UIKit





// This is the text editor interface.
// Anything you type or change here will be seen by the other person in real time.

// API
// class Trie {
// insertWord(word:String)
// insertWords(words:[String])
// searchPossibleWords(substring:String) -> [String]
// }
// SNAP, SNAPCHAT, CHAT

// Trie Data strcuture
class TrieNode {
  var character:Character?
  var children:[TrieNode]
  
  init(character:Character?) {
    self.character = character
    self.children = []
  }
  
  func findChar(char:Character) -> TrieNode? {
    for child in children {
      if (child.character == char) {
        return child
      }
    }
    return nil
  }
  
  func getWords(partialWord:String) -> [String] {
    var characterArrays:[String] = []
    if (self.character == Character("1")) {
      characterArrays.append(partialWord)
    } else {
      // partial string
      let partialWordNew = partialWord + String(describing: self.character!)
      for child in children {
        for word in child.getWords(partialWord:partialWordNew) {
          characterArrays.append( word )
        }
      }
    }
    return characterArrays
  }
  
  func describe(indent:String) {
    for child in children {
      print("\(indent)\(child.character!)")
      child.describe(indent:(indent + "  "))
    }
  }
}

// SN
//

class Trie {
  var root:TrieNode
  
  init() {
    self.root = TrieNode(character:nil)
  }
  
  func insertWord(word:String) {
    var characters = word.characters
    print("here")
    characters.append(Character("1"))
    var node = root
    for character in characters {
      print(character)
      if let childNode = node.findChar(char:character) {
        print("found node \(childNode.character!)")
        node = childNode
      } else {
        let childNode = TrieNode(character: character)
        node.children.append(childNode)
        print("add node \(childNode.character!)")
        node = childNode
      }
    }
  }
  
  func searchWords(text:String) -> [String] {
    let characters = text.characters
    var autocompleteWords:[String] = []
    var node = root
    for character in characters {
      if let childNode = node.findChar(char:character) {
        node = childNode
      } else {
        return []
      }
    }
    print("!!! \(node.character)")
    // at last character of trie tree, print all complete words
    for childNode in node.children {
      for word in childNode.getWords(partialWord:"") {
        autocompleteWords.append(text + word)
      }
    }
    return autocompleteWords
  }
}

let trie = Trie()
trie.insertWord(word: "snap")
trie.insertWord(word: "snapchat")
trie.insertWord(word: "snapchatter")
trie.root.describe(indent: "")
let words = trie.searchWords(text: "snap")
for word in words {
  print(word)
}



