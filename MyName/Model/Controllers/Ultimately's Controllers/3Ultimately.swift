//
//  UltimatelyNavigationViewController.swift
//  MyName
//
//  Created by Daniil Konashenko on 29.09.2022.
//

import UIKit


class UltimatelyViewController: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    
    var labelResultCircle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    @IBOutlet weak var PopUpButtonCurrency: UIButton!
    @IBOutlet weak var labelResultSavedMoney: UILabel!
    @IBOutlet weak var labelResultMoneyGoal: UILabel!
    @IBOutlet weak var lableMounthlyGoal: UILabel!
    @IBOutlet weak var labelDailyGoal: UILabel!
    @IBOutlet weak var labelBudget: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // выбор валюты с последующем ввыводом на экран
        switchCurrrecy()
        
        labelDailyGoal.text = resultGoals(dailyTasks.array)
        lableMounthlyGoal.text = resultGoals(monthlyTasks.array)
        // Do any additional setup after loading the view.
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // standart value for currency
        currency = "RUB"
        
        drawCircle()
        
        // выбор валюты, в которой будут отражаться обработанные данные
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
    
    
    private func setPopUpButton() {
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
    
    private func drawCircle() {
        let center = CGPoint(x: 100, y: 180)
        
        // lable результат % in cirrcle
        
        view.addSubview(labelResultCircle)
        labelResultCircle.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        labelResultCircle.center = center
        labelResultCircle.text = "\(Int(progressMoney() * 100))%"
        
        //track layer
        let endAngePoint = circleProgress()
        print(endAngePoint)
        let trackLayer = CAShapeLayer()
        let circularTrackPath = UIBezierPath(arcCenter: center, radius: 50, startAngle: -CGFloat.pi, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularTrackPath.cgPath
        
        trackLayer.strokeColor = UIColor.white.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        
        view.layer.addSublayer(trackLayer)
        let circularPath = UIBezierPath(arcCenter: center, radius: 50, startAngle: 0, endAngle: endAngePoint, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.yellow.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    private func switchCurrrecy() {
        
        //error pars(сервер упал, либо подключение к интернету отстутвует)
        let alertControllerError = UIAlertController(title: "Error", message: "Problems connecting to the server! \n Check internet connection.", preferredStyle: .alert)
        let alertActionOK =  UIAlertAction(title: "OK", style: .default) {(alert) in
        }
        alertControllerError.addAction(alertActionOK)
        
        switch currency{
            
        case "RUB":
            labelResultSavedMoney.text = ultimatelyResultMoney(savedMoneyProduct.array) + " \u{20bd}"
            labelResultMoneyGoal.text = ultimatelyResultMoney(goalMoney.array) + " \u{20bd}"
            labelBudget.text = resultBudget() + " \u{20bd}"
            
        case "EUR":
            if valueEUR != nil{
                labelResultSavedMoney.text = String(Int((Double(ultimatelyResultMoney(savedMoneyProduct.array))!) / valueEUR!)) + " \u{20ac}"
                labelResultMoneyGoal.text =  String(Int((Double(ultimatelyResultMoney(goalMoney.array))!) / valueEUR!)) + " \u{20ac}"
                labelBudget.text =  String(Int((Double(resultBudget())!) / valueEUR!)) + " \u{20ac}"
                
            }else{
                present(alertControllerError, animated: true)
            }
        case "USD":
            if valueUSD != nil{
                labelResultSavedMoney.text = String(Int((Double(ultimatelyResultMoney(savedMoneyProduct.array))!) / valueUSD!)) + " \u{0024}"
                labelResultMoneyGoal.text = String(Int((Double(ultimatelyResultMoney(goalMoney.array))!) / valueUSD!)) + " \u{0024}"
                labelBudget.text = String(Int((Double(resultBudget())!) / valueUSD!)) + " \u{0024}"
            }else{
                present(alertControllerError, animated: true)
            }
        default:
            break
        }
    }
    
}

