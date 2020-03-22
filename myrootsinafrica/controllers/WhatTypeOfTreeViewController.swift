//
//  WhatTypeOfTree.swift
//  myrootsinafrica
//
//  Created by Darot on 22/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class WhatTypeOfTreeViewController : ViewController{
    
    @IBOutlet weak var environmentalSelectorCard: UIView!
    @IBOutlet weak var fruitSelectorCard: UIView!
    @IBOutlet weak var decorativeSelectorCard: UIView!
    override func viewDidLoad() {
        print("Tree type")
        
        self.setupProgressBar(progress: 1.0)
        tapInitiation(view: decorativeSelectorCard, action: #selector(self.tapDetectedForDecorativeCard))
        tapInitiation(view: fruitSelectorCard, action: #selector(self.tapDetectedForFruitCard))
        tapInitiation(view: environmentalSelectorCard, action: #selector(self.tapDetectedForEnvironmentalCard))
     
        
    }
    
    @objc func tapDetectedForDecorativeCard(){
        
        if decorativeSelectorCard.showSelectorCard() {
            fruitSelectorCard.unSelectCard()
            environmentalSelectorCard.unSelectCard()
            
        }
    }
    
    @objc func tapDetectedForFruitCard(){
        if fruitSelectorCard.showSelectorCard(){
            decorativeSelectorCard.unSelectCard()
            environmentalSelectorCard.unSelectCard()

        }
        
    }
    
    @objc func tapDetectedForEnvironmentalCard(){
        if environmentalSelectorCard.showSelectorCard(){
            decorativeSelectorCard.unSelectCard()
            fruitSelectorCard.unSelectCard()

        }
        
    }
    
    
    func tapInitiation(view:UIView, action: Selector){
        let singleTap = UITapGestureRecognizer(target: self, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
    }
}
