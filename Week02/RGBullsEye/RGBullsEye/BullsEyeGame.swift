// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import Foundation

class BullsEyeGame {
  var round = 0
  let startValue = RGB()
  var targetValue = RGB()
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
    targetValue = RGB.random()
  }
  
  func check(guess: RGB) -> Int {
    let difference = lround(guess.difference(target: targetValue) * 100.0)
    scoreRound = 100 - difference
    if difference == 0 { scoreRound += 100 }
    else if difference == 1 { scoreRound += 50 }
    scoreTotal += scoreRound
    
    return difference
  }
}
