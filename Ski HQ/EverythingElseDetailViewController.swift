//
//  EverythingElseDetailViewController.swift
//  Ski HQ
//
//  Created by Matt Mahoney on 4/29/18.
//  Copyright © 2018 Matt Mahoney. All rights reserved.
//

import UIKit

class EverythingElseDetailViewController: UIViewController {
    @IBOutlet weak var gearNameField: UITextField!
    @IBOutlet weak var gearSizeField: UITextField!
    @IBOutlet weak var gearCostField: UITextField!
    @IBOutlet weak var gearSaveButton: UIBarButtonItem!
    
    
    var gearItem: String?
    var gearSizeItem: String?
    var gearCostItem: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let gearItem = gearItem {
            gearNameField.text = gearItem
        }
        if let gearSizeItem = gearSizeItem {
            gearSizeField.text = gearSizeItem
        }
        if let gearCostItem = gearCostItem {
            gearCostField.text = gearCostItem
        }
        gearNameField.becomeFirstResponder()
        }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        gearItem = gearNameField.text
        gearSizeItem = gearSizeField.text
        gearCostItem = gearCostField.text
    }
    
    func gearEnableDisableSaveButton () {
        if let gearFieldCount = gearNameField.text?.count, gearFieldCount > 0 {
            gearSaveButton.isEnabled = true
        } else {
            gearSaveButton.isEnabled = false
        }
    }
    @IBAction func gearEditFieldChanged(_ sender: UITextField) {
        gearEnableDisableSaveButton()
    }
    
    @IBAction func gearCancelPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil) //without this, cancel button breaks
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
