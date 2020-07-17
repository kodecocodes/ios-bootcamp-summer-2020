//
//  ImagePicker.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  @Environment(\.presentationMode) var presentationMode
  @Binding var uiImage: UIImage?
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
  }
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: ImagePicker
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
      if let pickedImage = info[.originalImage] as? UIImage {
        parent.uiImage = pickedImage
      }
      
      parent.presentationMode.wrappedValue.dismiss()
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
}
