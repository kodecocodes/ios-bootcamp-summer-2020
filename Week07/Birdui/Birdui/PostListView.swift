//
//  PostListView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct PostListView: View {
  @ObservedObject var postViewModel = PostViewModel()
  @State var showNewPostView = false
  var body: some View {
    VStack(alignment: .leading) {
      Header()
      Button("Create New Post") {
        self.showNewPostView.toggle()
      }
      .padding(.leading, 20)
      List(postViewModel.posts) { post in
        PostView(post: post)
      }
    }
    .sheet(isPresented: $showNewPostView) {
      NewPostView(postHandler: self.postViewModel)
    }
  }
}

struct PostListView_Previews: PreviewProvider {
  static var previews: some View {
    PostListView()
  }
}
