//
//  SignupController.swift
//  myrootsinafrica
//
//  Created by Darot on 15/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import iOSDropDown
import ParticlesLoadingView
import Alamofire
import SwiftyJSON
import RxSwift



class SignupController: UIViewController {
    
    @IBOutlet weak var haveaccounttext: UILabel!
    @IBOutlet weak var myViewHeightConstraint: NSLayoutConstraint!
    
  
    
    let authViewModel = AuthViewModel(authProtocol: AuthService())
    
    var testText = ""
    @IBOutlet weak var countryCodeTextField: UITextField!
    
   
    
    @IBOutlet weak var dialCodeTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
  
     
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var progressSpinner: UIActivityIndicatorView!
    @IBOutlet weak var signupScrollView: UIScrollView!
    
    @IBOutlet weak var countryDropDown: DropDown!
    
    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var loginLinkLabel: UILabel!
    
    @IBOutlet weak var passwordStandardLabel: UILabel!
    
    @IBOutlet weak var submitButton: SecondaryButton!
    var tokens = ""
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        print("Yaay signup")
        
        print("token:\(tokens)")
        
        //set progress bar
        self.setupProgressBar(progress: 0.5)
        
        //underline link
        haveaccounttext.underlineText()
        
        //setting placeholder from segue text
//        firstNameTF.placeholder = testText
        
        //setTextfields bottomBorder
        setTextFieldBottomBorder(textFields: firstNameTF, lastNameTF, emailTF, passwordTF,
                                 dialCodeTF, phoneNumberTF, countryDropDown)
        //Disable dialcode textfield
        dialCodeTF.isUserInteractionEnabled = false
        
        //password textfield right image
        guard let passwordImage = UIImage(named: "eyeiconclose") else{
            fatalError("Password image not found")
        }
       
        //password textfield rightImage
        passwordTF.addRightImageToTextField(using: passwordImage)
        

        //set country drop down list
        let countryAndCodeDict = CountryAndCode.countryAndCodes()
        var countryList = [String]()
        for key in countryAndCodeDict.keys{
            countryList.append(key)
        }
        countryDropDown.optionArray = countryList.sorted()
        countryDropDown.didSelect{(selectedText , index ,id) in
            self.dialCodeTF.text = countryAndCodeDict[selectedText]
        }
        
        //add tapgesture listener on loginlink
        loginLinkLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToDetectedForLogin(_:))))
        
        //set view background image
        view.layer.contents = #imageLiteral(resourceName: "signupBackground").cgImage
        passwordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        

//        self.transparentNavBar()
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        

    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = passwordTF.text else{
            fatalError("No text FOUND")
        }
        if !text.isValidPassword {
            passwordStandardLabel.isHidden = false
            
        }else{
           
            passwordStandardLabel.isHidden = true
            
        }
    }

    
    @objc func tapToDetectedForLogin(_ sender : UITapGestureRecognizer){
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "loginstory") as! UIViewController
        //        let profile = ProfileViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
       
                  
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        CountryAndCode.countryAndCodes()
        
    }
    
    
    //MARK: Set textfields BottomBorder
    func setTextFieldBottomBorder(textFields:UITextField...){
        
        for field in textFields {
            field.setBottomBorder()
        }
    }
    
   
    @IBAction func pressEnterToSubmit(_ sender: Any) {
        registerUser()
    }
    
    
    @IBAction func register(_ sender: Any) {
         registerUser()
    }
   
    
    func registerUser(){
        
        var title = "Registration"
        let fieldValidation = HelperClass.validateField(textFields: firstNameTF, lastNameTF, emailTF,
                                                        passwordTF, phoneNumberTF, countryDropDown)
        
        
        if fieldValidation.count > 0{
            for field in fieldValidation{
                guard let placeHolder = field.key.placeholder else{
                    fatalError("Invalid fields")
                }
                showSimpleAlert(title: title, message: "\(placeHolder) is empty", action: false)
            }
            return
        }
        
        
        let fullName = firstNameTF.text! + " " + lastNameTF.text!
        guard let email = emailTF.text else{
            fatalError("Invalid email field")
        }
        guard let password = passwordTF.text else{
            fatalError("Invalid password field")
        }
        let phone = phoneNumberTF.text
        let country = countryDropDown.text
        
        
        if !email.isValidEmail {
            showSimpleAlert(title:title, message: "Invalid email address", action: false)
            return
        }
        else if !password.isValidPassword {
            showSimpleAlert(title: title, message: "Invalid password", action: false)
            return
        }
        
        var userDetails = UserDetails()
        userDetails.name = fullName
        userDetails.email = email
        userDetails.password = password
        userDetails.country = country!
        userDetails.phone = phone!
        
                     
        
        progressSpinner.isHidden = false
        submitButton.isHidden = true
        authViewModel.registerUser(user: userDetails).subscribe(onNext: { (AuthResponse) in
            print("messaages \(String(describing: AuthResponse.message))")
             print("status \(String(describing: AuthResponse.status))")
            self.progressSpinner.isHidden = true
            self.submitButton.isHidden = false
//            user.token = AuthResponse.token ?? "default value"
            if AuthResponse.status == 200 {
                let user = HelperClass.changeToObjectUser(from: userDetails)
                user.token = AuthResponse.token
                
                
                print("selftok \( self.tokens )")
                self.showSimpleAlert(title: title, message: AuthResponse.message!, identifier: "gotoVerification", action: true, user: user)
                //                self.performSegue(withIdentifier: "gotoVerification", sender: self.tokens)
            }
            else{
                print("It is here")
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
        
        
        print("tokendown \(tokens)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UserVerification, let user = sender as? User{
//
            vc.user = user
            print("userinprepare \(user)")
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
 
}


