//: Playground - noun: a place where people can play

import UIKit


class Sudoku {
  var board:[[Int]]
  var count:Int = 9
  
  init(count:Int) {
    self.count = count
    self.board = Array(repeating: Array(repeating: 0, count: count), count: count)
  }
  
  func set(row:Int, col:Int, value:Int) {
    self.board[col][row] = value
  }
  
  func makeBoard(offset:Int) {
    var my_offset = 0
    for j in 0..<count {
      for i in 0..<count {
        set(row:j, col:i, value:((i+my_offset)%count)+1)
      }
      my_offset += 4
    }
  }
  
  func checkPerfectBoardCount() -> Bool {
    print("checkPerfectBoardCount()")
    // 9 + 8 + 7 + 6 + 5 + 4 + 3 + 2 + 1 = 45
    // check that all rows, cols and boxes sum to 45
    // rows
    for j in 0..<self.count {
      var sum = 0
      for i in 0..<self.count {
        sum += board[i][j]
      }
//      print("row \(j) : \(sum)")
      if !(sum == 45) {
        print("Bad row \(j)")
        return false
      }
    }
    // cols
    for i in 0..<self.count {
      var sum = 0
      for j in 0..<self.count {
        sum += board[i][j]
      }
//      print("col \(i) : \(sum)")
      if !(sum == 45) {
        print("Bad col \(i)")
        return false
      }
    }
    // squares
    for k in 0..<self.count/3 {
      for l in 0..<self.count/3 {
        var sum = 0
        for j in 0..<self.count/3 {
          for i in 0..<self.count/3 {
            let i_idx = i + 3 * (k%3)
            let j_idx = j + 3 * (l%3)
            sum += board[i_idx][j_idx]
          }
        }
//        print("box \(k),\(l) : \(sum)")
        if !(sum == 45) {
          print("Bad box \(k),\(l)")
          return false
        }
      }
    }
    return true
    
  }
  
  func checkBoard() -> Bool {
    print("checkBoard()")
    // rows
    for j in 0..<self.count {
      var checkBits:[Bool] = Array(repeating: false, count: self.count)
      for i in 0..<self.count {
        let val = board[i][j]
        let val_idx = val-1
        let hit = checkBits[val_idx]
        if (val != 0 && hit == true) {
          print("Bad row \(j)")
          return false
        }
        checkBits[val_idx] = true
      }
    }
    // cols
    for i in 0..<self.count {
      var checkBits:[Bool] = Array(repeating: false, count: self.count)
      for j in 0..<self.count {
        let val = board[i][j]
        let val_idx = val-1
        let hit = checkBits[val_idx]
        if (val != 0 && hit == true) {
          print("Bad col \(i)")
          return false
        }
        checkBits[val_idx] = true
      }
    }
    // squares
    // k : sq. row index 0-2
    // j : sq. col index 0-2
    // i : local sq. row index 0-2
    // j : local sq. col index 0-2
    // i + (3* k%3) : board index
    // j + (3* l%3) : board index
    for l in 0..<self.count/3 {
      for k in 0..<self.count/3 {
        // in square k,l
        // index i + (3* k%3)
        // index j + (3* l%3)
        let i_offset = (3 * (k%3))
        let j_offset = (3 * (l%3))
        var checkBits:[Bool] = Array(repeating: false, count: self.count)
        print("\(k) \(l) ::")
        for j in 0..<self.count/3 {
          var line = ""
          for i in 0..<self.count/3 {
            let i_inx = i + i_offset
            let j_inx = j + j_offset
            let val = board[i_inx][j_inx]
            let val_idx = val-1
            let hit = checkBits[val_idx]
            line = "\(line) :: \(i_inx) \(j_inx) -> \(val)"
            if (val != 0 && hit == true) {
              print(line)
              print("Bad box \(k),\(l)")
              return false
            }
            checkBits[val_idx] = true
          }
          print(line)
        }
        print("\n")
      }
    }
    return true
  }
  
  func describe() {
    for j in 0..<self.count {
      var line = ""
      for i in 0..<self.count {
        line += "\(board[i][j]) "
      }
      print(line)
    }
  }
}

let count = 9
let size = 9/3
let s = Sudoku(count:count)
s.makeBoard(offset: 4)
s.describe()
print(s.checkBoard())
print(s.checkPerfectBoardCount())

// make row order board
//let s2 = Sudoku(count:count)
//s2.makeBoard(offset: 0)
//s2.describe()
//s2.checkBoard()



