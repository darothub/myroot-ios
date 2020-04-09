//
//  ReasonViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 20/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import M13Checkbox
import SimpleCheckbox
import UICheckbox_Swift

class ReasonViewController : UIViewController{

    
    @IBOutlet weak var climateCardView: UIView!
    @IBOutlet weak var giftCardView: UIView!
    @IBOutlet weak var jobCardView: UIView!
   
    
    var tree:Tree?
    
    @IBOutlet weak var climateCheckBox: UICheckbox!
    @IBOutlet weak var jobCheckBox: UICheckbox!
    @IBOutlet weak var giftCheckBox: UICheckbox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Reason now")
        print("tree \(String(describing: tree))")
        let color = #colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1) as CGColor
        climateCardView.setBottomBorderUIView(using: color)
        jobCardView.setBottomBorderUIView(using: color)
        giftCardView.setBottomBorderUIView(using: color)
        
        self.setupProgressBar(progress: 0.4)

        
        self.addCustomBackButton(action: #selector(self.gotoScene))

    }
    @IBAction func tapToMoveToNext(_ sender: Any) {
        let reason = getSelectedReasonSelection()
          print("reason \(reason)")
        
       
    }
    
    @objc override func gotoScene() {
        self.moveToDestination(with: "whereToPlantScene")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    func getSelectedReasonSelection() -> Reason{
        let gift = giftCheckBox.isSelected
        let climate = climateCheckBox.isSelected
        let job = jobCheckBox.isSelected
        var reason = Reason(isOccasion: false, isGift: false)

        print("selected \(gift)")
        let that = (gift, climate, job)
        
        switch (gift, climate, job) {
        case (!gift, !climate, !job): do {
            reason.isGift = true
            tree?.reason = reason
            
            print("Hey there1 \(that)")
//            self.performSegue(withIdentifier: "toTypeOfOccasion", sender: tree)
        }
            break
        case (!gift, climate, job) : do {
            reason.isGift = true
            tree?.reason = reason
            print("Hey there2 \(that)")
            
            //            self.performSegue(withIdentifier: "toTypeOfOccasion", sender: tree)
            }
        case (gift, climate, job):self.showToastMessage(message: "Kindly pick a reason", font: UIFont(name: "BalooChetan2-Regular", size: 12.0))
       
        default:self.showToastMessage(message: "Kindly pick a reason", font: UIFont(name: "BalooChetan2-Regular", size: 12.0))

        }
//        tree?.reason = reason
//        self.performSegue(withIdentifier: "toTypeOfOccasion", sender: tree)

//        if !(gift || climate || job){
//
//            self.showToastMessage(message: "Kindly pick a reason", font: UIFont(name: "BalooChetan2-Regular", size: 12.0))
//
//        }
//        else if giftCheckBox.isSelected {
//            reason.isGift = true
//            tree?.reason = reason
//            self.performSegue(withIdentifier: "toTypeOfOccasion", sender: tree)
//        }
//        else{
//            tree?.reason = reason
//            self.performSegue(withIdentifier: "toTypeOfOccasion", sender: tree)
//        }
        
        return reason
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TypeOfOccasionViewController, let tree = sender as? Tree{
            //
            vc.tree = tree
            print("treeinprepare \(tree)")
        }
        
    }
}
