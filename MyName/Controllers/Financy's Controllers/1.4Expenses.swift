//
//  ExpensesTableViewController.swift
//  MyName
//
//  Created by Daniil Konashenko on 01.10.2022.
//

import UIKit

class ExpensesTableViewController: UITableViewController {
    
    // алерт создания нового элемента
    @IBAction func pushNewExpenses(_ sender: Any) {
        let alertAddNewItem = UIAlertController(title: NSLocalizedString("textCreateItem", comment: ""), message: nil, preferredStyle: .alert)
        alertAddNewItem.addTextField{(textField) in
            textField.placeholder = NSLocalizedString("textNewExpenses", comment: "")
        }
        alertAddNewItem.addTextField{(money) in
            money.placeholder = NSLocalizedString("textPriceExpenses", comment: "")
        }
        let alertActionFirst =  UIAlertAction(title: NSLocalizedString("textCancel", comment: ""), style: .default) { (alert) in
        }
        let alertActionSecond =  UIAlertAction(title: NSLocalizedString("textAdd", comment: ""), style: .cancel) { (alert) in
            // create new
            let newItemName = alertAddNewItem.textFields![0].text
            let newItemPrice = alertAddNewItem.textFields![1].text
            expensesMoney.addItem(nameItem: newItemName!, price: Int(newItemPrice!) ?? 0)
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
        return expensesMoney.array.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expensesIdentifier", for: indexPath)
        
        let currentItem = expensesMoney.array[indexPath.row]
        cell.textLabel?.text = ((currentItem["nameItem"] as? String)!) + " " + "\((currentItem["price"]! as? Int)!) \u{20bd}"
        
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
            expensesMoney.removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
