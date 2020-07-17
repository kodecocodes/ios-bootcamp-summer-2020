//
//  PostView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct PostView: View {
  let post: MediaPost
  let mascotSize: CGFloat = 50
  let imageSize: CGFloat = 100
  
  var body: some View {
    VStack {
      VStack(alignment: .leading) {
        HStack {
          MascotImage(size: mascotSize, alignment: .center)
          VStack(alignment: .leading) {
            Text(post.userName)
            Text(post.timestamp
              .formatted(as: "d MMM, HH:mm"))
          }
        }
        Text(post.textBody!)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      if post.uiImage != nil {
        PostImage(uiImage: post.uiImage!, size: imageSize)
      }
    }
  }
}



struct PostView_Previews: PreviewProvider {
  static var previews: some View {
    PostView(post: MediaPost(
      textBody: "Went to the Aquarium today :]",
      userName: "Audrey",
      timestamp: Date(timeIntervalSinceNow: -9876),
      uiImage: UIImage(named: "octopus")))
      .previewLayout(.sizeThatFits)
  }
}
