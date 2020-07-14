//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!

    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    func setUpTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "TextPostTableViewCell", bundle: nil), forCellReuseIdentifier: "textCell")
        tableview.register(UINib(nibName: "ImagePostTableViewCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        MediaPostsHandler.shared.getPosts()
        tableview.reloadData()
    }

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        createPost(isImagePost: false)
    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {
        createPost(isImagePost: true)
    }

    func createPost(isImagePost: Bool) {
        if isImagePost {
            // First get the image you want to use, then continue as normal
            let vc = UIImagePickerController()
            vc.delegate = self
            present(vc, animated: true)
        } else {
            showAlert()
        }
    }

    func showAlert() {
        let alert = UIAlertController(title: "Create Post", message: "What's up? :]", preferredStyle: UIAlertController.Style.alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Username"
        }

        alert.addTextField { (textField) in
            textField.placeholder = "Text"
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction) in

            // Date() simply creates a date with the timestamp of "now"
            if let image = self.selectedImage {
                let post = ImagePost(textBody: alert.textFields?[1].text, userName: alert.textFields?[0].text ?? "", timestamp: Date(), image: image)
                // Make sure to set selectedImage nil after creating the post
                self.selectedImage = nil
                MediaPostsHandler.shared.addImagePost(imagePost: post)
            } else {
                let post = TextPost(textBody: alert.textFields?[1].text, userName: alert.textFields?[0].text ?? "", timestamp: Date())
                MediaPostsHandler.shared.addTextPost(textPost: post)
            }

            self.tableview.reloadData()
        }))

        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MediaPostsHandler.shared.mediaPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = MediaPostsHandler.shared.mediaPosts[indexPath.row]
        let cell = MediaPostsViewModel.shared.setUpTableViewCell(for: post, in: tableView)
        return cell
    }
}

// MARK: UIImagePickerControllerDelegate
extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage

        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }

        // Set the image here & show alert after dismissing
        selectedImage = newImage

        dismiss(animated: true)
        showAlert()
    }
}

