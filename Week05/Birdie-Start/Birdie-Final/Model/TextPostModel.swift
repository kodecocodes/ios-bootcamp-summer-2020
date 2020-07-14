//
//  TextPostModel.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct TextPost: MediaPost {
    var textBody: String?
    var userName: String
    var timestamp: Date
}
