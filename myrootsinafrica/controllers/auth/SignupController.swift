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



class SignupController: ViewController {
    
    @IBOutlet weak var haveaccounttext: UILabel!
    
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    var token:String = String()
    
    let authViewModel = AuthViewModel(authProtocol: AuthService())
    
    var testText = ""
    @IBOutlet weak var countryCodeTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var dialCodeTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
  
     
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var signupScrollView: UIScrollView!
    
    @IBOutlet weak var countryDropDown: DropDown!
    
    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var loginLinkLabel: UILabel!
    
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
        
        
        
    }
    

    
    @objc func tapToDetectedForLogin(_ sender : UITapGestureRecognizer){
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "loginstory") as! ViewController
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
    
    
    
    //MARK: Register user
    @IBAction func registerUser(_ sender: Any) {
        
        let fieldValidation = HelperClass.validateField(textFields: firstNameTF, lastNameTF, emailTF,
                                                        passwordTF, phoneNumberTF, countryDropDown)
        
        if fieldValidation.count > 0{
            for field in fieldValidation{
                guard let placeHolder = field.key.placeholder else{
                    fatalError("Invalid fields")
                }
                showSimpleAlert(title: "Validation", message: "\(placeHolder) is empty", action: false)
            }
            return
        }
      
        
        let fullName = firstNameTF.text! + " " + lastNameTF.text!
        let email = emailTF.text
        let password = passwordTF.text
        let phone = phoneNumberTF.text
        let country = countryDropDown.text

        let user = User(name: fullName, email: email, password: password, country: country, phone: phone, token: nil)
    
        authViewModel.registerUser(user: user).subscribe(onNext: { (AuthResponse) in
            print("messaage \(String(describing: AuthResponse.message))")
            
            self.tokens = AuthResponse.token ?? "default value"
            if AuthResponse.status == 200 {
                print("selftok \( self.tokens )")
                 self.showSimpleAlert(title: "Registration", message: AuthResponse.message!, action: true)
//                self.performSegue(withIdentifier: "gotoVerification", sender: self.tokens)
            }
            else{
                self.showSimpleAlert(title: "Registration", message: AuthResponse.message!, action: false)
            }
            
        }, onError: { (Error) in
            print("Error: \(String(describing: Error.asAFError))")
            print("Errorcode: \(String(describing: Error.asAFError?.responseCode))")
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        }).disposed(by: disposeBag)
        
        
        print("tokendown \(token)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UserVerification, let tokenSent = sender as? String{
//
            vc.tokens = tokenSent
            print("tokeninprepare \(tokenSent)")
        }

    }
    
    func showSimpleAlert(title:String, message:String, action:Bool) {
        let alert = UIAlertController(title: title, message:message,preferredStyle: UIAlertController.Style.alert)

//        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
//            //Cancel Action
//        }))
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
                                        if action == true{
                                            self.performSegue(withIdentifier: "gotoVerification", sender: self.tokens)
                                        }
                                        
//                                        print("ok")
                                        
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}


