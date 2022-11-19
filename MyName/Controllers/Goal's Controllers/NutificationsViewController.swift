//
//  FirstViewController.swift
//  MyName
//
//  Created by Daniil Konashenko on 26.09.2022.
//

import UIKit
import UserNotifications

class NatificationTableViewController: UIViewController, UIGestureRecognizerDelegate {
    // Связь с объектами экрана
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    // подключение центра уведомлений
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { permissionGranted, error in
            if (!permissionGranted)
            {
                print("Permission Denied")
            }
        }
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeDown))
        swipeDown.delegate = self
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
    }
    // метод сохраниеня уведомления
    @IBAction func saveActionNutificatio(_ sender: Any) {
        notificationCenter.getNotificationSettings { (settings) in
            // ассинхронное установление задачи в очередь main
            DispatchQueue.main.async { [self] in
                // очистка текстфилда после записи в удедомление
                defer {
                    self.titleTF.text = ""
                }
                
                let title = self.titleTF.text!
                let date = self.datePicker.date
                if(settings.authorizationStatus == .authorized)
                {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = NSLocalizedString("textBody", comment: "")
                    
                    let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    self.notificationCenter.add(request) {(error) in
                        if (error != nil)
                        {
                            print("Error" + error.debugDescription)
                            return
                        }
                    }
                    let ac = UIAlertController(title: NSLocalizedString("textAlertTitle", comment: ""), message: NSLocalizedString("textAlertBody", comment: "") + self.formattedDate(date: date) , preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
                else
                {
                    let ac = UIAlertController(title: NSLocalizedString("textAlertTitle1", comment: ""), message: NSLocalizedString("textAlertBody1", comment: ""), preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: NSLocalizedString("textSettings", comment: ""), style: .default)
                    { (_) in
                        guard let settingsURL = URL(string: UIApplication.openSettingsURLString)
                        else
                        {
                            return
                        }
                        if(UIApplication.shared.canOpenURL(settingsURL))
                        {
                            UIApplication.shared.open(settingsURL)
                        }
                    }
                    ac.addAction(goToSettings)
                    ac.addAction(UIAlertAction(title: NSLocalizedString("textCancel", comment: ""), style: .default))
                    self.present(ac, animated: true)
                }
            }
        }
    }
    // приведение установленной даты к определенному формату
    func formattedDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y HH:mm"
        return formatter.string(from: date)
    }
    // распознователь жестов
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    // свайп вниз
    @objc func hideKeyboardOnSwipeDown() {
        view.endEditing(true)
    }
}
