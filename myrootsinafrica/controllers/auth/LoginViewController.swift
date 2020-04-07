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
    
    let authViewModel = AuthViewModel(authProtocol: AuthService())
    
    var tokens = ""
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var disposeBag = DisposeBag()
    
    let fetchRequest = NSFetchRequest<UserData>.init(entityName: "UserData")
    

    lazy var header = self.createUIlabelBold(with: NSLocalizedString("login", comment: "login"), and: 34.0)
    lazy var emailText = self.createUIlabel(with: NSLocalizedString("email", comment: "email"), and: 22.0)
    lazy var emailTF = self.createUITextField(with: NSLocalizedString("email", comment: "email"), height: 33.0, type: .emailAddress)
    lazy var passwordText = self.createUIlabel(with: NSLocalizedString("password", comment: "password header"), and: 22.0)
    lazy var passwordTF = self.createUITextField(with: NSLocalizedString("password", comment: "password text field"), height: 33.0, type: .asciiCapable)
    lazy var forgotPasswordLabel = self.createUIlabel(with: NSLocalizedString("forgotPassword", comment: "to reset password"), and: 16.0, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    lazy var registerLink = self.createUIlabel(with: NSLocalizedString("registerLink", comment: "to register"), and: 16.0, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    lazy var loginUIButton = self.createButton(with: NSLocalizedString("login", comment: "login"), and: #colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1), action: #selector(loginAction))
    lazy var progressSpinner = self.createUIActivityIndicatorView()

    lazy var viewHeight = containerView.frame.height
    
    
    override func viewDidLoad() {
        print("yay! login")
        print("height \(viewHeight)")
        
        addViews()
        setViewConstraints()
        view.layer.contents = #imageLiteral(resourceName: "loginBackground").cgImage
        
        // set bottom border for text field
        setTextFieldsBottomBorder()
        guard let passwordImage = UIImage(named: "eyeiconopen") else{
            fatalError("Password image not found")
        }

        //password textfield rightImage
        passwordTF.addRightImageToTextField(using: passwordImage)
        
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
        addCustomBackButton()
        

    }
    
    
    func setTextFieldsBottomBorder(){
        emailTF.setBottomBorder()
        passwordTF.setBottomBorder()
        
    }
    func addCustomBackButton(){
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "backicon"), for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        backButton.addTarget(self, action: #selector(gotoHomeScene), for: .touchUpInside)
    }
    @objc func tapToDetectedForSignup(_ sender : UITapGestureRecognizer){
        self.moveToDestination(with: "registerstory")
    }
           

    @objc func tapDetectedForForgotPassword(_ sender : UITapGestureRecognizer){
        print("login to forgot")
        self.moveToDestination(with: "forgotstory")
    }


    @objc func gotoHomeScene(){
        self.moveToDestination(with: "homeScene")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
            print("tokeninprepare \(user)")
        }
        
    }
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue){
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

   
    
    func setReturneeData(){
        
        let returnee = HelperClass.getUserData()
        emailTF.text = returnee.email
        passwordTF.text = returnee.password

    }
    
    //MARK: add views
    private func addViews(){
        
        view.addSubview(self.scrollView)
        scrollView.edgesToSuperview()
        scrollView.addSubview(self.containerView)
        customAddToSubView(parent:containerView, views: header, emailText, emailTF, passwordText, passwordTF, forgotPasswordLabel, loginUIButton, registerLink, progressSpinner)
       
    }
     //MARK: set constraints
    private func setViewConstraints() {
        header.centerX(to: containerView)
        header.top(to: self.containerView, offset: viewHeight/12, isActive: true)
        emailText.top(to: header, offset: viewHeight/6, isActive: true)
        emailTF.top(to: emailText, offset: 40, isActive: true)
        emailTF.right(to: self.containerView, offset: -20, isActive: true)
        passwordText.top(to: emailTF, offset: 50, isActive: true)
        passwordTF.top(to: passwordText, offset: 40, isActive: true)
        passwordTF.right(to: self.containerView, offset: -20, isActive: true)
        forgotPasswordLabel.top(to: passwordTF, offset: 40, isActive: true)
        forgotPasswordLabel.right(to: self.containerView, offset: -20, isActive: true)
        loginUIButton.top(to: forgotPasswordLabel, offset: 50, isActive: true)
        loginUIButton.centerX(to: containerView)
        progressSpinner.top(to: forgotPasswordLabel, offset: 50, isActive: true)
        progressSpinner.centerX(to: containerView)
        registerLink.centerX(to: containerView)
        registerLink.top(to: loginUIButton, offset: 55, isActive: true)
        setToEqualLeadingAndTrailing(parent: containerView, leading: 50, trailing: -50, views: loginUIButton)
        setleftAnchorToContainerView(parent: containerView, views: emailText, emailTF, passwordText, passwordTF)
        
        
    }
    

  
}
