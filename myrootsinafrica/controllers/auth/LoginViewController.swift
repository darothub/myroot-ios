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
import CoreData


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
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var disposeBag = DisposeBag()
    
    let fetchRequest = NSFetchRequest<UserData>.init(entityName: "UserData")
    
    
    override func viewDidLoad() {
        print("yay! login")
        
//        progressRing.isHidden = false
        
        // set bottom border for text field
        setTextFieldsBottomBorder()
        guard let passwordImage = UIImage(named: "eyeiconclose") else{
                       fatalError("Password image not found")
                   }
        
        //password textfield rightImage
        passwordTF.addRightImageToTextField(using: passwordImage)
        forgotPasswordLabel.underlineText()
        dontHaveAnAccountLabel.underlineText()
        
        emailTF.becomeFirstResponder()
        
        //Tap gesture for forgot password link
        forgotPasswordLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDetectedForForgotPassword(_ :))))
        //Tap gesture for sign up
        dontHaveAnAccountLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToDetectedForSignup(_ :))))
        
        //set returnee data in textfields
        setReturneeData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("hooray")
         
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
    @IBAction func pressEnterToSubmit(_ sender: Any) {
        userLogin()
    }
    
    func userLogin(){
        
        let title = "Sign-in"
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
//        _ = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context)
        progressSpinner.isHidden = false
         submitButton.isHidden = true
        authViewModel.userLogin(email:email, password:password).subscribe(onNext: { (AuthResponse) in
            print("messaage \(String(describing: AuthResponse.message))")
            self.progressSpinner.isHidden = true
            self.submitButton.isHidden = false
            self.tokens = AuthResponse.token ?? "default value"
          
            print("name \(String(describing: AuthResponse.payload)))")
            
             if AuthResponse.status == 200 {
                guard let payload = AuthResponse.payload else {
                    fatalError("User payload not found")
                }
                let user = User(name: payload.name, email: payload.email, password: password, country: payload.country, phone: payload.phone, token: AuthResponse.token)
              
                 print("selftok \( self.tokens )")
                 self.showSimpleAlert(title: title, message: AuthResponse.message!, identifier: "toDashboard", action: true, user: user)
                
                do{
                    let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: self.context)
                    
                    newUser.setValue(payload.name, forKey: "name")
                    newUser.setValue(payload.email, forKey: "email")
                    newUser.setValue(password, forKey: "password")
                    newUser.setValue(payload.country, forKey: "country")
                    newUser.setValue(payload.phone, forKey: "phone")
                    newUser.setValue(AuthResponse.token, forKey: "token")
                    newUser.setValue(false, forKey: "newTree")
                    print("userLoggedInonDash \(String(describing: newUser))")
//                    print("userEmailOnDashBoard \(String(describing: newUser))")
                    do{
                        try self.context.save()
                        print("dashBoardSaved")
                    }catch{
                        print("Error updating entity")
                    }
                }
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
        if let vc = segue.destination as? DashBoardViewController, let user = sender as? User{
            //
            vc.user = user
            print("tokeninprepare \(user)")
        }
        
    }
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue){
//        print("email \(emailTF.text!)")
        fetchRequest.predicate = NSPredicate(format: "email = %@", emailTF.text!)

        if segue.source is DashBoardViewController{
            do{
                let result = try self.context.fetch(fetchRequest)
                let data = result[0]
                data.setValue(false, forKey: "loggedIn")
                print("userLogInOnLogin \(String(describing: data.loggedIn))")
                do{
                    try context.save()
                }catch{
                    print("Error updating entity")
                }
            }catch{
                print(error)
            }
        }
    }
    
    func setReturneeData(){
        
        let returnee = HelperClass.getUserData()
        emailTF.text = returnee.email
        passwordTF.text = returnee.password
//        do{
//            let result = try self.context.fetch(fetchRequest)
//            if result.count > 0{
//                let data = result[0]
//                emailTF.text = data.email
//                passwordTF.text = data.password
//                print("userLogIn1 \(String(describing: data.loggedIn))")
//            }
//         }catch{
//             print(error)
//         }
    }

}
