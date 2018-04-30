//
//  SkisViewController.swift
//  Ski HQ
//
//  Created by Matt Mahoney on 4/23/18.
//  Copyright © 2018 Matt Mahoney. All rights reserved.
//

import UIKit

class SkisViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var skisOwned: UILabel!
    
    
    var defaultsData = UserDefaults.standard
    var skisArray = [String]()
    var skisSizeArray = [String]()
    var costArray = [String]()
    var styleArray = [String]()
    var skiCount = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        skisArray = defaultsData.stringArray(forKey: "skisArray") ?? [String]()
        skisSizeArray = defaultsData.stringArray(forKey: "skisSizeArray") ?? [String]()
        costArray = defaultsData.stringArray(forKey: "costArray") ?? [String]()
        styleArray = defaultsData.stringArray(forKey: "styleArray") ?? [String]()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func saveDefaultsData() {
        defaultsData.set(skisArray, forKey: "skisArray")
        defaultsData.set(skisSizeArray, forKey: "skisSizeArray")
        defaultsData.set(costArray, forKey: "costArray")
        defaultsData.set(styleArray, forKey: "styleArray")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditSkiItem" {
            let destination = segue.destination as! SkiDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            destination.brandItem = skisArray[index] //brand item from detail vc
            destination.sizeItem = skisSizeArray[index]
            destination.costItem = costArray[index]
            destination.styleItem = styleArray[index]
           
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: true)
            }
        }
    }
    //this function is what comes away from the skiDetailVC and saves the information in the table
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! SkiDetailViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            skisArray[selectedIndexPath.row] = source.brandItem!
            skisSizeArray[selectedIndexPath.row] = source.sizeItem!
            costArray[selectedIndexPath.row] = source.costItem!
            styleArray[selectedIndexPath.row] = source.styleItem!
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row:skisArray.count, section: 0)
            skisArray.append(source.brandItem!)
            skisSizeArray.append(source.sizeItem!)
            costArray.append(source.costItem!)
            styleArray.append(source.styleItem!)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
            
        }
        saveDefaultsData()
    }
    
    @IBAction func editBarButtonPressed(_ sender: Any) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            addBarButton.isEnabled = true
            editBarButton.title = "Edit"
        } else {
            tableView.setEditing(true, animated: true)
            addBarButton.isEnabled = false
            editBarButton.title = "Done"
        }
    }
    @IBAction func skisSwipeHome(_ sender: UISwipeGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func numberOfSkisPressed(_ sender: UIButton) {
        if skisArray.count == 1 {
            skisOwned.text = "You own \(skisArray.count) pair of skis!"
        } else {
            skisOwned.text = "You own \(skisArray.count) pairs of skis!"
            
        }
        
        
    }
}
extension SkisViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skisArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = skisArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           skisArray.remove(at: indexPath.row)
           skisSizeArray.remove(at: indexPath.row)
           costArray.remove(at: indexPath.row)
           styleArray.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
        }
        saveDefaultsData()
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = skisArray[sourceIndexPath.row]
        let sizeToMove = skisSizeArray[sourceIndexPath.row]
        let costToMove = costArray[sourceIndexPath.row]
        let styleToMove = styleArray[sourceIndexPath.row]
        skisArray.remove(at: sourceIndexPath.row)
        skisSizeArray.remove(at: sourceIndexPath.row)
        costArray.remove(at: sourceIndexPath.row)
        styleArray.remove(at: sourceIndexPath.row)
        skisArray.insert(itemToMove, at: destinationIndexPath.row)
        skisSizeArray.insert(sizeToMove, at: destinationIndexPath.row)
        costArray.insert(costToMove, at: destinationIndexPath.row)
        styleArray.insert(styleToMove, at: destinationIndexPath.row)
        saveDefaultsData()
    }
    
    
    
}
