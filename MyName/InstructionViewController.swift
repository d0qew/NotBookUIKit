//
//  InstructionViewController.swift
//  MyName
//
//  Created by Daniil Konashenko on 02.10.2022.
//

import UIKit

class InstructionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToRoot(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
