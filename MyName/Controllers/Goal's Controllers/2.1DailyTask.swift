//
//  TableViewController.swift
//  MyName
//
//  Created by Daniil Konashenko on 27.09.2022.
//
import UIKit

class SecondTableViewController: UITableViewController {
    
    
    
    // создание новой задачи
    @IBAction func pushNewGoal(_ sender: Any) {
        let alertAddNewItem = UIAlertController(title: NSLocalizedString("textCreateItem", comment: ""), message: nil, preferredStyle: .alert)
        alertAddNewItem.addTextField{(textField) in
            textField.placeholder =  NSLocalizedString("textNewDailyTask", comment: "")
        }
        let alertActionFirst =  UIAlertAction(title: NSLocalizedString("textCancel", comment: ""), style: .default) { (alert) in
        }
        let alertActionSecond =  UIAlertAction(title: NSLocalizedString("textAdd", comment: ""), style: .cancel) { (alert) in
            // создание ячейки в массивве
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
        // выводит только 1 секцию
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // выводит столько ячеек, сколько элементов в массиве dailyTasks
        return dailyTasks.array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // привязка ячейки
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let current = dailyTasks.array[indexPath.row]
        cell.textLabel?.text = current["nameGoals"] as? String
        // отметка выставляется рукководствуясь значением isCompleted
        if (current["isCompleted"] as? Bool) == true {
            cell.imageView?.image = #imageLiteral(resourceName: "check.png")
            cell.textLabel?.textColor = .lightGray
        }else {
            cell.imageView?.image = #imageLiteral(resourceName: "uncheck")
            cell.textLabel?.textColor = .black
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // разрешение редактирование таблицы
        return true
    }
    
    //delete...
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dailyTasks.removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    // реакция на нажатие по ячейке
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //снять выделение
        tableView.deselectRow(at: indexPath, animated: true)
        // помеять значение isCompleted на противоположное и отправить ячеку вверх или вниз(смотря какое згначение)
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
        //перезагрузить секцию
        tableView.reloadSections( IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
}


