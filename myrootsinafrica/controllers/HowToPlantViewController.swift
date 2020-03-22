//
//  HowToPlantViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 22/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class HowToPlantViewController : ViewController{
    
    @IBOutlet weak var inpersonSelectorCard: UIView!
    @IBOutlet weak var remoteSelectorCard: UIView!
    override func viewDidLoad() {
        print("How to plant")
        
        self.setBackgroundImage("generalBackground", contentMode: .scaleToFill)
        self.setupProgressBar(progress: 0.8)
        tapInitiation(view: inpersonSelectorCard, action: #selector(self.tapDetectedForinpersonCard))
        tapInitiation(view: remoteSelectorCard, action: #selector(self.tapDetectedForRemoteCard))

    }
    
    @objc func tapDetectedForinpersonCard(){
        
        if inpersonSelectorCard.showSelectorCard() {
            remoteSelectorCard.unSelectCard()
            
        }
    }
    
    @objc func tapDetectedForRemoteCard(){
        if remoteSelectorCard.showSelectorCard() {
            inpersonSelectorCard.unSelectCard()
            
        }
        
    }
    
    func tapInitiation(view:UIView, action: Selector){
        let singleTap = UITapGestureRecognizer(target: self, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
    }
}
