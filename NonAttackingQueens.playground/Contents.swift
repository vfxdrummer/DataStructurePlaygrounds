//: Playground - noun: a place where people can play

class ChessBoard {
  var positions = [(Int, Int)]()
  
  init() {
  }
  
  public convenience init(cB: ChessBoard) {
    self.init()
    self.positions = cB.positions
  }
  
  func numQueens() -> Int {
    return positions.count
  }
  
  func checkPosition(r:Int, c:Int) -> Bool {
    for position in positions {
      if (position.0 == r && position.1 == c) {
        return true
      }
    }
    return false
  }
  
  func getAvailableCols() -> [Int] {
    var cols:[Int] = []
    for i in 0..<8 {
      var add = true
      for position in positions {
        if position.0 == i {
          add = false
        }
      }
      if add == true {
        cols.append(i)
      }
    }
    
    return cols
  }

  func placeQueen(r:Int, c:Int) {
    let cols = getAvailableCols()
    if (numQueens() < 8 && cols.contains(c)) {
      positions.append((c,r))
    }
  }
  
  func nonAttacking(cB:ChessBoard, row:Int) {
    if (row >= 8) {
      cB.description()
      return
    }
    
    print (cB.getAvailableCols())
    for col in cB.getAvailableCols() {
      let cBNew:ChessBoard = ChessBoard(cB: cB)
      cBNew.placeQueen(r: row, c: col)
      cBNew.nonAttacking(cB: cBNew, row: row + 1)
    }
  }
  
  func description() {
    for j in 0..<8 {
      var descriptionString = ""
      for i in 0..<8 {
        descriptionString += (checkPosition(r: i, c: j)) ? "O " : "X "
      }
      print(descriptionString)
    }
    print("\n")
  }
}

// tests
let c = ChessBoard()
c.description()
c.getAvailableCols()
//c.placeQueen(r: 0, c: 0)
c.getAvailableCols()
// lots of combination & recursion, uncomment @ own peril!!!!
//c.nonAttacking(cB: c, row: 0)

