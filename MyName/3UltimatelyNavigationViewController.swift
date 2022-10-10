//
//  UltimatelyNavigationViewController.swift
//  MyName
//
//  Created by Daniil Konashenko on 29.09.2022.
//

import UIKit


class UltimatelyViewController: UIViewController {
    
    @IBOutlet weak var PopUpButtonCurrency: UIButton!
    @IBOutlet weak var labelResultSavedMoney: UILabel!
    @IBOutlet weak var labelResultMoneyGoal: UILabel!
    @IBOutlet weak var lableMounthlyGoal: UILabel!
    @IBOutlet weak var labelDailyGoal: UILabel!
    @IBOutlet weak var labelBudget: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //парсим данные с курсом
        parsCurrency()
        
        switch currency{
        case "RUB":
            labelResultSavedMoney.text = ultimatelyResultMoney(savedMoneyProduct) + " \u{20bd}"
            labelResultMoneyGoal.text = ultimatelyResultMoney(goalMoney) + " \u{20bd}"
            labelBudget.text = resultBudget() + " \u{20bd}"
            
        case "EUR":
            labelResultSavedMoney.text = String(Int((Double(ultimatelyResultMoney(savedMoneyProduct))!) / valueEUR!)) + " \u{20ac}"
            labelResultMoneyGoal.text =  String(Int((Double(ultimatelyResultMoney(goalMoney))!) / valueEUR!)) + " \u{20ac}"
            labelBudget.text =  String(Int((Double(resultBudget())!) / valueEUR!)) + " \u{20ac}"
        case "USD":
            labelResultSavedMoney.text = String(Int((Double(ultimatelyResultMoney(savedMoneyProduct))!) / valueUSD!)) + " \u{0024}"
            labelResultMoneyGoal.text = String(Int((Double(ultimatelyResultMoney(goalMoney))!) / valueUSD!)) + " \u{0024}"
            labelBudget.text = String(Int((Double(resultBudget())!) / valueUSD!)) + " \u{0024}"
        default:
            break
        }
        labelDailyGoal.text = resultGoals(dailyGoals)
        lableMounthlyGoal.text = resultGoals(mounthlyGoals)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currency = "RUB"
        viewDidLoad()
        
        setPopUpButton()
        
        
        if rersultForAlert()
        {
            let alertControllerUl = UIAlertController(title: "Good job", message: "You can buy sweets or \n add new Goal for money!", preferredStyle: .alert)
            let alertActionFirstUl =  UIAlertAction(title: "OK", style: .default) {(alert) in
                }
            alertControllerUl.addAction(alertActionFirstUl)
            present(alertControllerUl, animated: true)
        }
    }
    
    func setPopUpButton()
    {
        let optionClosure = {(action : UIAction) in
            currency = action.title
            self.viewDidLoad()
        }
        PopUpButtonCurrency.menu = UIMenu(children : [
            UIAction(title: "RUB", state: . on, handler: optionClosure),
            UIAction(title: "USD", handler: optionClosure),
            UIAction(title: "EUR", handler: optionClosure)
        ])
        PopUpButtonCurrency.showsMenuAsPrimaryAction = true
        PopUpButtonCurrency.changesSelectionAsPrimaryAction = true
    }
}

