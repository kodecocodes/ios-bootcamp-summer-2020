//
//  AppDelegate.swift
//  Birdui
//
//  Created by Audrey Tam on 3/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

// For UIImage
import UIKit

struct MediaPost: Identifiable {
  let id = UUID()
  let textBody: String?
  let userName: String
  let timestamp: Date
  let uiImage: UIImage?
}
