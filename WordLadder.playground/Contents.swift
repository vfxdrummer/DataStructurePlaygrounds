// Given two words (start and end), and a dictionary, find the length of shortest transformation sequence from start to end, such that only one letter can be changed at a time and each intermediate word must exist in the dictionary. For example, given:
//
// start = "hit"
// end = "cog"
// dict = ["hot","dot","dog","lot","log"]
// One shortest transformation is "hit" -> "hot" -> "dot" -> "dog" -> "cog", the program should return its length 5.

import UIKit

class wordNode {
  var word:String = ""
  var level:Int = 0
  
  init(word:String, level:Int) {
    self.word = word
    self.level = level
  }
}

func wordLadder(start:String, end:String, words:Array<String>) -> Int {
  let alphabet = "abcdefghijklmnopqrstuvyxyz".characters.flatMap { $0.description }
  
  var newWords = words
  newWords.append(end)
  print(newWords)
  
  var wordList:[wordNode] = []
  wordList.append(wordNode(word:start, level:1))
  
  var z = 0
//  while wordList.count > 0 {
  while (z < 5) {
    print(wordList.count)
    let node = wordList[z]
    print(node.word)
    let characters = Array(node.word.characters)
    var i = 0
    for _ in characters {
      for letter in alphabet {
        var newCharacters = Array(characters)
        newCharacters[i] = Array(letter.characters)[0]
        let word = String(newCharacters)
        if newWords.contains(word) {
          if let i = newWords.index(where: { $0 == word}) {
            newWords.remove(at: i)
          }
          print(word)
          if (word == end) {
            return node.level
          } else {
            let newNode = wordNode(word:word, level:node.level+1)
            wordList.append(newNode)
          }
        }
      }
      i += 1
    }
    z += 1
  }
  
  return 0
}

let length = wordLadder(start: "hit", end: "cog", words: ["hot","dot","dog","lot","log"])
print(length)
