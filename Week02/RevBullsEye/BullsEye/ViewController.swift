// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit

class ViewController: UIViewController {
  let game = BullsEyeGame()
  var currentValue = 0

  @IBOutlet weak var slider: UISlider!
//  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var guessField: UITextField!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  
  // Treat: Hint
  var quickDiff: Int {
    return abs(game.targetValue - currentValue)
  }
  
  @objc private func giveHint(_ textField: UITextField) {
    if let string = guessField.text,
      let input = Int(string) {
      currentValue = input
      slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100.0)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    guessField.addTarget(self, action: #selector(self.giveHint), for: .editingChanged)
    updateView()
  }
  
    func updateView() {
  //    targetLabel.text = String(game.targetValue)
  //    slider.value = Float(game.startValue)
      guessField.text = ""
      slider.value = Float(game.targetValue)
      scoreLabel.text = String(game.scoreTotal)
      roundLabel.text = String(game.round)
      
      currentValue = 0
      slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100.0)
      
      // cheat
      print(game.targetValue)
    }
  
  @IBAction func tapped(_ sender: Any) {
    view.endEditing(true)
  }

  @IBAction func showAlert() {
//    let sliderValue = lroundf(slider.value)
//    let difference = game.check(guess: sliderValue)
    guard let string = guessField.text,
      let guess = Int(string) else { return }
    let difference = game.check(guess: guess)
    
    let title: String
    if difference == 0 {
      title = "Perfect!"
    } else if difference < 5 {
      title = "You almost had it!"
    } else if difference < 10 {
      title = "Pretty good!"
    } else {
      title = "Not even close..."
    }
    
    let message = "You scored \(game.scoreRound) points"
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: {
      action in
      self.game.startNewRound()
      self.updateView()
    })
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
//  @IBAction func sliderMoved(_ slider: UISlider) {
//    // Treat: Hint
//    currentValue = Int(slider.value.rounded())
//    slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100.0)
//  }
  
  @IBAction func startNewGame() {
    game.startNewGame()
    updateView()
  }
}
