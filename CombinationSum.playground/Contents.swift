//
// Combination Sum
//
// Find first N numbers that add up to X
//

import UIKit

// solve 1 first

func combination(inArray:Array<Int>, chosenArray:Array<Int>, count:Int, sum:Int) -> [Int] {
  var currentSum = 0
  var leftArray = inArray
  for chosen in chosenArray {
    var i = 0
    for left in leftArray {
      if left == chosen {
        leftArray.remove(at: i)
        i += 1
      }
    }
    currentSum += chosen
  }
  print("count \(count) currentSum \(currentSum) sum \(sum)")
  for item in leftArray {
    print("item -> \(item)")
    if (count == 1) {
      if (count == 1 && (currentSum + item) == sum) {
        print("count == 1, (currentSum + item) == sum)")
        var newChosenArray = chosenArray
        newChosenArray.append(item)
        return newChosenArray
      }
    } else if (count >= 0) {
      if (currentSum + item < sum) {
        var newChosenArray = chosenArray
        newChosenArray.append(item)
        print("Adding \(currentSum) + \(item) < \(sum)")
        return combination(inArray: inArray, chosenArray: newChosenArray, count: count-1, sum: sum)
      }
    }
  }
  
  return []
}

// Test
// check count == 1
let array = [1, 3, 5, 7, 9]
let sum = 7
let result = combination(inArray: array, chosenArray:[], count: 1, sum: 7)
print(result)
print("\n")

// check count == 2
let result2 = combination(inArray: array, chosenArray:[], count: 2, sum: 8)
print(result2)
print("\n")

// check count == 2
let result3 = combination(inArray: array, chosenArray:[], count: 3, sum: 13)
print(result3)
print("\n")

