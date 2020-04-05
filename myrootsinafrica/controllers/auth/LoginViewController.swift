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
import RealmSwift
import Realm
import Unrealm


class LoginViewController: UIViewController{
    
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
   
    let realm = try! Realm()
    override func viewDidLoad() {
        print("yay! login")
        
//        progressRing.isHidden = false
        
        // set bottom border for text field
        setTextFieldsBottomBorder()
        guard let passwordImage = UIImage(named: "eyeiconclose") else{
                       fatalError("Password image not found")
                   }
        
       
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
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
        super.viewDidAppear(animated)
        print("hooray")
        self.transparentNavigationBar()

         
    }
    
    func setTextFieldsBottomBorder(){
        emailTF.setBottomBorder()
        passwordTF.setBottomBorder()
        
    }
    
    @objc func tapToDetectedForSignup(_ sender : UITapGestureRecognizer){
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "registerstory") as! UIViewController
               self.navigationController?.pushViewController(nextVC, animated: true)
               
    }
           

    @objc func tapDetectedForForgotPassword(_ sender : UITapGestureRecognizer){
        print("login to forgot")
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "forgotstory") as! UIViewController
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
//                let user = User(name: payload.name, email: payload.email, password: password, country: payload.country, phone: payload.phone, token: AuthResponse.token)
                // Query and update from any thread

                
                var user = self.realm.object(ofType: User.self, forPrimaryKey: email)
                if user != nil{
                    try! self.realm.write {
                        user?.loggedIn = true
                    }
                }
                else{
                    user = User()
                    user?.name = payload.name!
                    user?.email = payload.email!
                    user?.password = password
                    user?.country = payload.country!
                    user?.phone = payload.phone!
                    user?.token = AuthResponse.token!
                    user?.loggedIn = true
                    
                    do{
                        try! self.realm.write{
                            self.realm.add(user!)
                        }
                    }catch{
                        print(error)
                    }
                }
                self.showSimpleAlert(title: title, message: AuthResponse.message!, identifier: "toDashboard", action: true, user: user)
             
                
         
              
                 print("selftok \( self.tokens )")
               
                
                
            
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
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let thisRealm = try! Realm()
                var user = thisRealm.objects(User.self).filter("loggedIn = true")
                if user != nil{
                    try! thisRealm.write {
                        user.first?.loggedIn = false
                    }
                }
            }
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "homeScene") as! UIViewController
            //        let profile = ProfileViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
//            self.performSegue(withIdentifier: "toHomeScene", sender: self)
        }
    }

    
    
   


//
  
    
    func setReturneeData(){
        
        let returningUsers = realm.objects(User.self)
        
        if returningUsers.count > 0{
            let lastUser = returningUsers.last
            emailTF.text = lastUser?.email
            passwordTF.text = lastUser?.password
        }
        else{
            print("Nothing here")
        }

    }
    

}
