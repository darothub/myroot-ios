//
//  VerificationResultViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 18/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class VerificationResultViewController: UIViewController {
    
    @IBOutlet weak var viewSubContainer: UIView!
    
    @IBOutlet weak var requestSuccessfulAdvice: UILabel!
    @IBOutlet weak var successAdviceLabel: UILabel!
    var user:User?
    var tree:Tree?
    override func viewDidLoad() {
        print("yeske \(String(describing: user))")
        print("Tree success \(String(describing: tree))")
        
        self.setBackgroundImage("verificationResultBackground", contentMode: .scaleToFill)
        
        viewSubContainer.setViewShadow(using: 4, color: UIColor.black.cgColor)
        viewSubContainer.layer.cornerRadius = 10
        
        if tree != nil{
            guard let newTree = tree?.new else {
                fatalError("new tree not found")
            }
            if newTree {
                //            let vowel = ["E"]
                let firstLetter = tree?.treeType?.prefix(1)
                
                switch firstLetter {
                case "E": requestSuccessfulAdvice.text = "You have successfully reserved an \(String(describing: tree!.treeType))"
                    
                default: requestSuccessfulAdvice.text = "You have successfully reserved a \(tree!.treeType ?? "tree")"
                }
            }
        }
        else if user != nil{
            let value = user!.changedPassword
            if value {
                requestSuccessfulAdvice.text = "You have successfully changed your password. Proceed to login"
            }
        }
       
        
        
        
    }
    @IBAction func exitAction(_ sender: Any) {
        if user != nil {
            self.performSegue(withIdentifier: "toLoginStory", sender: self)
        }
        else if tree != nil {
//
            self.performSegue(withIdentifier: "toDashboardScene", sender: tree)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DashBoardViewController, let tree = sender as? Tree{
            //
            vc.tree = tree
            print("tokeninprepare \(tree)")
        }
        
    }
}
