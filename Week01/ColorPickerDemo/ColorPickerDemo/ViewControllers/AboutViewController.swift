//
//  AboutViewController.swift
//  ColorPickerDemo
//
//  Created by Jeff Rames on 6/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {

  @IBOutlet weak var webView: WKWebView!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "https://en.wikipedia.org/wiki/RGB_color_model") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
  }
  
  @IBAction func closePressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
}
