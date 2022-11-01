//
//  LogicUltimately.swift
//  MyName
//
//  Created by Daniil Konashenko on 23.10.2022.
//

import Foundation

// MARK: - TABLE VIEW 3

func ultimatelyResultMoney(_ arr:[[String: Any]]) -> String{
    var result: Int = 0
    if !arr.isEmpty {
        for i in 0...arr.count-1 {
            result += (arr[i]["price"] as? Int)!
        }
        return String(result)
    }else{
        return String(result)
    }
}


func resultGoals(_ arr:[[String : Any]]) -> String{
    var result: Int = 0
    if !arr.isEmpty {
        for i in 0...arr.count-1{
            if (arr[i]["isCompleted"] as? Bool)!{
                result += 1
            }
        }
        return String(result) + "/\(arr.count)"
    }else{
        return String(result) + "/0"
    }
}

func resultBudget() -> String{
    String(Int(ultimatelyResultMoney(incomeMoney.array))! - Int(ultimatelyResultMoney(expensesMoney.array))!)
}


func rersultForAlert() -> Bool{
    if Int(ultimatelyResultMoney(goalMoney.array))! != 0 {
        return Int(ultimatelyResultMoney(savedMoneyProduct.array))! >= Int(ultimatelyResultMoney(goalMoney.array))!
    }else{
        return false
    }
}


func progressMoney() -> Float{
    if Float(ultimatelyResultMoney(goalMoney.array))! > 0 {
        return Float(ultimatelyResultMoney(savedMoneyProduct.array))! / Float(ultimatelyResultMoney(goalMoney.array))!
    }else{
        return Float(0)
    }
}
func circleProgress() ->CGFloat{
    return 2 * CGFloat.pi * CGFloat(progressMoney())
}
// MARK: - pars USD & EUR

struct ValueMoney: Decodable{
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
    
