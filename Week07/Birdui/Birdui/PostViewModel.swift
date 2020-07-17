//
//  PostViewModel.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

// For Combine protocols
import SwiftUI

class PostViewModel: ObservableObject {
  @Published var posts: [MediaPost] = []
  
  init() {
    let imagePost1 = MediaPost(textBody: "I love debugging software!", userName: "Jay", timestamp: Date(timeIntervalSinceNow: -123456), uiImage: UIImage(named: "chop"))
    let imagePost2 = MediaPost(textBody: "Went to the Aquarium today :]", userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876), uiImage: UIImage(named:  "octopus"))
    let textPost1 = MediaPost(textBody: "Hello World!", userName: "Bhagat", timestamp: Date(timeIntervalSinceNow: -67890), uiImage: nil)
    let textPost2 = MediaPost(textBody: "This is my favorite social media app! This is my favorite social media app! This is my favorite social media app!", userName: "Jeff", timestamp: Date(timeIntervalSinceNow: -2345), uiImage: nil)
    
    posts = [imagePost1, imagePost2, textPost1, textPost2].sorted(by: { $0.timestamp > $1.timestamp })
  }
  
  func addPost(post: MediaPost) {
      posts.append(post)
      posts = posts.sorted(by: { $0.timestamp > $1.timestamp })
  }
}
