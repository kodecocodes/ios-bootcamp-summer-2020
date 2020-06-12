// Copyright (c) 2020 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

import UIKit

class AboutViewController: UIViewController {
  @IBAction func close(sender: AnyObject) {
    presentingViewController?.dismiss(animated: true, completion: nil)
  }
}
