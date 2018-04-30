//
//  EverythingElseViewController.swift
//  Ski HQ
//
//  Created by Matt Mahoney on 4/23/18.
//  Copyright © 2018 Matt Mahoney. All rights reserved.
//

import UIKit

class EverythingElseViewController: UIViewController {

    @IBOutlet weak var gearTableView: UITableView!
    @IBOutlet weak var gearEditButton: UIBarButtonItem!
    @IBOutlet weak var addGearButton: UIBarButtonItem!
    
    
    var defaultsData = UserDefaults.standard
    var gearArray = [String]()
    var gearSize = [String]()
    var gearCost = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gearTableView.delegate = self
        gearTableView.dataSource = self
        
        gearArray = defaultsData.stringArray(forKey: "gearArray") ?? [String]()
        gearSize = defaultsData.stringArray(forKey: "gearSize") ?? [String]()
        gearCost = defaultsData.stringArray(forKey: "gearCost") ?? [String]()
        

    }
    
    func saveDefaultsData() {
        defaultsData.set(gearArray, forKey: "gearArray")
        defaultsData.set(gearSize, forKey: "gearSize")
        defaultsData.set(gearCost, forKey: "gearCost")
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditGear" {
            let destination = segue.destination as! EverythingElseDetailViewController
            let index = gearTableView.indexPathForSelectedRow?.row
            destination.gearItem = gearArray[index!]
            destination.gearSizeItem = gearSize[index!]
            destination.gearCostItem = gearCost[index!]
        } else {
            if let selectedPath = gearTableView.indexPathForSelectedRow {
                gearTableView.deselectRow(at: selectedPath, animated: true)
            }
        }
    }
    
    @IBAction func goBack(_ sender: UISwipeGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func unwindFromGearDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! EverythingElseDetailViewController
        if let selectedIndexPath = gearTableView.indexPathForSelectedRow {
            gearArray[selectedIndexPath.row] = source.gearItem!
            gearSize[selectedIndexPath.row] = source.gearSizeItem!
            gearCost[selectedIndexPath.row] = source.gearCostItem!
            gearTableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row:gearArray.count, section: 0)
            gearArray.append(source.gearItem!)
            gearSize.append(source.gearSizeItem!)
           gearCost.append(source.gearCostItem!)
            gearTableView.insertRows(at: [newIndexPath], with: .bottom)
            gearTableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
        saveDefaultsData()

    }
    @IBAction func editGearPressed(_ sender: UIBarButtonItem) {
        if gearTableView.isEditing {
            gearTableView.setEditing(false, animated: true)
            addGearButton.isEnabled = true
            gearEditButton.title = "Edit"
        } else {
            gearTableView.setEditing(true, animated: true)
            addGearButton.isEnabled = false
            gearEditButton.title = "Done"
        }
    }
    

}

extension EverythingElseViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gearArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gearTableView.dequeueReusableCell(withIdentifier: "GearCell", for: indexPath)
        cell.textLabel?.text = gearArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            gearArray.remove(at: indexPath.row)
            gearSize.remove(at: indexPath.row)
            gearCost.remove(at: indexPath.row)
            gearTableView.deleteRows(at: [indexPath], with: .fade)
        }
        saveDefaultsData()
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let gearToMove = gearArray[sourceIndexPath.row]
        let sizeGearToMove = gearSize[sourceIndexPath.row]
        let gearCostToMove = gearCost[sourceIndexPath.row]
        gearArray.remove(at: sourceIndexPath.row)
        gearSize.remove(at: sourceIndexPath.row)
        gearCost.remove(at: sourceIndexPath.row)
        gearArray.insert(gearToMove, at: destinationIndexPath.row)
        gearSize.insert(sizeGearToMove, at: destinationIndexPath.row)
        gearCost.insert(gearCostToMove, at: destinationIndexPath.row)
        saveDefaultsData()
    }


    
}
