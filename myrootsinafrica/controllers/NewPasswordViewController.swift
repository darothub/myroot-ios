//
//  NewPasswordViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 24/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class NewPasswordViewController:ViewController{
    
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        print("new password")
        
        
        self.setBackgroundImage("generalBackground", contentMode: .scaleToFill)
        
        setTextFieldBottomBorder()
        guard let passwordEyeOpen = UIImage(named: "eyeiconopen") else{
                       fatalError("Password image not found")
                   }
        
        passwordTF.addRightImageToTextField(using:passwordEyeOpen)
        confirmPasswordTF.addRightImageToTextField(using: passwordEyeOpen)
        
        
    }
    
    func setTextFieldBottomBorder(){
        codeTF.setBottomBorder()
        confirmPasswordTF.setBottomBorder()
        passwordTF.setBottomBorder()
    }
}
