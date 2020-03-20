//
//  LoginViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 19/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var dontHaveAnAccountLabel: UILabel!
    
    override func viewDidLoad() {
        print("yay! login")
        
        setTextFieldsBottomBorder()
        guard let passwordEyeOpen = UIImage(named: "eyeiconopen") else{
                       fatalError("Password image not found")
                   }
        
      
        passwordTF.addRightImageToTextField(using:passwordEyeOpen)
        forgotPasswordLabel.underlineText()
        dontHaveAnAccountLabel.underlineText()

    }
    
    func setTextFieldsBottomBorder(){
        emailTF.setBottomBorder()
        passwordTF.setBottomBorder()
    }
}