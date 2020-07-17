//
//  SmallViews.swift
//  Birdui
//
//  Created by Audrey Tam on 12/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct Header: View {
  let mascotSize: CGFloat = 50
  var body: some View {
    ZStack {
      HStack {
        MascotImage(size: mascotSize, alignment: .leading)
        Spacer()
      }
      .padding(.leading, 20)
      .frame(maxWidth: .infinity)
      Text("Home")
        .font(.title)
        .frame(alignment: .center)
    }
    .frame(maxWidth: .infinity)
  }
}

struct MascotImage: View {
  let size: CGFloat
  let alignment: Alignment
  var body: some View {
    Image("mascot_swift-badge")
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: size, height: size, alignment: alignment)
  }
}

struct PostImage: View {
  let uiImage: UIImage
  let size: CGFloat
  var body: some View {
    Image(uiImage: uiImage)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: size, height: size)
  }
}

struct SmallViews_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Header()
        .previewLayout(.sizeThatFits)
      MascotImage(size: 50, alignment: .leading)
        .previewLayout(.sizeThatFits)
      PostImage(uiImage: UIImage(named: "octopus")!, size: 100)
        .previewLayout(.sizeThatFits)
    }
  }
}
