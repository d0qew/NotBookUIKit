//
//  TableTableViewController.swift
//  MyName
//
//  Created by Daniil Konashenko on 26.09.2022.
//

import UIKit

class FirstTableViewController: UITableViewController {
    
    @IBAction func pushAddAction(_ sender: Any) {
        
        
        let alertAddNewItem = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
        alertAddNewItem.addTextField{(textField) in
            textField.placeholder = "New Product"
        }
        alertAddNewItem.addTextField{(money) in
            money.placeholder = "Price Product's"
        }
        let alertActionFirst =  UIAlertAction(title: "Cancel", style: .default) { (alert) in
        }
        let alertActionSecond =  UIAlertAction(title: "Add", style: .cancel) { (alert) in
            // create new
            let newItemName = alertAddNewItem.textFields![0].text
            let newItemPrice = alertAddNewItem.textFields![1].text
            
            savedMoneyProduct.addItem(nameItem: newItemName!, price: Int(newItemPrice!) ?? 0)
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
        return savedMoneyProduct.array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let currentItem = savedMoneyProduct.array[indexPath.row]
        cell.textLabel?.text = ((currentItem["nameItem"] as? String)!) + " " + "\((currentItem["price"]! as? Int)!) \u{20bd}"
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    //delete...
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            savedMoneyProduct.removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
