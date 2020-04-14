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
    
    var authViewModel = AuthViewModel(authProtocol: AuthService())
    
    var tokens = ""
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var disposeBag = DisposeBag()
    
    let fetchRequest = NSFetchRequest<UserData>.init(entityName: "UserData")

   
    let realm = try! Realm()

    private lazy var container = self.createView(with: .clear)
    private lazy var scroller = self.createScrollView()

    lazy var header = self.createUIlabelBold(with: "login".localized, and: 22.0)
    lazy var emailText = self.createUIlabel(with: "email".localized, and: 22.0)
    lazy var emailTF = self.createUITextField(with:"email".localized, height: 33.0, type: .emailAddress)
    lazy var passwordText = self.createUIlabel(with: "password".localized, and: 22.0)
    lazy var passwordTF = self.createUITextField(with: "password".localized, height: 33.0, type: .asciiCapable)
    lazy var forgotPasswordLabel = self.createUIlabel(with: "forgotPassword".localized, and: 16.0, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    lazy var registerLink = self.createUIlabel(with: "registerLink".localized, and: 16.0, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    lazy var loginUIButton = self.createButton(with: "login".localized, and: #colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1), action: #selector(loginAction))
    lazy var progressSpinner = self.createUIActivityIndicatorView()

    lazy var viewHeight = container.frame.height
    

    override func viewDidLoad() {
        
        addViews()
        setViewConstraints()
        view.layer.contents = #imageLiteral(resourceName: "loginBackground").cgImage
        
        // set bottom border for text field
        setTextFieldsBottomBorder()

   
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        

        guard let passwordImage = UIImage(named: "eyeiconclose") else{
            fatalError("Password image not found")
        }


        //password textfield rightImage
        passwordTF.addRightImageToTextField(using: passwordImage)
        passwordTF.isSecureTextEntry = true
        forgotPasswordLabel.underlineText()
        registerLink.underlineText()
//
        emailTF.becomeFirstResponder()
//
        //Tap gesture for forgot password link
        forgotPasswordLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDetectedForForgotPassword(_ :))))
        
//        //Tap gesture for sign up
        registerLink.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToDetectedForSignup(_ :))))
        
        passwordTF.addTarget(self, action: #selector(pressEnterToSubmit), for: .primaryActionTriggered)
//
//        //set returnee data in textfields
//        setReturneeData()
//
        self.addCustomBackButton(action: #selector(self.gotoScene))
        
        setReturneeData()
  
 
        

    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.transparentNavBar()

         
    }

    
    func setTextFieldsBottomBorder(){
        emailTF.setBottomBorder()
        passwordTF.setBottomBorder()
        
    }

    @objc func tapToDetectedForSignup(_ sender : UITapGestureRecognizer){

        self.moveToDestination(with: "registerstory")

    }
           

    @objc func tapDetectedForForgotPassword(_ sender : UITapGestureRecognizer){
   

        self.moveToDestination(with: "forgotstory")

    }

    
    @objc func pressEnterToSubmit(){
        userLogin()
    }
    @objc func loginAction(){
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
        loginUIButton.isHidden = true
        authViewModel.userLogin(email:email, password:password).subscribe(onNext: { (AuthResponse) in
            print("messaage \(String(describing: AuthResponse.message))")
            self.progressSpinner.isHidden = true
            self.loginUIButton.isHidden = false
            self.tokens = AuthResponse.token ?? "default value"

         

             if AuthResponse.status == 200 {
                guard let payload = AuthResponse.payload else {
                    fatalError("User payload not found")
                }

//                let user = User(name: payload.name, email: payload.email, password: password, country: payload.country, phone: payload.phone, token: AuthResponse.token)
                // Query and update from any thread

                
                var user = self.realm.object(ofType: User.self, forPrimaryKey: email)
                if user != nil{
                    try! self.realm.write {
                        user?.loggedIn.value = true
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
                    user?.loggedIn.value = true


                    do{
                        try! self.realm.write{
                            self.realm.add(user!)
                        }
                    }catch{
                        print(error)
                    }
                }
                self.showSimpleAlert(title: title, message: AuthResponse.message!, identifier: "toDashboard", action: true, user: user)
        
             }
             else{
                 self.showSimpleAlert(title: title, message: AuthResponse.message!, action: false)
             }

         }, onError: { (Error) in
             self.progressSpinner.isHidden = true
             self.loginUIButton.isHidden = false
             print("Error: \(String(describing: Error.asAFError))")
             print("Errorcode: \(String(describing: Error.asAFError?.responseCode))")
         }, onCompleted: {
             print("completed")
         }, onDisposed: {
             print("disposed")
         }).disposed(by: disposeBag)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DashBoardViewController, let user = sender as? User{
            vc.user = user
    
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

 
    }


    
    func setReturneeData(){
        
        let returningUsers = realm.objects(User.self)
        
        if returningUsers.count > 0{
            let lastUser = returningUsers.last
            print("user here \(lastUser)")
            emailTF.text = lastUser?.email
            passwordTF.text = lastUser?.password
        }
        else{
            print("Nothing here")
        }

    }

    

    
    //MARK: add views
    private func addViews(){
        
        view.addSubview(self.scroller)
        scroller.edgesToSuperview()
        scroller.addSubview(self.container)
        customAddToSubView(parent:container, views: header, emailText, emailTF, passwordText, passwordTF, forgotPasswordLabel, loginUIButton, registerLink, progressSpinner)
       
    }
     //MARK: set constraints
    private func setViewConstraints() {
        header.centerX(to: container)
        header.top(to: self.container, offset: viewHeight/12, isActive: true)
        emailText.top(to: header, offset: viewHeight/6, isActive: true)
        emailTF.top(to: emailText, offset: 40, isActive: true)
        emailTF.right(to: self.container, offset: -20, isActive: true)
        passwordText.top(to: emailTF, offset: 50, isActive: true)
        passwordTF.top(to: passwordText, offset: 40, isActive: true)
        passwordTF.right(to: self.container, offset: -20, isActive: true)
        forgotPasswordLabel.top(to: passwordTF, offset: 40, isActive: true)
        forgotPasswordLabel.right(to: self.container, offset: -20, isActive: true)
        loginUIButton.top(to: forgotPasswordLabel, offset: 50, isActive: true)
        loginUIButton.centerX(to: container)
        progressSpinner.top(to: forgotPasswordLabel, offset: 50, isActive: true)
        progressSpinner.centerX(to: container)
        registerLink.centerX(to: container)
        registerLink.top(to: loginUIButton, offset: 55, isActive: true)
        setToEqualLeadingAndTrailing(parent: container, leading: 50, trailing: -50, views: loginUIButton)
        setleftAnchorToContainerView(parent: container, views: emailText, emailTF, passwordText, passwordTF)
        
        
    }

    

  
}
