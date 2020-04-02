//
//  ViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 12/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet weak var worldText: UILabel!
    @IBOutlet weak var myRootHeaderLabel: UIImageView!
    @IBOutlet weak var signUpbtn: SecondaryButton!
    
    @IBOutlet weak var loginButton: PrimaryButton!
    
    @IBOutlet weak var SubParentView: UIView!
    let backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        setupScrollView()
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
        
        
    }
    @IBAction func showToast(_ sender: Any) {
        let font = UIFont(name: "BalooChettan2-Regular", size: 14.0) ?? UIFont(name: "Helvetica", size: 14.0)
        self.showToastMessage(message: "Hello", font: font!)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SignupController{
           
            vc.testText = "Arthur Dent"
        }
    }
//    
    @IBAction func unWindtoHome(unwindSegue: UIStoryboardSegue){}
}


