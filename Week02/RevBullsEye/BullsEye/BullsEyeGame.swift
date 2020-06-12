// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import Foundation

class BullsEyeGame {
  var round = 0
  let startValue = 50
  var targetValue = 50
  var scoreRound = 0
  var scoreTotal = 0
  
  init() {
    startNewGame()
  }

  func startNewGame() {
    round = 0
    scoreTotal = 0
    startNewRound()
  }

  func startNewRound() {
    round += 1
    scoreRound = 0
    targetValue = Int.random(in: 1...100)
  }

  func check(guess: Int) -> Int {
    let difference = abs(targetValue - guess)
    scoreRound = 100 - difference
    if difference == 0 { scoreRound += 100 }
    else if difference == 1 { scoreRound += 50 }
    scoreTotal += scoreRound
    
    return difference
  }
  
}
