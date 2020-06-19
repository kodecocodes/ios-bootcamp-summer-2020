/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class HomeViewController: UIViewController{

  @IBOutlet weak var view1: ShadowView!
  @IBOutlet weak var view2: ShadowView!
  @IBOutlet weak var view3: ShadowView!
  @IBOutlet weak var view4: ShadowView!
  @IBOutlet weak var view5: ShadowView!
  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var view1TextLabel: UILabel!
  @IBOutlet weak var view2TextLabel: UILabel!
  @IBOutlet weak var view3TextLabel: UILabel!
  @IBOutlet weak var view4TextLabel: UILabel!
  @IBOutlet weak var view5TextLabel: UILabel!
  @IBOutlet weak var themeSwitch: UISwitch!
  
  let crypto = DataGenerator.shared.generateData()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupLabels()
    setView1Data()
    setView2Data()
    setView3Data()
    setView4Data()
    setView5Data()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerForTheme()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForTheme()
  }

  func setupViews() {
  }
  
  func setupLabels() {
    headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    view1TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    view2TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
  }
  
  func setView1Data() {
    let title = crypto?.reduce("") { initialText, crypto in
        guard var title = initialText else { return "" }
        if !title.isEmpty {
          title += ", "
        }
        return title + crypto.name
      }
    view1TextLabel.text = title
  }
  
  func setView2Data() {
    let increasedCryptos = crypto?.filter() {
      $0.currentValue > $0.previousValue
    }.reduce("") { initialText, crypto in
      guard var title = initialText else { return "" }
      if !title.isEmpty {
        title += ", "
      }
      return title + crypto.name
    }
    view2TextLabel.text = increasedCryptos
  }
  
  func setView3Data() {
    let increasedCryptos = crypto?.filter() {
      $0.currentValue < $0.previousValue
    }.reduce("") { initialText, crypto in
      guard var title = initialText else { return "" }
      if !title.isEmpty {
        title += ", "
      }
      return title + crypto.name
    }
    view3TextLabel.text = increasedCryptos
  }
  
  func setView4Data() {
    let maxElement = crypto?.map {
      $0.currentValue - $0.previousValue
    }.min()
    view4TextLabel.text = "\(maxElement!)"
  }
  
  func setView5Data() {
    let minElement = crypto?.map {
      $0.currentValue - $0.previousValue
    }.max()
    view5TextLabel.text = "\(minElement!)"
  }
  
  @IBAction func switchPressed(_ sender: Any) {
    if let button = sender as? UISwitch {
      if button.isOn {
        ThemeManager.shared.set(theme: DarkTheme())
      } else {
        ThemeManager.shared.set(theme: LightTheme())
      }
    }
  }
}


extension HomeViewController: Themeable {
  func registerForTheme() {
    NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: Notification.Name.init("themeChanged"), object: nil)
  }
  
  func unregisterForTheme() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func themeChanged() {
    let theme = ThemeManager.shared.currentTheme
    [view1, view2, view3, view4, view5].forEach { view in
      view?.backgroundColor = theme?.widgetBackgroundColor
      view?.layer.borderColor = theme?.borderColor.cgColor
    }
    [view1TextLabel, view2TextLabel, view3TextLabel, view4TextLabel,view5TextLabel, headingLabel].forEach { label in
      label?.textColor = theme?.textColor
    }
    view.backgroundColor = theme?.backgroundColor
  }
}
