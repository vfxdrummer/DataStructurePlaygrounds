//
// Shuffle - Implementing Fisher–Yates
//

import UIKit

enum Suit {
  case Diamonds
  case Spades
  case Clubs
  case Hearts
}

class Card {
  var name:String
  var suit:Suit
  
  init(name:String, suit:Suit) {
    self.name = name
    self.suit = suit
  }
  
  func describe() {
    print("name : \(name) suit : \(suit) ")
  }
}

func shuffle(cards:[Card]) -> [Card] {
  var shuffledCards = cards
  
  var i = shuffledCards.count - 1
  while (i > 0) {
    let pick = Int(arc4random_uniform(UInt32(i)))
    let temp = shuffledCards[pick]
    shuffledCards[pick] = shuffledCards[i]
    shuffledCards[i] = temp
    i -= 1
  }
  
  return shuffledCards
}

// Test
var cards:[Card] = []
for suit in [Suit.Diamonds, Suit.Spades, Suit.Clubs, Suit.Hearts] {
  cards.append(Card(name:"1", suit:suit))
  cards.append(Card(name:"2", suit:suit))
  cards.append(Card(name:"3", suit:suit))
  cards.append(Card(name:"4", suit:suit))
  cards.append(Card(name:"5", suit:suit))
}

print("unshuffled")
for card in cards {
  card.describe()
}

print("shuffled")
let shuffled = shuffle(cards:cards)
for card in shuffled {
  card.describe()
}








