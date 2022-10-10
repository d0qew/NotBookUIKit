//
//  ExpensesTableViewController.swift
//  MyName
//
//  Created by Daniil Konashenko on 01.10.2022.
//

import UIKit

class ExpensesTableViewController: UITableViewController {

    @IBAction func pushNewExpenses(_ sender: Any) {
        let alertController = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
        alertController.addTextField{(textField) in
            textField.placeholder = "New Expenses"
        }
        alertController.addTextField{(money) in
                money.placeholder = "Price Expenses"
        }
        let alertActionFirst =  UIAlertAction(title: "Cancel", style: .default) { (alert) in
        }
        let alertActionSecond =  UIAlertAction(title: "Add", style: .cancel) { (alert) in
            // create new
        let newItemNameExpenses = alertController.textFields![0].text
        let newItemPriceExpenses = alertController.textFields![1].text
        addNewExpenses(nameItem: newItemNameExpenses!, price: Int(newItemPriceExpenses!) ?? 0)
        self.tableView.reloadData()
          }
        alertController.addAction(alertActionFirst)
        alertController.addAction(alertActionSecond)
        present(alertController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return expensesMoney.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expensesIdentifier", for: indexPath)

        let currentItem = expensesMoney[indexPath.row]
        cell.textLabel?.text = ((currentItem["nameExpenses"] as? String)!) + " " + "\((currentItem["price"]! as? Int)!) \u{20bd}"
        
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
            removeExpenses(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
