//
//  LogicFinancy.swift
//  MyName
//
//  Created by Daniil Konashenko on 23.10.2022.
//

import Foundation

// MARK: - PROTOCOL FOR GOALS

protocol TasksProtocol {
    var key: String {get set}
    var array: [[String: Any]] {get set}
    
    func addItem(nameItem: String, isCompleted: Bool)
    func removeItem(at index: Int)
    func changeStateGoal(at item:Int) -> Bool
    
}
// MARK: - CLASS FOR GOALS

class TasksClass: TasksProtocol {
    
    var key: String
    var array: [[String : Any]]{
        get{
            if let array = UserDefaults.standard.array(forKey: key) as? [[String : Any]] {
                return array
            }else {
                return []
            }
        }
        set{
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    func addItem(nameItem: String, isCompleted: Bool = false ) {
        array.insert(["nameGoals": nameItem, "isCompleted" : isCompleted], at: 0)
    }
    
    func removeItem(at index: Int) {
        array.remove(at: index)
    }
    func changeStateGoal(at item:Int) -> Bool{
        array[item]["isCompleted"] = !(array[item]["isCompleted"] as! Bool)
        return array[item]["isCompleted"] as! Bool
    }
    
    init(key: String) {
        self.key = key
    }
}
// MARK: - TABLE VIEW 2.1
var dailyTasks = TasksClass(key: "dailyTasksDataKey")


// MARK: - TABLE VIEW 2.2
var monthlyTasks = TasksClass(key: "mounthlyTasksDataKey")

