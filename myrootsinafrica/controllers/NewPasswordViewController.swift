//
//  NewPasswordViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 24/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
import CoreData

class NewPasswordViewController:ViewController{
    
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var progressSpinner: UIActivityIndicatorView!
    @IBOutlet weak var submitButton: SecondaryButton!
    let authViewModel = AuthViewModel(authProtocol: AuthService())
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var disposeBag = DisposeBag()
      var userData:UserData?
    
    let fetchRequest = NSFetchRequest<UserData>.init(entityName: "UserData")
    var user:User?
    override func viewDidLoad() {
        print("new password")
        print("user\(String(describing: user))")
        
        self.setBackgroundImage("generalBackground", contentMode: .scaleToFill)
        
        setTextFieldBottomBorder()
        guard let passwordEyeOpen = UIImage(named: "eyeiconopen") else{
                       fatalError("Password image not found")
                   }
        
        passwordTF.addRightImageToTextField(using:passwordEyeOpen)
        confirmPasswordTF.addRightImageToTextField(using: passwordEyeOpen)
        
        
    }
    
    @IBAction func sendResetRequest(_ sender: Any) {
        resetPasswordRequest()
    }
    func setTextFieldBottomBorder(){
        codeTF.setBottomBorder()
        confirmPasswordTF.setBottomBorder()
        passwordTF.setBottomBorder()
    }
    func resetPasswordRequest(){
        let title = "Reset-Password"
        let fieldValidation = HelperClass.validateField(textFields:codeTF, passwordTF, confirmPasswordTF)
        
        if fieldValidation.count > 0{
            for field in fieldValidation{
                guard let placeHolder = field.key.placeholder else{
                    fatalError("Invalid fields")
                }
                showSimpleAlert(title: "Validation", message: "\(placeHolder) is empty", action: false)
            }
            return
        }
        
        guard let code = codeTF.text else{
            fatalError("Invalid code field")
        }
        guard let email = user?.email else{
            fatalError("Invalid email field")
        }
        guard let password = passwordTF.text else{
            fatalError("Invalid password field")
        }
        guard let cpassword = confirmPasswordTF.text else{
            fatalError("Invalid cpassword field")
        }
        print("email \(email)")
        
        if !email.isValidEmail {
            showSimpleAlert(title: "Validation", message: "Invalid email address", action: false)
            return
        }
        else if password != cpassword{
            showSimpleAlert(title: "Validation", message: "Passwords do not match", action: false)
            return
        }
//        let currentUser = setLoggedInUser()
        progressSpinner.isHidden = false
        submitButton.isHidden = true
        authViewModel.resetPassword(email: email, code: code, password: password).subscribe(onNext: { (AuthResponse) in
            print("messaage \(String(describing: AuthResponse.message))")
            self.progressSpinner.isHidden = true
            self.submitButton.isHidden = false
            
            if AuthResponse.status == 200 {
                guard let message = AuthResponse.message else {
                    fatalError("message not found")
                }
                self.user?.changedPassword = true
                
                self.showSimpleAlert(title: title, message: message, identifier: "toSuccessScene", action: true, user: self.user)

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? VerificationResultViewController, let user = sender as? User{
            //
            vc.user = user
            print("tokeninprepare \(user)")
        }
        
    }
}
