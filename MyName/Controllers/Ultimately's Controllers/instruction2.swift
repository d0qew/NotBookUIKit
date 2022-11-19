//
//  instruction2.swift
//  MyName
//
//  Created by Daniil Konashenko on 07.11.2022.
//

import UIKit

class instruction2: UIViewController {

    @IBOutlet var instruction2: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        instruction2.text = NSLocalizedString("textInstruction2", comment: "")
    }
}
