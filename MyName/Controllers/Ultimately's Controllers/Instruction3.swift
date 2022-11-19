//
//  InstructionViewController.swift
//  MyName
//
//  Created by Daniil Konashenko on 02.10.2022.
//

import UIKit

class InstructionViewController: UIViewController {
    
    @IBOutlet var textInstruction3: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textInstruction3.text = NSLocalizedString("textInstruction3", comment: "")
    }
    @IBAction func backToRoot(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
