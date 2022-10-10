//
//  FirstViewController.swift
//  MyName
//
//  Created by Daniil Konashenko on 26.09.2022.
//

import UIKit
import UserNotifications

class NatificationTableViewController: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { permissionGranted, error in
            if (!permissionGranted)
            {
                print("Permission Denied")
            }
        }
    }
    
    @IBAction func saveActionNutificatio(_ sender: Any) {
        notificationCenter.getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                
                
                let title = self.titleTF.text!
                let date = self.datePicker.date
                if(settings.authorizationStatus == .authorized)
                {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = "Daily Goal is waiting"
                    
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
                    let ac = UIAlertController(title: "Notification Save", message: "At " + self.formattedDate(date: date) , preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
                else
                {
                    let ac = UIAlertController(title: "Enable Notifications?", message: "To use this feature you must enable notifacations in settings", preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: "Settings", style: .default)
                    {
                        (_) in
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
                    ac.addAction(UIAlertAction(title: "Cancel", style: .default))
                    self.present(ac, animated: true)
                }
            }
        }
    }
    
    func formattedDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y HH:mm"
        return formatter.string(from: date)
    }
}
