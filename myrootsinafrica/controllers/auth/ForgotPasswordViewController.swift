//
//  ForgotPasswordViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 24/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
import CoreData
import RealmSwift

class ForgotPasswordViewController:UIViewController{
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var submitButton: SecondaryButton!
    @IBOutlet weak var progressSpinner: UIActivityIndicatorView!
    var authViewModel = AuthViewModel(authProtocol: AuthService())
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var disposeBag = DisposeBag()
      var userData:UserData?
    
    let fetchRequest = NSFetchRequest<UserData>.init(entityName: "UserData")
    override func viewDidLoad() {
        print("You forgot your password")
        
        self.setBackgroundImage("generalBackground", contentMode: .scaleToFill)
        
        emailTF.setBottomBorder()
        
    }
    
    @IBAction func pressEnterToSubmit(_ sender: Any) {
        forgotPasswordRequest()
    }
    @IBAction func submitRequest(_ sender: Any) {
        forgotPasswordRequest()
    }
    func forgotPasswordRequest(){
        let title = "Forgot-Password"
        let fieldValidation = HelperClass.validateField(textFields:emailTF)
        
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
        print("email \(email)")
        
        if !email.isValidEmail {
            showSimpleAlert(title: "Validation", message: "Invalid email address", action: false)
            return
        }
        let currentUser = HelperClass.getUserData(predicate:"email = '\(email)'")
        print("currentuser \(String(describing: currentUser))")
        progressSpinner.isHidden = false
        submitButton.isHidden = true
        authViewModel.forgotPassword(email: email).subscribe(onNext: { (AuthResponse) in
            print("messaage \(String(describing: AuthResponse.message))")
            self.progressSpinner.isHidden = true
            self.submitButton.isHidden = false
            
            if AuthResponse.status == 200 {
                guard let message = AuthResponse.message else {
                    fatalError("message not found")
                }
                let user = User()
//                user.name = currentUser.name
                user.email = email
//                user.password = currentUser.password
//                user.country = currentUser.country
//                user.phone = currentUser.phone
                
                self.showSimpleAlert(title: title, message: message, identifier: "toNewPasswordScene", action: true, user: user)

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
        if let vc = segue.destination as? NewPasswordViewController, let user = sender as? User{
            //
            vc.user = user
            print("tokeninprepare \(user)")
        }
        
    }
    
    func setLoggedInUser()->UserData{
        
        do{
            let result = try self.context.fetch(fetchRequest)
            if result.count > 0{
                userData = result[0]
                let data = result[0]
                data.setValue(true, forKey: "loggedIn")
                print("userLogIn1Dash \(String(describing: data.loggedIn))")
            }
            do{
                try self.context.save()
                print("dashBoardSaved")
            }catch{
                print("Error updating entity")
            }
            
        }catch{
            print(error)
        }

        return userData!
    }

}
