//
//  TypeOfOccasion.swift
//  myrootsinafrica
//
//  Created by Darot on 22/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit


class TypeOfOccasionViewController : ViewController{
    @IBOutlet weak var birthdayCard: UIView!
    @IBOutlet weak var anniversaryCard: UIView!
    @IBOutlet weak var holidayCard: UIView!
    @IBOutlet weak var otherCard: UIView!
    
    var tree:Tree?
    override func viewDidLoad() {
        print("Type of occasion")
        print("tree\(tree)")
        
        self.setupProgressBar(progress: 0.6)
        
            tapInitiation(view: birthdayCard, action: #selector(self.tapDetectedForBirthday))
            tapInitiation(view: anniversaryCard, action: #selector(self.tapDetectedForAnniversary))
            tapInitiation(view: holidayCard, action: #selector(self.tapDetectedForHoliday))
            tapInitiation(view: otherCard, action: #selector(self.tapDetectedForOther))
   
    }
    
    @objc func tapDetectedForBirthday(){
         
        if birthdayCard.showSelectorCard() {
            anniversaryCard.unSelectCard()
            holidayCard.unSelectCard()
            otherCard.unSelectCard()
            
        }
     }
    
    @objc func tapDetectedForAnniversary(){
        if anniversaryCard.showSelectorCard(){
            holidayCard.unSelectCard()
            otherCard.unSelectCard()
            birthdayCard.unSelectCard()
        }
         
    }
    
    @objc func tapDetectedForHoliday(){
        if holidayCard.showSelectorCard(){
            otherCard.unSelectCard()
            birthdayCard.unSelectCard()
            anniversaryCard.unSelectCard()
        }
     
    }
    
    @objc func tapDetectedForOther(){
        if otherCard.showSelectorCard(){
            birthdayCard.unSelectCard()
            anniversaryCard.unSelectCard()
            holidayCard.unSelectCard()
        }
    }
    
    func tapInitiation(view:UIView, action: Selector){
        let singleTap = UITapGestureRecognizer(target: self, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
    }
}
