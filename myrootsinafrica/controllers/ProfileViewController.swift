//
//  ProfileViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 23/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ProfileViewController : UIViewController{
    
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var fullNameTF: UITextField!
    override func viewDidLoad() {
        print("Profile")
        
        self.setBackgroundImage("generalBackground", contentMode: .scaleToFill)
        setTextFieldBottomBorder()
    }
    
    func setTextFieldBottomBorder(){
        countryTF.setBottomBorder()
        emailTF.setBottomBorder()
        phoneTF.setBottomBorder()
        fullNameTF.setBottomBorder()
    }
}
