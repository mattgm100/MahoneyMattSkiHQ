//
//  BootsDetailViewController.swift
//  Ski HQ
//
//  Created by Matt Mahoney on 4/29/18.
//  Copyright © 2018 Matt Mahoney. All rights reserved.
//

import UIKit

class BootsDetailViewController: UIViewController {
    @IBOutlet weak var bootsBrandField: UITextField!
    @IBOutlet weak var bootsSizeField: UITextField!
    @IBOutlet weak var bootsCostField: UITextField!
    @IBOutlet weak var bootsSaveBarButton: UIBarButtonItem!
    
    var bootsItem: String?
    var bootsSize: String?
    var bootsCost: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let bootsItem = bootsItem {
            bootsBrandField.text = bootsItem
        }
        
        if let bootsSize = bootsSize {
            bootsSizeField.text = bootsSize
        }
        if let bootsCost = bootsCost {
            bootsCostField.text = bootsCost
        }
        
        bootsBrandField.becomeFirstResponder()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        bootsItem = bootsBrandField.text!
        bootsSize = bootsSizeField.text!
        bootsCost = bootsCostField.text!
    }
    
    func bootsEnableDisableSaveButton () {
        if let bootsFieldCount = bootsBrandField.text?.count, bootsFieldCount > 0 {
            bootsSaveBarButton.isEnabled = true
        } else {
            bootsSaveBarButton.isEnabled = false
        }
    }
    @IBAction func bootsCancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func bootsBrandFieldAction(_ sender: UITextField) {
        bootsEnableDisableSaveButton()
    }
    


}
