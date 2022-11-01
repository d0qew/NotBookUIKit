//
//  TableViewController.swift
//  MyName
//
//  Created by Daniil Konashenko on 27.09.2022.
//
import UIKit

class SecondTableViewController: UITableViewController {
    
    
    
    // add new goals
    @IBAction func pushNewGoal(_ sender: Any) {
        let alertAddNewItem = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
        alertAddNewItem.addTextField{(textField) in
            textField.placeholder = "New daily task"
        }
        let alertActionFirst =  UIAlertAction(title: "Cancel", style: .default) { (alert) in
        }
        let alertActionSecond =  UIAlertAction(title: "Add", style: .cancel) { (alert) in
            // create new
            let newItemDaily = alertAddNewItem.textFields![0].text
            dailyTasks.addItem(nameItem: newItemDaily!)
            
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
        return dailyTasks.array.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let current = dailyTasks.array[indexPath.row]
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
            dailyTasks.removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if dailyTasks.changeStateGoal(at: indexPath.row){
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "check.png")
            tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .lightGray
            let current = dailyTasks.array[indexPath.row]
            let movedTask = current
            dailyTasks.array.remove(at: indexPath.row)
            dailyTasks.array.append(movedTask)
            
        }else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "uncheck")
            tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .black
            let current = dailyTasks.array[indexPath.row]
            let movedTask = current
            dailyTasks.array.remove(at: indexPath.row)
            dailyTasks.array.insert(movedTask, at: 0)
        }
        tableView.reloadSections( IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
}


