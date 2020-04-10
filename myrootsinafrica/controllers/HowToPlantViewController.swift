//
//  HowToPlantViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 22/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class HowToPlantViewController : UIViewController{
    
    @IBOutlet weak var inpersonSelectorCard: UIView!
    @IBOutlet weak var remoteSelectorCard: UIView!
    var tree:Tree?
    var location = ""
    let inperson = "inperson"
    let remote = "remote"
    override func viewDidLoad() {
        print("How to plant")
        print("tree\(String(describing: tree))")
        
        self.setBackgroundImage("generalBackground", contentMode: .scaleToFill)
        self.setupProgressBar(progress: 0.8)
        tapInitiation(view: inpersonSelectorCard, action: #selector(self.tapDetectedForinpersonCard))
        tapInitiation(view: remoteSelectorCard, action: #selector(self.tapDetectedForRemoteCard))
        
        self.addCustomBackButton(action: #selector(self.gotoScene))
        self.transparentNavBar()

    }
    
    @objc override func gotoScene() {
        self.moveToDestination(with: "occasionScene")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func tapDetectedForinpersonCard(){
        
        if inpersonSelectorCard.showSelectorCard() {
            remoteSelectorCard.unSelectCard()
            location = inperson
        }
    }
    
    @objc func tapDetectedForRemoteCard(){
        if remoteSelectorCard.showSelectorCard() {
            inpersonSelectorCard.unSelectCard()
            location = remote
        }
        
    }
    
    func tapInitiation(view:UIView, action: Selector){
        let singleTap = UITapGestureRecognizer(target: self, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
    }
    @IBAction func tapToMoveToNext(_ sender: Any) {
        print("before \(String(describing: tree))")
        tree?.location = location
        if location == ""{
             self.showToastMessage(message: "Kindly pick an option", font: UIFont(name: "BalooChetan2-Regular", size: 12.0))
            return
        }
        self.performSegue(withIdentifier: "toWhatTypeOfTreeScene", sender: tree)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let vc = segue.destination as? WhatTypeOfTreeViewController, let tree = sender as? Tree{
             //
             vc.tree = tree
             print("treeinprepare \(tree)")
         }
         
     }
}
