//
//  UserVerificationController.swift
//  myrootsinafrica
//
//  Created by Darot on 18/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON
import Alamofire

class UserVerification : ViewController {
    
    
    @IBOutlet weak var tfOne: UITextField!
    @IBOutlet weak var tfTwo: UITextField!
    @IBOutlet weak var tfThree: UITextField!
    @IBOutlet weak var tfFour: UITextField!
    
    @IBOutlet weak var resendCodeLabel: UILabel!
    @IBOutlet weak var otpTextFieldContainer: UIView!
    
    @IBOutlet weak var submitButton: SecondaryButton!
    @IBOutlet weak var progressSpinner: UIActivityIndicatorView!
    
    let authViewModel = AuthViewModel(authProtocol: AuthService())
    let disposeBag = DisposeBag()
    var tokens = ""
    
    override func viewDidLoad() {
        
        print("verifytoken \(tokens)")
        tfOne.addTarget(self, action: #selector(self.textDidChanged(textField:)), for: UIControl.Event.editingChanged)
        tfTwo.addTarget(self, action: #selector(self.textDidChanged(textField:)), for: UIControl.Event.editingChanged)
        
        tfThree.addTarget(self, action: #selector(self.textDidChanged(textField:)), for: UIControl.Event.editingChanged)
        tfFour.addTarget(self, action: #selector(self.textDidChanged(textField:)), for: UIControl.Event.editingChanged)
        
        
        self.setBackgroundImage("verificationBackground", contentMode: .scaleToFill)
        
        otpTextFieldContainer.layer.cornerRadius = 10
        otpTextFieldContainer.setViewShadow(using: 5, color: UIColor.black.cgColor)
        
        resendCodeLabel.underlineText()
        self.setupProgressBar(progress: 1)
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
    
    
    @IBAction func verifyUser(_ sender: Any) {
        let fieldValidation = HelperClass.validateField(textFields: tfOne, tfTwo, tfThree,
        tfFour)
        let title = "Verification"
        if fieldValidation.count > 0{
            self.showSimpleAlert(title: title, message: "There is an empty input box", action: false)
            return
        }
        let code = "\(String(describing: tfOne))\(String(describing: tfTwo))\(String(describing: tfThree))\(String(describing: tfFour))"
        print("code \(code)")
        progressSpinner.isHidden = false
        submitButton.isHidden = true
        authViewModel.verifyUser(code: code, token: self.tokens).subscribe(onNext: { (AuthResponse) in
            print("messaage \(String(describing: AuthResponse.message))")
            self.progressSpinner.isHidden = true
            self.submitButton.isHidden = false
            
            guard let verified = AuthResponse.payload?.isVerified else {
                fatalError("Cannot verify user")
            }
            
            if verified {
                 self.showSimpleAlert(title: title, message: AuthResponse.message!, identifier: "gotoVerificationResult", action: true, tokens: nil)
            }
        }, onError: { (Error) in
            self.progressSpinner.isHidden = true
            self.submitButton.isHidden = false
            print("Error: \(String(describing: Error.asAFError))")
            print("Errorcode: \(String(describing: Error.asAFError?.responseCode))")
        }, onCompleted: {
            print("completed")
        }) {
            print("disposed")
        }.disposed(by: disposeBag)
    }
}
