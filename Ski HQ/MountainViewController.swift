//
//  MountainViewController.swift
//  Ski HQ
//
//  Created by Matt Mahoney on 4/29/18.
//  Copyright © 2018 Matt Mahoney. All rights reserved.
//

import UIKit

class MountainViewController: UIViewController {
    @IBOutlet weak var mountainTableView: UITableView!
    @IBOutlet weak var editMountainBarButton: UIBarButtonItem!
    @IBOutlet weak var addMountainBarButton: UIBarButtonItem!
    @IBOutlet weak var mountainCount: UILabel!
    
    //var mountainArray = ["Cannon", "Sugarloaf"]
    //var mountainNotesArray = ["Great Place!", "I would love to go again!"]
    
    var defaultsData = UserDefaults.standard
    var mountainArray = [String]()
    var mountainNotesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mountainTableView.delegate = self
        mountainTableView.dataSource = self
        
        mountainArray = defaultsData.stringArray(forKey: "mountainArray") ?? [String]()
        mountainNotesArray = defaultsData.stringArray(forKey: "mountainNotesArray") ?? [String]()

    }
    
    func saveDefaultsData() {
        defaultsData.set(mountainArray, forKey: "mountainArray")
        defaultsData.set(mountainNotesArray, forKey: "mountainNotesArray")
        
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditMountainItem" {
            let destination = segue.destination as! MoutainDetailViewController
            let index = mountainTableView.indexPathForSelectedRow!.row
            destination.mountainItem = mountainArray[index]
            destination.mountainInfoItem = mountainNotesArray[index]
        } else {
            if let selectedPath = mountainTableView.indexPathForSelectedRow{
                mountainTableView.deselectRow(at: selectedPath, animated: true)
            }
        }
    }
    @IBAction func unwindFromMountainDetailViewController (segue: UIStoryboardSegue) {
        let mountainSourceViewController = segue.source as! MoutainDetailViewController
        if let mountainIndexPath = mountainTableView.indexPathForSelectedRow {
            mountainArray[mountainIndexPath.row] = mountainSourceViewController.mountainItem!
            mountainNotesArray[mountainIndexPath.row] = mountainSourceViewController.mountainInfoItem!
            mountainTableView.reloadRows(at: [mountainIndexPath], with: .automatic)
        } else{
            let newIndexPath = IndexPath(row: mountainArray.count, section: 0)
            mountainArray.append(mountainSourceViewController.mountainItem!)
            mountainNotesArray.append(mountainSourceViewController.mountainInfoItem!)
            mountainTableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        saveDefaultsData()
        
    }
    
    @IBAction func editMountainBarButtonPressed(_ sender: Any) {
        if mountainTableView.isEditing {
            mountainTableView.setEditing(false, animated: true)
            addMountainBarButton.isEnabled = true
            editMountainBarButton.title = "Edit"
        } else {
            mountainTableView.setEditing(true, animated: true)
            addMountainBarButton.isEnabled = false
            editMountainBarButton.title = "Done"
        }
    }
    
    @IBAction func mountainSwipeHome(_ sender: UISwipeGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func countMyMountains(_ sender: UIButton) {
        if mountainArray.count == 0 {
            mountainCount.text = "Get off the couch! You've never visited a mountain!"
        }
        else if mountainArray.count < 5 {
            mountainCount.text = "Afraid to branch out? You've only visited \(mountainArray.count) mountains!"
        }
        else if mountainArray.count < 15 {
            mountainCount.text = "You're exploring all over the place! \(mountainArray.count) mountains!! Keep going!"
        }
        else {
            mountainCount.text = "You're a true backcountry pioneer! \(mountainArray.count) mountains and counting!!"
        }
    }
}

extension MountainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mountainArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mountainCell = tableView.dequeueReusableCell(withIdentifier: "MountainCell", for: indexPath)
        mountainCell.textLabel?.text = mountainArray[indexPath.row]
        mountainCell.detailTextLabel?.text = mountainNotesArray[indexPath.row]
        return mountainCell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            mountainArray.remove(at: indexPath.row)
            mountainNotesArray.remove(at: indexPath.row)
            mountainTableView.deleteRows(at: [indexPath], with: .fade)
            saveDefaultsData()
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = mountainArray[sourceIndexPath.row]
        let noteTomove = mountainNotesArray[sourceIndexPath.row]
        mountainArray.remove(at: sourceIndexPath.row)
        mountainNotesArray.remove(at: sourceIndexPath.row)
        mountainArray.insert(itemToMove, at: destinationIndexPath.row)
        mountainNotesArray.insert(noteTomove, at: destinationIndexPath.row)
        saveDefaultsData()
    }
}
