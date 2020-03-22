//
//  WhereToPlantViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 20/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import iOSDropDown

class WhereToPlantViewController:ViewController{
    
    @IBOutlet weak var countryIcon: UIImageView!
    
    @IBOutlet weak var selectorCardForGGW: UIView!
    @IBOutlet weak var selectorCardForCountry: UIView!
    
    @IBOutlet weak var fiftyFourCountriesDropDown: DropDown!
    var fiftyFourCountries:[String] = []
    override func viewDidLoad() {
        
        self.setupProgressBar(progress: 0.2)
        

        fiftyFourCountriesDropDown.isEnabled = false
       
        fiftyFourCountries = ["Nigeria", "Zambia", "Ethiopia", "Ghana", "Egypt", "Senegal", "Sierra Leone", "South Africa"].sorted()
        
        fiftyFourCountriesDropDown.optionArray = fiftyFourCountries
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.tapDetected))
        selectorCardForCountry.isUserInteractionEnabled = true
        selectorCardForCountry.addGestureRecognizer(singleTap)
        
        let singleTapForGGW = UITapGestureRecognizer(target: self, action: #selector(self.tapDetectedForGGWCard))
        selectorCardForGGW.isUserInteractionEnabled = true
        selectorCardForGGW.addGestureRecognizer(singleTapForGGW)
        
    }
    
    @objc func tapDetected()-> Bool{
        
        if showSelectorCard(view: selectorCardForCountry) {
            fiftyFourCountriesDropDown.isEnabled = true
            unSelectCard(view: selectorCardForGGW)
            return true
        }else{
           return false
        }

        

    }
    
    @objc func tapDetectedForGGWCard()-> Bool{
        if showSelectorCard(view: selectorCardForGGW) {
            fiftyFourCountriesDropDown.isEnabled = false
            unSelectCard(view: selectorCardForCountry)
            return true
        }else{
            return false
        }
    }
    
    func showSelectorCard(view:UIView) -> Bool{
        view.backgroundColor = .white
        view.setViewShadow(using: 4, color: UIColor.black.cgColor)
        view.layer.cornerRadius = 5
        
        return true
    }
    
    func unSelectCard(view:UIView) -> Bool{
        view.backgroundColor = .clear
        view.setViewShadow(using: 0, color: UIColor.black.cgColor)
        view.layer.cornerRadius = 0
        
        return true
    }
}
