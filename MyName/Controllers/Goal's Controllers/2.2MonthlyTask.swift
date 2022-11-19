//
//  SecondMounthTableViewController.swift
//  MyName
//
//  Created by Daniil Konashenko on 27.09.2022.
//

import UIKit

class SecondMounthTableViewController: UITableViewController {
    
    @IBAction func pushNewGoal(_ sender: Any) {
        let alertAddNewItem = UIAlertController(title: NSLocalizedString("textCreateItem", comment: ""), message: nil, preferredStyle: .alert)
        alertAddNewItem.addTextField{(textField) in
            textField.placeholder = NSLocalizedString("textNewMonthlyTask", comment: "")
        }
        let alertActionFirst =  UIAlertAction(title: NSLocalizedString("textCancel", comment: ""), style: .default) { (alert) in
        }
        let alertActionSecond =  UIAlertAction(title: NSLocalizedString("textAdd", comment: ""), style: .cancel) { (alert) in
            // create new
            let newItemMounthly = alertAddNewItem.textFields![0].text
            
            monthlyTasks.addItem(nameItem: newItemMounthly!)
            
            self.tableView.reloadData()
        }
        alertAddNewItem.addAction(alertActionFirst)
        alertAddNewItem.addAction(alertActionSecond)
        present(alertAddNewItem, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return monthlyTasks.array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath)
        let current = monthlyTasks.array[indexPath.row]
        cell.textLabel?.text = current["nameGoals"] as? String
        
        if (current["isCompleted"] as? Bool) == true {
            cell.imageView?.image = #imageLiteral(resourceName: "check.png")
            cell.textLabel?.textColor = .lightGray

        }else {
            cell.imageView?.image = #imageLiteral(resourceName: "uncheck")
            cell.textLabel?.textColor = .black
            
        }
        
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            monthlyTasks.removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if monthlyTasks.changeStateGoal(at: indexPath.row){
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "check.png")
            tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .lightGray
            let current = monthlyTasks.array[indexPath.row]
            let movedTask = current
            monthlyTasks.array.remove(at: indexPath.row)
            monthlyTasks.array.append(movedTask)
            
        }else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "uncheck")
            tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .black
            let current = monthlyTasks.array[indexPath.row]
            let movedTask = current
            monthlyTasks.array.remove(at: indexPath.row)
            monthlyTasks.array.insert(movedTask, at: 0)
            
        }
        tableView.reloadSections( IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
}
