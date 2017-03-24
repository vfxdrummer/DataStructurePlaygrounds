// Flood Fill algorithm
// fill neighboring pixels of a 2D array with similar color with new color
//

import UIKit

class Pixel {
  var color:CGColor
  
  init(color:CGColor) {
    self.color = color
  }
}

class ImageMap {
  var pixels:[[Pixel]] = []
  var width:Int
  
  init(width:Int) {
    self.width = width
    // initialize to black
    for i in 0..<width {
      var columnArray = Array<Pixel>()
      for _ in 0..<width {
        columnArray.append(Pixel(color:UIColor(red:0, green:0, blue:0, alpha:1).cgColor))
      }
      pixels.append(columnArray)
    }
  }
  
  func floodFill(pixel:(Int,Int), startColor:CGColor, endColor:CGColor) {
    let (x,y) = pixel
    guard (pixels[x][y].color == startColor) else {
      return
    }
    pixels[x][y].color = endColor
    // recurse
    let recursePoints = [(x,y+1),(x+1,y),(x,y-1),(x,y-1)]
    for point in recursePoints {
      let (x,y) = point
      if (x >= 0 && x < width && y >= 0 && y < width) {
        floodFill(pixel:point, startColor:startColor, endColor:endColor)
      }
    }
  }
  
  func floodFill(pixel:(Int,Int), endColor:CGColor) {
    let (x,y) = pixel
    let startColor = pixels[x][y].color
    print("startColor: \(startColor.components![0]) \(startColor.components![1]) \(startColor.components![2]) ")
    floodFill(pixel:pixel, startColor:startColor, endColor:endColor)
  }
  
  func describe() {
    for j in 0..<width {
      var line = ""
      for i in 0..<width {
        let c = pixels[i][j].color.components
        line += "(\(c![0]) \(c![1]) \(c![2])) "
      }
      print(line)
    }
  }
}


// Test
let map = ImageMap(width:10)
map.describe()

let startColor = UIColor(red:0, green:0, blue:0, alpha:1)
let endColor = UIColor(red:1, green:1, blue:1, alpha:1)
let thirdColor = UIColor(red:0.5, green:0.5, blue:0.5, alpha:1)
map.floodFill(pixel: (0,0), endColor:endColor.cgColor)
map.describe()

for i in 0..<10 {
  map.pixels[i][i].color = startColor.cgColor
}
map.describe()
map.floodFill(pixel: (0,9), endColor:thirdColor.cgColor)
map.describe()




