//
//  Model.swift
//  MyName
//
//  Created by Daniil Konashenko on 26.09.2022.
//
import UIKit
import Foundation

// MARK: - TABLE VIEW 1.1


var savedMoneyProduct:[[String: Any]]
{
    set
    {
        UserDefaults.standard.set(newValue, forKey: "productDataKey")
        UserDefaults.standard.synchronize()
    }
    get
    {
        if let array = UserDefaults.standard.array(forKey: "productDataKey") as? [[String : Any]] {
            return array
        }else {
            return []
        }
    }
}
// add item to array
func addProduct(nameItem: String, price: Int = 0 ) {
    savedMoneyProduct.append(["nameProduct": nameItem, "price" : price])
}

// remove item from array
func removeProduct(at index: Int) {
    savedMoneyProduct.remove(at: index)
}

// MARK: - TABLE VIEW 1.2


var goalMoney:[[String: Any]] {
    set
    {
        UserDefaults.standard.set(newValue, forKey: "goalMoneyDataKey")
        UserDefaults.standard.synchronize()
    }
    get
    {
        if let array = UserDefaults.standard.array(forKey: "goalMoneyDataKey") as? [[String : Any]] {
            return array
        }else
        {
            return []
        }
    }
}
// add item to array
func addGoalMoney(nameItem: String, price: Int = 0 )
{
    goalMoney.append(["nameProduct": nameItem, "price" : price])
}

// remove item from array
func removeGoalMoney(at index: Int)
{
    goalMoney.remove(at: index)
}
// MARK: - TABLE VIEW 1.3


var incomeMoney:[[String: Any]] {
    set
    {
        UserDefaults.standard.set(newValue, forKey: "newIncome")
        UserDefaults.standard.synchronize()
    }
    get
    {
        if let array = UserDefaults.standard.array(forKey: "newIncome") as? [[String:Any]] {
            return array
        }
        else
        {
            return[]
        }
    }
}

//add new item
func addNewIncome(nameItem:String, price: Int = 0)
{
    incomeMoney.append(["nameIncome": nameItem, "price" : price])
}
//remove item from array
func removeIncome(at index: Int)
{
    incomeMoney.remove(at: index)
}


// MARK: - TABLE VIEW 1.4


var expensesMoney:[[String: Any]] {
    set
    {
        UserDefaults.standard.set(newValue, forKey: "newExpenses")
        UserDefaults.standard.synchronize()
    }
    get
    {
        if let array = UserDefaults.standard.array(forKey: "newExpenses") as? [[String:Any]] {
            return array
        }
        else
        {
            return[]
        }
    }
}

//add new item
func addNewExpenses(nameItem:String, price: Int = 0)
{
    expensesMoney.append(["nameExpenses": nameItem, "price" : price])
}
//remove item from array
func removeExpenses(at index: Int)
{
    expensesMoney.remove(at: index)
}


// MARK: - TABLE VIEW 2.1


var dailyGoals: [[String : Any]]
{
    set
    {
        UserDefaults.standard.set(newValue, forKey: "dailyGoalsDataKey")
        UserDefaults.standard.synchronize()
    }
    get
    {
        if let array = UserDefaults.standard.array(forKey: "dailyGoalsDataKey") as? [[String : Any]] {
            return array
        }else
        {
            return []
        }
    }
}

// add item to array
func addNewGoals(nameGoalsItem: String, isCompleted: Bool = false)
{
    dailyGoals.append(["nameGoals": nameGoalsItem, "isCompleted": isCompleted])
    
}

// remove item from array
func removeDailyGoals(at index: Int)
{
    dailyGoals.remove(at: index)
}

// change checkmarks
func changeStateGoal(at item:Int) -> Bool
{
    dailyGoals[item]["isCompleted"] = !(dailyGoals[item]["isCompleted"] as! Bool)
    return dailyGoals[item]["isCompleted"] as! Bool
}

// MARK: - TABLE VIEW 2.2


var mounthlyGoals: [[String : Any]]
{
    set
    {
        UserDefaults.standard.set(newValue, forKey: "mounthlyGoalsDataKey")
        UserDefaults.standard.synchronize()
    }
    get
    {
        if let array = UserDefaults.standard.array(forKey: "mounthlyGoalsDataKey") as? [[String : Any]] {
            return array
        }else
        {
            return []
        }
    }
}

// add item to array
func addNewMounthlyGoals(nameGoalsItem: String, isCompleted: Bool = false)
{
    mounthlyGoals.append(["nameGoals": nameGoalsItem, "isCompleted": isCompleted])
    
}

// remove item from array
func removeMounthlyGoals(at index: Int)
{
    mounthlyGoals.remove(at: index)
}

// change checkmarks
func changeStateMounthGoal(at item:Int) -> Bool
{
    mounthlyGoals[item]["isCompleted"] = !(mounthlyGoals[item]["isCompleted"] as! Bool)
    return mounthlyGoals[item]["isCompleted"] as! Bool
}

// MARK: - TABLE VIEW 3


func ultimatelyResultMoney(_ arr:[[String: Any]]) -> String
{
    var result: Int = 0
    if !arr.isEmpty {
        for i in 0...arr.count-1 {
            result += (arr[i]["price"] as? Int)!
        }
        return String(result)
}else
{
    return String(result)
}
}


func resultGoals(_ arr:[[String : Any]]) -> String
{
    var result: Int = 0
    if !arr.isEmpty {
        for i in 0...arr.count-1{
            if (arr[i]["isCompleted"] as? Bool)!{
                result += 1
            }
        }
        return String(result) + "/\(arr.count)"
    }else
    {
        return String(result) + "/0"
    }
}

func resultBudget() -> String
{
    let resultIncome = Int(ultimatelyResultMoney(incomeMoney))!
    let resultExpenses = Int(ultimatelyResultMoney(expensesMoney))!

    return String(resultIncome - resultExpenses)
}


func rersultForAlert() -> Bool
{
    if Int(ultimatelyResultMoney(goalMoney))! != 0 {
        return Int(ultimatelyResultMoney(savedMoneyProduct))! >= Int(ultimatelyResultMoney(goalMoney))!
    }else
    {
        return false
    }
}


func forCircle() -> Double
{
    Double(ultimatelyResultMoney(savedMoneyProduct))! / Double(ultimatelyResultMoney(goalMoney))!
}

// MARK: - pars USD & EUR

struct ValueMoney: Decodable
{
    let id: String
    let value: Double
}

var currency = "RUB"
var valueUSD: Double?
var valueEUR: Double?
func parsCurrency() {
    guard let url = URL(string: "https://webservice.1prime.ru/pttable?host=1prime.ru&encoding=utf-8&template=prime_gold_site3_jsonp&time=14739380") else {return}
    
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
    
                guard let data = data else {return}

    
                do {
                    let valuesMoney = try  JSONDecoder().decode([ValueMoney].self, from: data)
                    valueUSD = valuesMoney.first?.value
                    valueEUR = valuesMoney.last?.value
                    print(valueUSD!, valueEUR!)
                }catch{
                    print(error)
                }
    
            }.resume()
}
