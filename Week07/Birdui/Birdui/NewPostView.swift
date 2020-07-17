//
//  NewPostView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct NewPostView: View {
  var postHandler: PostViewModel
  @Environment(\.presentationMode) var presentationMode
  
  @State var username: String = ""
  @State var postText: String = ""
  @State var showImagePicker = false
  @State var uiImage: UIImage?
  
  let imageSize: CGFloat = 200
  
  var body: some View {
    VStack {
      Text("New Post")
        .font(.headline)
      Form {
        TextField("Username", text: $username)
        Button("Pick image") {
          self.showImagePicker = true
        }
        if uiImage != nil {
          PostImage(uiImage: uiImage!, size: imageSize)
        }
        TextField("Post text", text: $postText)
      HStack {
        Button("Cancel") {
          self.presentationMode.wrappedValue.dismiss()
        }
        Spacer()
        Button("Post") {
          self.postHandler.addPost(post: MediaPost(textBody: self.postText, userName: self.username, timestamp: Date(), uiImage: self.uiImage))
          self.presentationMode.wrappedValue.dismiss()
        }
        .disabled(username.isEmpty && postText.isEmpty)
      }
      .padding()
      }
    }
    .sheet(isPresented: $showImagePicker) {
      ImagePicker(uiImage: self.$uiImage)
    }
  }
}

struct NewPostView_Previews: PreviewProvider {
  static var previews: some View {
    NewPostView(postHandler: PostViewModel())
  }
}
