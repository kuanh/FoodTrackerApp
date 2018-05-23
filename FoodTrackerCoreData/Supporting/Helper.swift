//
//  Helper.swift
//  FoodTrackerCoreData
//
//  Created by KuAnh on 23/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit

class Helper {
    func showAlert(title: String, message: String, fromController controller: UIViewController, preferredStyle: UIAlertControllerStyle) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) -> Void in}))
        controller.present(alert, animated: true, completion: nil)
    }
}
