//
//  Model.swift
//  MyName
//
//  Created by Daniil Konashenko on 26.09.2022.
//

import Foundation

// MARK: - PROTOCOL FOR FINANCY

protocol FinancyProtocol {
    var key: String {get set}
    var array: [[String: Any]] {get set}
    
    func addItem(nameItem: String, price: Int)
    func removeItem(at index: Int)
    
}

// MARK: - CLASS FOR FINANCY

class FinancyClass: FinancyProtocol {
    
    var key: String
    var array: [[String : Any]]{
        set
        {
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
        get
        {
            if let array = UserDefaults.standard.array(forKey: key) as? [[String : Any]] {
                return array
            }else {
                return []
            }
        }
    }
    
    func addItem(nameItem: String, price: Int = 0 ) {
        array.append(["nameItem": nameItem, "price" : price])
    }
    
    func removeItem(at index: Int) {
        array.remove(at: index)
    }
    
    init(key: String) {
        self.key = key
    }
    
}


// MARK: - TABLE VIEW 1.1
var savedMoneyProduct = FinancyClass(key: "savedProductDataKey")


// MARK: - TABLE VIEW 1.2
var goalMoney = FinancyClass(key: "goalForMoneyDataKey")


// MARK: - TABLE VIEW 1.3
var incomeMoney = FinancyClass(key: "newIncomeDataKey")


// MARK: - TABLE VIEW 1.4
var expensesMoney = FinancyClass(key: "newExpensesDataKey")


