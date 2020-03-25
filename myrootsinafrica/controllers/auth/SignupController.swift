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


class SignupController: ViewController {
    
    @IBOutlet weak var haveaccounttext: UILabel!
    
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    
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
    
    override func viewDidLoad() {
        print("Yaay signup")
//        setScrollViewBackground()
        

        firstNameTF.placeholder = testText
        
        setTextFieldBottomBorder()
        dialCodeTF.isUserInteractionEnabled = false
        
        guard let passwordImage = UIImage(named: "eyeiconopen") else{
            fatalError("Password image not found")
        }
        addRightImageToTextField(with: passwordTF, using: passwordImage)
        
        self.setupProgressBar(progress: 0.5)

        self.setBackgroundImage("signupBackground", contentMode: .scaleToFill)

        let countryAndCodeDict = countryAndCodes()
            var countryList = [String]()
            for key in countryAndCodeDict.keys{
                countryList.append(key)
            }
        countryDropDown.optionArray = countryList.sorted()
       countryDropDown.didSelect{(selectedText , index ,id) in
       self.dialCodeTF.text = countryAndCodeDict[selectedText]
       }
        
        loginLinkLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToDetectedForLogin(_:))))
        
        
        
        
    }
    
    @objc func tapToDetectedForLogin(_ sender : UITapGestureRecognizer){
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "loginstory") as! ViewController
        //        let profile = ProfileViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
                  
    }
    
    
    func setScrollViewBackground(){
        guard let image = UIImage(named: "signupBackground") else {
            fatalError("Could not load background")
        }
        signupScrollView.withBackground(image: image)
//        view.sendSubviewToBack(signupScrollView)
    }


    
    override func viewWillAppear(_ animated: Bool) {
        haveaccounttext.underlineText()
        
        countryAndCodes()
        
    }
    
    
    
    func countryAndCodes() -> [String:String]{
        guard let cacListData = CountryAndCode.countryAndCodeString().data(using: .utf8) else { return ["error": "Value for country not found"] }
        struct countryData:Codable{
            let name:String
            let dialCode:String
            let code:String
            
            private enum CodingKeys:String, CodingKey{
                case name
                case dialCode = "dial_code"
                case code
            }
        }
        
        let countryAndCodeDecoder = JSONDecoder()
        var returnList = [String:String]()
        do{
            let countries = try countryAndCodeDecoder.decode([countryData].self, from: cacListData)
            for country in countries {
//                print(country.name)
                returnList[country.name] = country.dialCode
//                print(returnList)
            }
        }catch{
            "Failed to decode country and code \(error.localizedDescription)"
        }
        return returnList
    }
    
    func addRightImageToTextField(with textField:UITextField, using image:UIImage){
        let rightImageView = UIImageView()
        
        rightImageView.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        rightImageView.widthAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        
        rightImageView.image = image
        textField.rightView = rightImageView
        textField.rightViewMode = .always
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        rightImageView.isUserInteractionEnabled = true
        rightImageView.addGestureRecognizer(singleTap)
        
    }
    
    @objc func tapDetected(){
        print("Yup")
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
        if passwordTF.isSecureTextEntry {
            guard let passwordImage = UIImage(named: "eyeiconclose") else{
                fatalError("Password image not found")
            }
            addRightImageToTextField(with: passwordTF, using: passwordImage)
        }else{
            guard let passwordImage = UIImage(named: "eyeiconopen") else{
                fatalError("Password image not found")
            }
            addRightImageToTextField(with: passwordTF, using: passwordImage)
        }
        
    }
    
    func setTextFieldBottomBorder(){
        dialCodeTF.setBottomBorder()
        phoneNumberTF.setBottomBorder()
        passwordTF.setBottomBorder()
        emailTF.setBottomBorder()
        lastNameTF.setBottomBorder()
        firstNameTF.setBottomBorder()
        countryDropDown.setBottomBorder()
    }
    
    
    
    @IBAction func registerUser(_ sender: Any) {
        
        let url = "https://fathomless-badlands-69782.herokuapp.com/api/user"
        let fullName = firstNameTF.text! + " " + lastNameTF.text!
        let email = emailTF.text
        let password = passwordTF.text
        let phone = phoneNumberTF.text
        let country = countryDropDown.text
//        countryDropDown.didSelect{(selectedText , index ,id) in
//            country = selectedText
//
//        }
        let user = User(name: fullName, email: email, password: password, country: country, phone: phone, token: nil)
        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of:AuthResponse.self){response in
            
            response.map { (AuthResponse) in
                print("messaage \(String(describing: AuthResponse.message))")
            }
            
            print("user: \(user)")
            print("response \(String(describing: response))")
        }
    }
    
    
}


