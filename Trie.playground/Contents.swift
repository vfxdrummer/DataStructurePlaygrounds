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

//// Trie Data strcuture
//class TrieNode {
//  var character:Character?
//  var children:[TrieNode]
//  
//  init(character:Character?) {
//    self.character = character
//    self.children = []
//  }
//  
//  func findChar(char:Character) -> TrieNode? {
//    for child in children {
//      if (child.character == char) {
//        return child
//      }
//    }
//    return nil
//  }
//  
//  func getWords(partialWord:String) -> [String] {
//    var characterArrays:[String] = []
//    if (self.character == Character("1")) {
//      characterArrays.append(partialWord)
//    } else {
//      // partial string
//      let partialWordNew = partialWord + String(describing: self.character!)
//      for child in children {
//        for word in child.getWords(partialWord:partialWordNew) {
//          characterArrays.append( word )
//        }
//      }
//    }
//    return characterArrays
//  }
//  
//  func describe(indent:String) {
//    for child in children {
//      print("\(indent)\(child.character!)")
//      child.describe(indent:(indent + "  "))
//    }
//  }
//}
//
//// SN
////
//
//class Trie {
//  var root:TrieNode
//  
//  init() {
//    self.root = TrieNode(character:nil)
//  }
//  
//  func insertWord(word:String) {
//    var characters = word.characters
//    print("here")
//    characters.append(Character("1"))
//    var node = root
//    for character in characters {
//      print(character)
//      if let childNode = node.findChar(char:character) {
//        print("found node \(childNode.character!)")
//        node = childNode
//      } else {
//        let childNode = TrieNode(character: character)
//        node.children.append(childNode)
//        print("add node \(childNode.character!)")
//        node = childNode
//      }
//    }
//  }
//  
//  func searchWords(text:String) -> [String] {
//    let characters = text.characters
//    var autocompleteWords:[String] = []
//    var node = root
//    for character in characters {
//      if let childNode = node.findChar(char:character) {
//        node = childNode
//      } else {
//        return []
//      }
//    }
//    // at last character of trie tree, print all complete words
//    for childNode in node.children {
//      for word in childNode.getWords(partialWord:"") {
//        autocompleteWords.append(text + word)
//      }
//    }
//    return autocompleteWords
//  }
//}
//
//let trie = Trie()
//trie.insertWord(word: "snap")
//trie.insertWord(word: "snapchat")
//trie.insertWord(word: "snapchatter")
//trie.root.describe(indent: "")
//let words = trie.searchWords(text: "snap")
//for word in words {
//  print(word)
//}

// test - 4.01.17

// Trie
//
// Api
//  - Insert word(s)
//  - Search word(s)
//  - Remove word(s)
//  - Print word(s)
//
// TrieNode
//  - value : character
//  - next : dictionary - key : char, value : TrieNode?
//
//  - Insert(word)
//      node = rootNode
//      split word into character array, add null
//      while(characters)
//          - grab first character
//              - if it's in next dictionary, node = next[char].trieNode
//              - else, node = createNode(char), insert it in next
//
//  - Search(word)
//      node = rootNode
//      split word into character array, add null
//      while(characters)
//          - grab first character
//              - if it's in next dictionary, node = next[char].trieNode
//              - else, return false
//
//  - Remove word(s)
//
//  - Print words(currentString ="")
//      node = rootNode
//      currentString = ""
//      for each key in next.keys
//          if (key == null) {
//              - print(currentString)
//          else
//              currentString += key // add character to current string
//              printWords(currentString: currentString)
//
//


class TrieNode {
    public var value : Character
    public var next : [Character:TrieNode]
    
    init(value:Character) {
        self.value = value
        self.next = [:]
    }
    
    public func printWords(currentString: String) {
        for character in self.next.keys {
            if (character == "\n") {
                print("WORD : \(currentString)")
            } else {
                let newStr = currentString + String(character)
                let node = self.next[character]!
                node.printWords(currentString: newStr)
            }
        }
    }
}

class Trie {
    private var root:TrieNode
    
    init() {
        root = TrieNode(value: "\0")
    }
    
    public func insert(word: String) {
        var characters = word.characters
        characters.append("\n")
        var node:TrieNode = root
        print(node)
        for character in characters {
            if let nextNode = node.next[character] as TrieNode! {
                node = nextNode
            } else {
                print("insert \(character)")
                let newNode = TrieNode(value: character)
                node.next[character] = newNode
                node = newNode
            }
        }
    }
    
    
    public func search(word: String) -> Bool {
        var characters = word.characters
        characters.append("\n")
        var node:TrieNode = root
        print(node)
        for character in characters {
            if let nextNode = node.next[character] as TrieNode! {
                node = nextNode
            } else {
                return false
            }
        }
        return true
    }
    
    public func printWords() {
        root.printWords(currentString: "")
    }
}


// Test
let n = TrieNode(value: "\0")
print(n.value)

let t = Trie()

t.insert(word:"snap")
t.insert(word:"snapchat")
t.printWords()

print(t.search(word:"snap"))
print(t.search(word:"snapchat"))
print(t.search(word:"snapchatz"))



