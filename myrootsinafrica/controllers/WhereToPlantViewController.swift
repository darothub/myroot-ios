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
    var selectedLocation = ""
    var user:User?
    override func viewDidLoad() {
        print("choose location")
        print("user \(user)")
        
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
    
    @objc func tapDetected(){
        
        if selectorCardForCountry.showSelectorCard() {
            fiftyFourCountriesDropDown.isEnabled = true
            selectorCardForGGW.unSelectCard()
            selectedLocation = "54C"
        }
        

    }
    
    @objc func tapDetectedForGGWCard(){
        if selectorCardForGGW.showSelectorCard() {
            fiftyFourCountriesDropDown.isEnabled = false
            selectorCardForCountry.unSelectCard()
            selectedLocation = "GGW"
            
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        print(selectedLocation)
        if selectedLocation == "" {
            self.showToastMessage(message: "Kindly pick a location", font: UIFont(name: "BalooChetan2-Regular", size: 12.0))
        }
        else{
            let tree = Tree(name: user?.name, email: user?.email, picture: nil, treeType: nil, locationType: nil, reason: nil, occasion: nil, date: nil, country: nil, location: selectedLocation, longitude: nil, latitude: nil, message: "")
            self.performSegue(withIdentifier: "toReasonScene", sender: tree)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ReasonViewController, let tree = sender as? Tree{
            //
            vc.tree = tree
            print("treeinprepare \(tree)")
        }
        
    }
}
