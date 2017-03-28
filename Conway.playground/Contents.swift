//: Playground - noun: a place where people can play

import UIKit

class Conway {
  var board:[[Bool]] = []
  var count:Int = 10
  
  init(count:Int) {
    var initArray:[Bool] = []
    for i in 0..<count {
      initArray.append(false)
    }
    for i in 0..<count {
      board.append(initArray)
    }
  }
  
  func set(i:Int, j:Int, mark:Bool) {
    board[i][j] = mark
  }
  
  func updateBoard() {
    var new_board:[[Bool]] = self.board
    
    // iterate and find each set item
    for j in 0..<count {
      var live_count_string = ""
      for i in 0..<count {
        // get live neighbor count
        var live_count = 0
        for l in -1..<2 {
          for k in -1..<2 {
            let new_j = j + l
            let new_i = i + k
            if new_j >= 0 && new_j < count &&
              new_i >= 0 && new_i < count &&
              !(new_i == i && new_j == j) {
              if (board[new_i][new_j] == true) {
                live_count += 1
              }
            }
          }
        }
        live_count_string += "\(live_count) "
        if (board[i][j] == true) {
          switch(live_count) {
          case let x where x < 2:
            new_board[i][j] = false
          case let x where x > 3:
            new_board[i][j] = false
          default:
            new_board[i][j] == true
          }
        } else if (live_count == 3) {
          new_board[i][j] = true
        }
      }
      // print(live_count_string)
      self.board = new_board
    }
  }
  
  func describe() {
    for j in 0..<count {
      var rowString = ""
      for i in 0..<count {
        let val = (board[i][j]) == true ? "X" : "-"
        rowString += "\(val) "
      }
      print(rowString)
    }
    print("\n")
  }
  
}

// Test
let c = Conway(count:10)
c.set(i:4, j:4, mark:true)
c.set(i:4, j:5, mark:true)
c.set(i:5, j:4, mark:true)
c.set(i:6, j:4, mark:true)
c.set(i:4, j:6, mark:true)
c.describe()
c.updateBoard()
c.describe()
c.updateBoard()
c.describe()
c.updateBoard()
c.describe()
c.updateBoard()
c.describe()
