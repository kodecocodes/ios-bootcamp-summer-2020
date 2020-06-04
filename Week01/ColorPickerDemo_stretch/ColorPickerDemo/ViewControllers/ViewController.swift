//
//  ViewController.swift
//  ColorPickerDemo
//
//  Created by Jeff Rames on 5/31/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let rgbMode = 0
  let hsbMode = 1
  
  var currentMode = 0
  
  var roundedValue1: Float = 0.0
  var roundedValue2: Float = 0.0
  var roundedValue3: Float = 0.0
  
  @IBOutlet weak var colorName: UILabel!
  
  @IBOutlet weak var slider1Name: UILabel!
  @IBOutlet weak var slider1: UISlider!
  @IBOutlet weak var slider1Value: UILabel!
  
  @IBOutlet weak var slider2Name: UILabel!
  @IBOutlet weak var slider2: UISlider!
  @IBOutlet weak var slider2Value: UILabel!
  
  @IBOutlet weak var slider3Name: UILabel!
  @IBOutlet weak var slider3: UISlider!
  @IBOutlet weak var slider3Value: UILabel!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    currentMode = rgbMode
    
    // Set Slider Values
    slider1.minimumValue = 0.0
    slider2.minimumValue = 0.0
    slider3.minimumValue = 0.0
    
    setRGBMode()
    resetUI()
  }
  
  // MARK: - Slider Actions
  @IBAction func slider1Changed(_ sender: UISlider) {
    roundedValue1 = sender.value.rounded()
    slider1Value.text = Int(roundedValue1).description
  }
  
  @IBAction func slider2Changed(_ sender: UISlider) {
    roundedValue2 = sender.value.rounded()
    slider2Value.text = Int(roundedValue2).description
  }
  
  @IBAction func slider3Changed(_ sender: UISlider) {
    roundedValue3 = sender.value.rounded()
    slider3Value.text = Int(roundedValue3).description
  }
  
  // MARK: - Button Actions
  @IBAction func resetPressed(_ sender: Any) {
    resetUI()
  }
    
  @IBAction func setColorPressed(_ sender: Any) {
    let alertController = UIAlertController(title: "Name",
                                            message: "What do you want to name this color?",
                                            preferredStyle: .alert)
    alertController.addTextField()
    
    let submitAction = UIAlertAction(title: "Set Name", style: .default, handler: {
      action in
      let name = alertController.textFields![0]
      self.colorName.text = name.text
      
      self.setBackgroundColor()
    })
    
    alertController.addAction(submitAction)
    
    present(alertController, animated: false) {
    }
  }
  
  func setBackgroundColor() {
    var color = UIColor.black
    
    if currentMode == rgbMode {
      color = UIColor(red: CGFloat(roundedValue1) / 255.0,
                      green: CGFloat(roundedValue2) / 255.0,
                      blue: CGFloat(roundedValue3) / 255.0,
                      alpha: 1.0)
    } else {
      color = UIColor(hue: CGFloat(roundedValue1) / 360.0,
                      saturation: CGFloat(roundedValue2) / 100.0,
                      brightness: CGFloat(roundedValue3) / 100.0,
                      alpha: 1.0)
    }
    
    view.backgroundColor = color
  }
  
  // MARK: - Segmented Controler
  @IBAction func modeChanged(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == rgbMode {
      setRGBMode()
    } else if sender.selectedSegmentIndex == hsbMode {
      setHSBMode()
    }
    
    resetUI()
  }
  
  func setRGBMode() {
    currentMode = rgbMode
    
    // Set Max Slider Values
    slider1.maximumValue = 255.0
    slider2.maximumValue = 255.0
    slider3.maximumValue = 255.0
    
    // Set Label Names
    slider1Name.text = "Red"
    slider2Name.text = "Green"
    slider3Name.text = "Blue"
  }
  
  func setHSBMode() {
    currentMode = hsbMode
    
    // Set Max Slider Values
    slider1.maximumValue = 360.0
    slider2.maximumValue = 100.0
    slider3.maximumValue = 100.0
    
    // Set Label Names
    slider1Name.text = "Hue"
    slider2Name.text = "Saturation"
    slider3Name.text = "Brightness"
  }
  
  // MARK: - Utility Methods
  func resetUI() {
    // Set Label Values
    slider1.value = 0.0
    slider2.value = 0.0
    slider3.value = 0.0

    // Set roundedValues
    roundedValue1 = 0.0
    roundedValue2 = 0.0
    roundedValue3 = 0.0
    
    // Set Label Values
    slider1Value.text = "0"
    slider2Value.text = "0"
    slider3Value.text = "0"

    colorName.text = "Black"
    view.backgroundColor = .black
  }
}
