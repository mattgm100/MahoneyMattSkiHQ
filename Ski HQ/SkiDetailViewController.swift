//
//  SkiDetailViewController.swift
//  Ski HQ
//
//  Created by Matt Mahoney on 4/24/18.
//  Copyright © 2018 Matt Mahoney. All rights reserved.
//

import UIKit

class SkiDetailViewController: UIViewController {
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var skiSizeField: UITextField!
    @IBOutlet weak var costField: UITextField!
    @IBOutlet weak var styleField: UITextField!
    
    
    var brandItem: String?
    var sizeItem: String?
    var costItem: String?
    var styleItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let brandItem = brandItem {
            brandField.text = brandItem
        }
        if let sizeItem = sizeItem {
            skiSizeField.text = sizeItem
        }
        if let costItem = costItem {
            costField.text = costItem
        }
        if let styleItem = styleItem {
            styleField.text = styleItem
        }
        
        brandField.becomeFirstResponder()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        brandItem = brandField.text!
        sizeItem = skiSizeField.text!
        costItem = costField.text!
        styleItem = styleField.text!
    }

    func skiEnableDisableSaveButton () {
        if let brandFieldCount = brandField.text?.count, brandFieldCount > 0 {
            saveBarButton.isEnabled = true
            
        } else {
            saveBarButton.isEnabled = false
        }
    }
    
    @IBAction func brandFieldChanged(_ sender: UITextField) {
        skiEnableDisableSaveButton()

    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil) //without this, cancel button breaks
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
