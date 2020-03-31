//
//  VerificationResultViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 18/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class VerificationResultViewController: ViewController {
    
    @IBOutlet weak var viewSubContainer: UIView!
    
    @IBOutlet weak var requestSuccessfulAdvice: UILabel!
    @IBOutlet weak var successAdviceLabel: UILabel!
    var user:User?
    var tree:Tree?
    override func viewDidLoad() {
        print("yeske \(user)")
        print("Tree success \(tree)")
        
        self.setBackgroundImage("verificationResultBackground", contentMode: .scaleToFill)
        
        viewSubContainer.setViewShadow(using: 4, color: UIColor.black.cgColor)
        viewSubContainer.layer.cornerRadius = 10
        
        guard let newTree = tree?.new else {
            fatalError("new tree not found")
        }
        if newTree {
            requestSuccessfulAdvice.text = "You have successfully reserved a \(String(describing: tree?.treeType))"
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
