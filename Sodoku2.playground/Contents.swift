//: Playground - noun: a place where people can play

import UIKit

class Soduko {
  var board:[[Int]] = [[Int]]()
  var count:Int = 9
  var rowDictArray:[[Int:Bool]] = []
  var colDictArray:[[Int:Bool]] = []
  var squareDictArray:[[Int:Bool]] = []
  
  init(count:Int) {
    self.count = count
    
    var initArray:[Int] = []
    // init row
    for _ in 0..<count {
      initArray.append(-1)
    }
    // init columns
    for _ in 0..<count {
      self.board.append(initArray)
    }
    // init hash table
    for _ in 0..<count {
      var rowDict:[Int:Bool] = [:]
      var colDict:[Int:Bool] = [:]
      var squareDict:[Int:Bool] = [:]
      for j in 0..<count {
        rowDict[j] = false
        colDict[j] = false
        squareDict[j] = false
      }
      self.rowDictArray.append(rowDict)
      self.colDictArray.append(colDict)
      self.squareDictArray.append(squareDict)
    }
  }
  
  func set(i:Int, j:Int, num:Int) {
    board[i][j] = num
    rowDictArray[j][num] = true
    colDictArray[i][num] = true
    squareDictArray[(i/3 + j/3)][num] = true
  }
  
  func createSolvedBoard() {
    var squareRowOffset = 0
    var squareColOffset = 0
    
    // vert squares
    for k in 0..<3 {
      // horiz. squares
      for j in 0..<3 {
        for i in 0..<9 {
          let num = (squareRowOffset + squareColOffset + (3*j + i))
          //let num = 3*j + i
          board[i][3*k + j] = (num % 9)
        }
        squareRowOffset += 3
      }
      squareColOffset += 1
    }
  }
  
  func check() -> Bool {
    // check rows
    for j in 0..<9 {
      var rowDict:[Int:Bool] = [:]
      for i in 0..<9 {
        let num = board[i][j]
        if (rowDict[num] == true) {
          return false
        }
        rowDict[num] = true
      }
    }
    // check cols
    for i in 0..<9 {
      var colDict:[Int:Bool] = [:]
      for j in 0..<9 {
        let num = board[i][j]
        if (colDict[num] == true) {
          return false
        }
        colDict[num] = true
      }
    }
    // check squares
    for l in 0..<3 {
      for k in 0..<3 {
        var squareDict:[Int:Bool] = [:]
        var squareString = ""
        for j in 0..<3 {
          for i in 0..<3 {
            let num = board[3*l + i][3*k + j]
            if (squareDict[num] == true) {
              return false
            }
            squareDict[num] = true
          }
        }
        print(squareString)
      }
    }
    
    return true
  }
  
  func describe() {
    for j in 0..<count {
      var rowString = ""
      for i in 0..<count {
        rowString += "\(board[i][j]) "
      }
      print(rowString)
    }
    print("\n")
  }
}

// Test
let s = Soduko(count:9)
s.createSolvedBoard()
s.describe()
s.check()
