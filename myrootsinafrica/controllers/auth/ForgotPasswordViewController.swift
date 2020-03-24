//
//  ForgotPasswordViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 24/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ForgotPasswordViewController:ViewController{
    
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        print("You forgot your password")
        
        self.setBackgroundImage("generalBackground", contentMode: .scaleToFill)
        
        emailTF.setBottomBorder()
    }
}
