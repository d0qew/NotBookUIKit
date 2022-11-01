//
//  CustomTabBarController.swift
//  MyName
//
//  Created by Daniil Konashenko on 02.10.2022.
//

import UIKit
// кастомный класс, для выдачи нужного начального экрана
class CustomTabBarController: UITabBarController
{
    @IBInspectable var initialIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = initialIndex
    }
}
