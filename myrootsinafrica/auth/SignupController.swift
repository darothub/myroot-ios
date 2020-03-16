//
//  SignupController.swift
//  myrootsinafrica
//
//  Created by Darot on 15/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit


class SignupController: UIViewController {
    
    @IBOutlet weak var haveaccounttext: UILabel!
    
    override func viewDidLoad() {
        print("Yaay signup")
        
        let languageList = Locale.isoLanguageCodes.compactMap { Locale.current.localizedString(forLanguageCode: $0) }
        let countryList = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
        
        print(languageList, countryList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        haveaccounttext.underlineText()
        countryAndCodes()
        
    }
    
    func countryAndCodes(){
        guard let cacListData = CountryAndCode.countryAndCodeString().data(using: .utf8) else { return }
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
        do{
            let countries = try countryAndCodeDecoder.decode([countryData].self, from: cacListData)
            for country in countries {
                print(country.name)
                print(country.dialCode)
            }
        }catch{
            "Failed to decode country and code \(error.localizedDescription)"
        }
    }
    
    
}
