//
//  LoginViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 19/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class LoginViewController: ViewController{
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var progressRing: UIActivityIndicatorView!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var dontHaveAnAccountLabel: UILabel!
    
    override func viewDidLoad() {
        print("yay! login")
        
//        progressRing.isHidden = false
        
        setTextFieldsBottomBorder()
        guard let passwordEyeOpen = UIImage(named: "eyeiconopen") else{
                       fatalError("Password image not found")
                   }
        
        passwordTF.addRightImageToTextField(using:passwordEyeOpen)
        forgotPasswordLabel.underlineText()
        dontHaveAnAccountLabel.underlineText()
        
        forgotPasswordLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDetectedForForgotPassword(_ :))))
        
        dontHaveAnAccountLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToDetectedForSignup(_ :))))

    }
    
    func setTextFieldsBottomBorder(){
        emailTF.setBottomBorder()
        passwordTF.setBottomBorder()
        
    }
    
    @objc func tapToDetectedForSignup(_ sender : UITapGestureRecognizer){
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "registerstory") as! ViewController
               self.navigationController?.pushViewController(nextVC, animated: true)
               
    }
           

    @objc func tapDetectedForForgotPassword(_ sender : UITapGestureRecognizer){
        print("login to forgot")
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "forgotstory") as! ViewController
        //        let profile = ProfileViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}
