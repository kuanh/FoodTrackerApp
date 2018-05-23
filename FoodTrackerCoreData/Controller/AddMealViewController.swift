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
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if meal == nil {
            lbName.text = meal?.name
            lbAddress.text = meal?.address
            guard let rating = meal?.rating else { return }
            self.rating.rating = Int(rating)
            selectedPhoto.image = meal?.image as? UIImage
            lbComment.isEnabled = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if meal != nil {
            selectedPhoto.image = UIImage(named: "defaultPhoto")
            lbName.text = ""
            lbAddress.text = ""
            rating.rating = 0
            lbComment.text = ""
        }
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
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        let context = DataService.shared.fetchResultsController.managedObjectContext
        meal = Meal(context: context)
        meal?.name = lbName.text
        meal?.address = lbAddress.text
        meal?.image = selectedPhoto.image
        meal?.rating = Int32(rating.rating)
        do {
            try context.save()
            print("saved")
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
}
