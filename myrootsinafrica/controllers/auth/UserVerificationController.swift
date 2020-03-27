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
    var user:User?
    
    override func viewDidLoad() {
        
        print("verifyUser \(user?.name)")
        tfOne.addTarget(self, action: #selector(self.textDidChanged(textField:)), for: UIControl.Event.editingChanged)
        tfTwo.addTarget(self, action: #selector(self.textDidChanged(textField:)), for: UIControl.Event.editingChanged)
        
        tfThree.addTarget(self, action: #selector(self.textDidChanged(textField:)), for: UIControl.Event.editingChanged)
        tfFour.addTarget(self, action: #selector(self.textDidChanged(textField:)), for: UIControl.Event.editingChanged)
        
        setTextFieldMaxLength(textFields: tfOne, tfTwo, tfThree, tfFour)
        
        self.setBackgroundImage("verificationBackground", contentMode: .scaleToFill)
        
        otpTextFieldContainer.layer.cornerRadius = 10
        otpTextFieldContainer.setViewShadow(using: 5, color: UIColor.black.cgColor)
        
        resendCodeLabel.underlineText()
        
        resendCodeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToResendCode(_ :))))
        
        self.setupProgressBar(progress: 1)
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tfOne.becomeFirstResponder()
        
        
    }
    
    @objc func tapToResendCode(_ sender : UITapGestureRecognizer){
        resendCode()
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
    
    func setTextFieldMaxLength(textFields:UITextField...){
        for field in textFields{
            field.setMaxLength()
        }
    }
    
    @IBAction func pressEnterToSubmit(_ sender: Any) {
         verifyUser()
    }
   
    
    @IBAction func verifyUser(_ sender: Any) {
        verifyUser()
    }
    
    func verifyUser(){
        let fieldValidation = HelperClass.validateField(textFields: tfOne, tfTwo, tfThree,
                                                        tfFour)
        let title = "Verification"
        if fieldValidation.count > 0{
            self.showSimpleAlert(title: title, message: "There is an empty input box", action: false)
            return
        }
        let code = tfOne.text! + tfTwo.text! + tfThree.text! + tfFour.text!
        guard let token = user?.token else{
            fatalError("Error getting tokenString")
        }
        print("code \(code)")
        progressSpinner.isHidden = false
        submitButton.isHidden = true
        authViewModel.verifyUser(code: code, token: token).subscribe(onNext: { (AuthResponse) in
            print("messaage \(String(describing: AuthResponse.message))")
            
            self.progressSpinner.isHidden = true
            self.submitButton.isHidden = false
            let payload = AuthResponse.payload
            
            if AuthResponse.status == 200{
                print("Its verified confirmed")
                //                  self.performSegue(withIdentifier: "toSuccessPage", sender: self)
                self.showSimpleAlert(title: title, message: AuthResponse.message!, identifier: "toSuccessPage", action: true, user: self.user)
            }
                
            else if payload == nil{
                print("Its verifiedtttt")
                self.showSimpleAlert(title: title, message: AuthResponse.message!, action: false, user: nil)
                //                self.performSegue(withIdentifier: "toSuccessPage", sender: self)
                
            }
            else if payload != nil{
    
                print("Its verified")
                
            }
            
        }, onError: { (Error) in
            self.progressSpinner.isHidden = true
            self.submitButton.isHidden = false
            print("Error: \(String(describing: Error.localizedDescription))")
            print("Errorcode: \(String(describing: Error.asAFError?.responseCode))")
        }, onCompleted: {
            print("completed")
        }) {
            print("disposed")
        }.disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? VerificationResultViewController, let user = sender as? User{
            //
            vc.user = user
            print("userSegue \(user)")
        }
        
    }
    
    func resendCode(){
        
        var currentUser = User(name: user?.name, email: user?.email, password: user?.password,
                           country: user?.country, phone: user?.phone)
     
        let title = "Verification"
        progressSpinner.isHidden = false
        submitButton.isHidden = true
        authViewModel.registerUser(user: currentUser).subscribe(onNext: { (AuthResponse) in
            print("messaage \(String(describing: AuthResponse.message))")
            self.progressSpinner.isHidden = true
            self.submitButton.isHidden = false
            currentUser.token = AuthResponse.token ?? "default value"
            if AuthResponse.status == 200 {
                
                print("selftok \( self.tokens )")
                self.showSimpleAlert(title: title, message: AuthResponse.message!, action: false)
                //                self.performSegue(withIdentifier: "gotoVerification", sender: self.tokens)
            }
            else{
                self.showSimpleAlert(title: title, message: AuthResponse.message!, action: false)
            }
            
        }, onError: { (Error) in
            self.progressSpinner.isHidden = true
            self.submitButton.isHidden = false
            print("Error: \(String(describing: Error.asAFError))")
            print("Errorcode: \(String(describing: Error.asAFError?.responseCode))")
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        }).disposed(by: disposeBag)
    }
}
