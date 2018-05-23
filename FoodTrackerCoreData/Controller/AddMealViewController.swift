//
//  AddMealViewController.swift
//  FoodTrackerCoreData
//
//  Created by KuAnh on 23/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit

class AddMealViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectedPhoto: UIImageView!
    @IBOutlet weak var lbName: UITextField!
    @IBOutlet weak var lbAddress: UITextField!
    @IBOutlet weak var rating: RatingControl!
    @IBOutlet weak var lbComment: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { fatalError("error \(info)") }
        selectedPhoto.image = selectImage
        dismiss(animated: true, completion: nil)
    }

    @IBAction func selectedImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}
