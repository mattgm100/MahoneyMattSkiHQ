//
//  MyPowderDaysDetailViewController.swift
//  Ski HQ
//
//  Created by Matt Mahoney on 4/30/18.
//  Copyright © 2018 Matt Mahoney. All rights reserved.
//

import UIKit

class MyPowderDaysDetailViewController: UIViewController {
    @IBOutlet weak var journalSaveButton: UIBarButtonItem!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var journalMountainField: UITextField!
    @IBOutlet weak var skiPartnersField: UITextField!
    @IBOutlet weak var temperatureField: UITextField!
    @IBOutlet weak var weatherField: UITextField!
    @IBOutlet weak var conditionsField: UITextField!
    @IBOutlet weak var storiesField: UITextView!
    
    var dateItem: String?
    var mountainItem: String?
    var partnersItem: String?
    var temperatureItem: String?
    var weatherItem: String?
    var conditionsItem: String?
    var storiesItem: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dateItem = dateItem {
            dateField.text = dateItem
        }
        if let mountainItem = mountainItem {
            journalMountainField.text = mountainItem
        }
        if let partnersItem = partnersItem {
            skiPartnersField.text = partnersItem
        }
        if let temperatureItem = temperatureItem {
            temperatureField.text = temperatureItem
        }
        if let weatherItem = weatherItem {
            weatherField.text = weatherItem
        }
        if let conditionsItem = conditionsItem {
            conditionsField.text = conditionsItem
        }
        if let storiesItem = storiesItem {
            storiesField.text = storiesItem
        }
        
        dateField.becomeFirstResponder()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        dateItem = dateField.text!
        mountainItem = journalMountainField.text!
        partnersItem = skiPartnersField.text!
        temperatureItem = temperatureField.text!
        weatherItem = weatherField.text!
        conditionsItem = conditionsField.text!
        storiesItem = storiesField.text!
    }
    
    func journalEnableDisableSaveButton() {
        if let dateFieldCount = dateField.text?.count, dateFieldCount > 0 {
            journalSaveButton.isEnabled = true
        } else {
            journalSaveButton.isEnabled = false
        }
    }
    @IBAction func dateChanged(_ sender: UITextField) {
        journalEnableDisableSaveButton()
    }
    
    @IBAction func journalCancelPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
