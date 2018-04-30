//
//  MyPowderDaysViewController.swift
//  Ski HQ
//
//  Created by Matt Mahoney on 4/23/18.
//  Copyright © 2018 Matt Mahoney. All rights reserved.
//

import UIKit

class MyPowderDaysViewController: UIViewController {
    @IBOutlet weak var skiEditButton: UIBarButtonItem!
    @IBOutlet weak var skiAddButton: UIBarButtonItem!
    @IBOutlet weak var skiTableView: UITableView!
    @IBOutlet weak var daysSkied: UILabel!
    
    var defaultsData = UserDefaults.standard
    var dateArray = [String]()
    var journalMountainArray = [String]()
    var skiPartnersArray = [String]()
    var temperatureArray = [String]()
    var weatherArray = [String]()
    var conditionsArray = [String]()
    var storiesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skiTableView.delegate = self
        skiTableView.dataSource = self
        
        dateArray = defaultsData.stringArray(forKey: "dateArray") ?? [String]()
        journalMountainArray = defaultsData.stringArray(forKey: "journalMountainArray") ?? [String]()
        skiPartnersArray = defaultsData.stringArray(forKey: "skiPartnersArray") ?? [String]()
        temperatureArray = defaultsData.stringArray(forKey: "temperatureArray") ?? [String]()
        weatherArray = defaultsData.stringArray(forKey: "weatherArray") ?? [String]()
        conditionsArray = defaultsData.stringArray(forKey: "conditionsArray") ?? [String]()
        storiesArray = defaultsData.stringArray(forKey: "storiesArray") ?? [String]()
        // Do any additional setup after loading the view.
    }
    func saveDefaultsData(){
        defaultsData.set(dateArray, forKey: "dateArray")
        defaultsData.set(journalMountainArray, forKey: "journalMountainArray")
        defaultsData.set(skiPartnersArray, forKey: "skiPartnersArray")
        defaultsData.set(temperatureArray, forKey: "temperatureArray")
        defaultsData.set(weatherArray, forKey: "weatherArray")
        defaultsData.set(conditionsArray, forKey: "conditionsArray")
        defaultsData.set(storiesArray, forKey: "storiesArray")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditJournalItem" {
            let destination = segue.destination as! MyPowderDaysDetailViewController
            let index = skiTableView.indexPathForSelectedRow!.row
            destination.dateItem = dateArray[index]
            destination.mountainItem = journalMountainArray[index]
            destination.partnersItem = skiPartnersArray[index]
            destination.temperatureItem = temperatureArray[index]
            destination.weatherItem = weatherArray[index]
            destination.conditionsItem = conditionsArray[index]
            destination.storiesItem = storiesArray[index]
        } else {
            if let selectedPath = skiTableView.indexPathForSelectedRow {
                skiTableView.deselectRow(at: selectedPath, animated: true)
            }
        }
    }
    
    
    
    
    @IBAction func unwindFromJournalDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! MyPowderDaysDetailViewController
        if let selectedIndexPath = skiTableView.indexPathForSelectedRow {
            dateArray[selectedIndexPath.row] = source.dateItem!
            journalMountainArray[selectedIndexPath.row] = source.dateItem!
            skiPartnersArray[selectedIndexPath.row] = source.partnersItem!
            temperatureArray[selectedIndexPath.row] = source.temperatureItem!
            weatherArray[selectedIndexPath.row] = source.weatherItem!
            conditionsArray[selectedIndexPath.row] = source.conditionsItem!
            storiesArray[selectedIndexPath.row] = source.storiesItem!
            skiTableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: dateArray.count, section: 0)
            dateArray.append(source.dateItem!)
            journalMountainArray.append(source.mountainItem!)
            skiPartnersArray.append(source.partnersItem!)
            temperatureArray.append(source.temperatureItem!)
            weatherArray.append(source.weatherItem!)
            conditionsArray.append(source.conditionsItem!)
            storiesArray.append(source.storiesItem!)
            skiTableView.insertRows(at: [newIndexPath], with: .bottom)
            skiTableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
        saveDefaultsData()
    }
    
    @IBAction func journalEditButtonPressed(_ sender: UIBarButtonItem) {
        if skiTableView.isEditing {
            skiTableView.setEditing(false, animated: true)
            skiAddButton.isEnabled = true
            skiEditButton.title = "Edit"
        } else {
            skiTableView.setEditing(true, animated: true)
            skiAddButton.isEnabled = false
            skiEditButton.title = "Done"
        }
    }
    
    
    @IBAction func powderDayBack(_ sender: UISwipeGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func daysSkiedPressed(_ sender: UIButton) {
        if dateArray.count == 0 {
            daysSkied.text = "That's embarassing! 0 days??"
        }
        else if dateArray.count == 1 {
            daysSkied.text = "You've only skied 1 day!"
        }
        else if dateArray.count > 10 {
            daysSkied.text = "Wow! You're shredding it!  \(dateArray.count) days under your belt!"
        }
        else {
            daysSkied.text = "You're getting there... you've been out \(dateArray.count) days with tons of time for more!"
        }
        
    }
    
    
}
extension MyPowderDaysViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        cell.textLabel?.text = dateArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dateArray.remove(at: indexPath.row)
            journalMountainArray.remove(at: indexPath.row)
            skiPartnersArray.remove(at: indexPath.row)
            temperatureArray.remove(at: indexPath.row)
            weatherArray.remove(at: indexPath.row)
            conditionsArray.remove(at: indexPath.row)
            storiesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        saveDefaultsData()
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let dateToMove = dateArray[sourceIndexPath.row]
        let journalMountainToMove = journalMountainArray[sourceIndexPath.row]
        let skiPartnersToMove = skiPartnersArray[sourceIndexPath.row]
        let temperatureToMove = temperatureArray[sourceIndexPath.row]
        let weatherToMove = weatherArray[sourceIndexPath.row]
        let conditionsToMove = conditionsArray[sourceIndexPath.row]
        let storiesToMove = storiesArray[sourceIndexPath.row]
        dateArray.remove(at: sourceIndexPath.row)
        journalMountainArray.remove(at: sourceIndexPath.row)
        skiPartnersArray.remove(at: sourceIndexPath.row)
        temperatureArray.remove(at: sourceIndexPath.row)
        weatherArray.remove(at: sourceIndexPath.row)
        conditionsArray.remove(at: sourceIndexPath.row)
        storiesArray.remove(at: sourceIndexPath.row)
        dateArray.insert(dateToMove, at: destinationIndexPath.row)
        journalMountainArray.insert(journalMountainToMove, at: destinationIndexPath.row)
        skiPartnersArray.insert(skiPartnersToMove, at: destinationIndexPath.row)
        temperatureArray.insert(temperatureToMove, at: destinationIndexPath.row)
        weatherArray.insert(weatherToMove, at: destinationIndexPath.row)
        conditionsArray.insert(conditionsToMove, at: destinationIndexPath.row)
        storiesArray.insert(storiesToMove, at: destinationIndexPath.row)
        saveDefaultsData()
    }
    
    
}
