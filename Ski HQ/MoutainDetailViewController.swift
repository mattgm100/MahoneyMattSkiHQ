//
//  MoutainDetailViewController.swift
//  Ski HQ
//
//  Created by Matt Mahoney on 4/29/18.
//  Copyright © 2018 Matt Mahoney. All rights reserved.
//

import UIKit

class MoutainDetailViewController: UIViewController {
    @IBOutlet weak var mountainField: UITextField!
    @IBOutlet weak var mountainInfoField: UITextView!
    @IBOutlet weak var mountainSaveBarButton: UIBarButtonItem!
    
    var mountainItem: String?
    var mountainInfoItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let mountainItem = mountainItem {
            mountainField.text = mountainItem
        }
        if let mountainInfoItem = mountainInfoItem {
            mountainInfoField.text =  mountainInfoItem
        }
        enableDisableSaveButton()
        mountainField.becomeFirstResponder()


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindMountainSave" {
            mountainItem = mountainField.text
            mountainInfoItem = mountainInfoField.text
        }
    }
    
    func enableDisableSaveButton () {
        if let mountainFieldCount = mountainField.text?.count, mountainFieldCount > 0 {
            mountainSaveBarButton.isEnabled = true
        } else {
            mountainSaveBarButton.isEnabled = false
        }
    }

    
    @IBAction func mountainFieldChanged(_ sender: UITextField) {
        enableDisableSaveButton()

    }
    
    @IBAction func mountainCancelPressed(_ sender: Any) {
        let isMountainPresentingInAddMode = presentingViewController is UINavigationController
        if isMountainPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
        
    }
    
}
