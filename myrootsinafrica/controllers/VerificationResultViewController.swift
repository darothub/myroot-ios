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
    override func viewDidLoad() {
        print("yeske")
        
        self.setBackgroundImage("verificationResultBackground", contentMode: .scaleToFill)
        
        viewSubContainer.setViewShadow(using: 4, color: UIColor.black.cgColor)
        viewSubContainer.layer.cornerRadius = 10
    }
}
