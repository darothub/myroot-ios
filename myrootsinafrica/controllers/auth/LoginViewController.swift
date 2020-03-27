//
//  LoginViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 19/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
import Alamofire


class LoginViewController: ViewController{
    
    @IBOutlet weak var emailTF: UITextField!

    
    @IBOutlet weak var progressRing: UIActivityIndicatorView!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var dontHaveAnAccountLabel: UILabel!
    
    @IBOutlet weak var submitButton: SecondaryButton!
    @IBOutlet weak var progressSpinner: UIActivityIndicatorView!
    let authViewModel = AuthViewModel(authProtocol: AuthService())
    
    var tokens = ""
    
    var disposeBag = DisposeBag()
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
    @IBAction func loginButtonAction(_ sender: Any) {
        userLogin()
    }
    @IBAction func pressReturnToLogin(_ sender: Any) {
        userLogin()
    }
    func userLogin(){
        
        var title = "Sign-in"
        let fieldValidation = HelperClass.validateField(textFields:emailTF, passwordTF)
        
        if fieldValidation.count > 0{
            for field in fieldValidation{
                guard let placeHolder = field.key.placeholder else{
                    fatalError("Invalid fields")
                }
                showSimpleAlert(title: "Validation", message: "\(placeHolder) is empty", action: false)
            }
            return
        }
        
        guard let email = emailTF.text else{
              fatalError("Invalid email field")
          }
          guard let password = passwordTF.text else{
              fatalError("Invalid password field")
          }
    
          
          if !email.isValidEmail {
              showSimpleAlert(title: "Validation", message: "Invalid email address", action: false)
              return
          }
          else if !password.isValidPassword {
              showSimpleAlert(title: "Validation", message: "Invalid password", action: false)
              return
          }
        
        progressSpinner.isHidden = false
         submitButton.isHidden = true
        authViewModel.userLogin(email:email, password:password).subscribe(onNext: { (AuthResponse) in
             print("messaage \(String(describing: AuthResponse.message))")
             self.progressSpinner.isHidden = true
             self.submitButton.isHidden = false
             self.tokens = AuthResponse.token ?? "default value"
             if AuthResponse.status == 200 {
                 
                 print("selftok \( self.tokens )")
                 self.showSimpleAlert(title: title, message: AuthResponse.message!, identifier: "toDashboard", action: true, tokens: self.tokens)
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
         
//
//         print("tokendown \(token)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DashBoardViewController, let tokenSent = sender as? String{
            //
            vc.tokens = tokenSent
            print("tokeninprepare \(tokenSent)")
        }
        
    }
}
