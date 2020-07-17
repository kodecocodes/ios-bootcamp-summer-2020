//
//  Date+Ext.swift
//  Birdui
//
//  Created by Audrey Tam on 12/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import Foundation

extension Date {
  func formatted(as format: String) -> String {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = format
    return dateFormat.string(from: self)
  }
}
