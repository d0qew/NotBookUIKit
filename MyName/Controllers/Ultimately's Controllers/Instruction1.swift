//
//  Instruction1.swift
//  MyName
//
//  Created by Daniil Konashenko on 07.11.2022.
//

import UIKit

class Instruction1: UIViewController {
    // связь с объектом
    @IBOutlet var instruction1: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instruction1.text = NSLocalizedString("textInstruction1", comment: "")
        
    }
}
