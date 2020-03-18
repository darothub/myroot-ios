//
//  UserVerificationController.swift
//  myrootsinafrica
//
//  Created by Darot on 18/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class UserVerification : UIViewController {
    
    
    @IBOutlet weak var tfOne: UITextField!
    @IBOutlet weak var tfTwo: UITextField!
    @IBOutlet weak var tfThree: UITextField!
    @IBOutlet weak var tfFour: UITextField!
    
    @IBOutlet weak var resendCodeLabel: UILabel!
    @IBOutlet weak var otpTextFieldContainer: UIView!
    override func viewDidLoad() {
        tfOne.addTarget(self, action: #selector(self.textDidChanged(textField:)), for: UIControl.Event.editingChanged)
        tfTwo.addTarget(self, action: #selector(self.textDidChanged(textField:)), for: UIControl.Event.editingChanged)
        
        tfThree.addTarget(self, action: #selector(self.textDidChanged(textField:)), for: UIControl.Event.editingChanged)
        tfFour.addTarget(self, action: #selector(self.textDidChanged(textField:)), for: UIControl.Event.editingChanged)
        
        
        self.setBackgroundImage("verificationBackground", contentMode: .scaleToFill)
        
        otpTextFieldContainer.layer.cornerRadius = 10
        
        resendCodeLabel.underlineText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tfOne.becomeFirstResponder()
        
        
    }
    
    @objc func textDidChanged(textField : UITextField){
        let text = textField.text
        
        if text?.utf16.count == 1{
            switch textField{
                case tfOne:
                    tfTwo.becomeFirstResponder()
                case tfTwo:
                    tfThree.becomeFirstResponder()
                case tfThree:
                    tfFour.becomeFirstResponder()
                case tfFour:
                    tfFour.resignFirstResponder()
                default:
                    break
            }
        }
        else if text?.utf16.count ?? 0 < 1{
            switch textField{
            case tfFour:
                tfThree.becomeFirstResponder()
            case tfThree:
                tfTwo.becomeFirstResponder()
            case tfTwo:
                tfOne.becomeFirstResponder()
            case tfOne:
                tfOne.resignFirstResponder()
            default:
                break
            }
            
        }
    }
    
    
}
