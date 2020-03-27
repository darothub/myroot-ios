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
    
    @IBOutlet weak var successAdviceLabel: UILabel!
    var user:User?
    override func viewDidLoad() {
        print("yeske \(user)")
        
        self.setBackgroundImage("verificationResultBackground", contentMode: .scaleToFill)
        
        viewSubContainer.setViewShadow(using: 4, color: UIColor.black.cgColor)
        viewSubContainer.layer.cornerRadius = 10
    }
    @IBAction func exitAction(_ sender: Any) {
        if user != nil {
            self.performSegue(withIdentifier: "toLoginStory", sender: self)
        }
        
    }
}
