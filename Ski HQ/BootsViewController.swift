//
//  BootsViewController.swift
//  Ski HQ
//
//  Created by Matt Mahoney on 4/23/18.
//  Copyright © 2018 Matt Mahoney. All rights reserved.
//

import UIKit

class BootsViewController: UIViewController {
    @IBOutlet weak var bootsTableView: UITableView!
    @IBOutlet weak var editBootsBarButton: UIBarButtonItem!
    @IBOutlet weak var addBootsBarButton: UIBarButtonItem!
    
    var defaultsData = UserDefaults.standard
    var bootsArray = [String]()
    var bootsSize = [String]()
    var bootsCost = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bootsTableView.delegate = self
        bootsTableView.dataSource = self
        
        bootsArray = defaultsData.stringArray(forKey: "bootsArray") ?? [String]()
        bootsSize = defaultsData.stringArray(forKey: "bootsSize") ?? [String]()
        bootsCost = defaultsData.stringArray(forKey: "bootsCost") ?? [String]()
    }
    
    func saveDefaultsData() {
        defaultsData.set(bootsArray, forKey: "bootsArray")
        defaultsData.set(bootsSize, forKey: "bootsSize")
        defaultsData.set(bootsCost, forKey: "bootsCost")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditBootItem" {
            let destination = segue.destination as! BootsDetailViewController
            let index = bootsTableView.indexPathForSelectedRow!.row
            destination.bootsItem = bootsArray[index] //brand item from detail vc
            destination.bootsSize = bootsSize[index]
            destination.bootsCost = bootsCost[index]
            
            
        } else {
            if let selectedPath = bootsTableView.indexPathForSelectedRow {
                bootsTableView.deselectRow(at: selectedPath, animated: true)
            }
        }
    }
    
    
    
    @IBAction func unwindFromBootDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! BootsDetailViewController
        if let selectedIndexPath = bootsTableView.indexPathForSelectedRow {
            bootsArray[selectedIndexPath.row] = source.bootsItem!
            bootsSize[selectedIndexPath.row] = source.bootsSize!
            bootsCost[selectedIndexPath.row] = source.bootsCost!
            bootsTableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row:bootsArray.count, section: 0)
            bootsArray.append(source.bootsItem!)
            bootsSize.append(source.bootsSize!)
            bootsCost.append(source.bootsCost!)
            bootsTableView.insertRows(at: [newIndexPath], with: .bottom)
            bootsTableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
        saveDefaultsData()
    }
    @IBAction func bootsEditPressed(_ sender: UIBarButtonItem) {
        if bootsTableView.isEditing {
            bootsTableView.setEditing(false, animated: true)
            addBootsBarButton.isEnabled = true
            editBootsBarButton.title = "Edit"
        } else {
            bootsTableView.setEditing(true, animated: true)
            addBootsBarButton.isEnabled = false
            editBootsBarButton.title = "Done"
        }
    }
    
    @IBAction func swipeBack(_ sender: UISwipeGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
// Do any additional setup after loading the view.






extension BootsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bootsArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BootCell", for: indexPath)
        cell.textLabel?.text = bootsArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bootsArray.remove(at: indexPath.row)
            bootsSize.remove(at: indexPath.row)
            bootsCost.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        saveDefaultsData()
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = bootsArray[sourceIndexPath.row]
        let sizeToMove = bootsSize[sourceIndexPath.row]
        let costToMove = bootsCost[sourceIndexPath.row]
        bootsArray.remove(at: sourceIndexPath.row)
        bootsSize.remove(at: sourceIndexPath.row)
        bootsCost.remove(at: sourceIndexPath.row)
        bootsArray.insert(itemToMove, at: destinationIndexPath.row)
        bootsSize.insert(sizeToMove, at: destinationIndexPath.row)
        bootsCost.insert(costToMove, at: destinationIndexPath.row)
        saveDefaultsData()
    }
    
}

    

