//
//  ViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 12/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    

    @IBOutlet weak var worldText: UILabel!
    @IBOutlet weak var myRootHeaderLabel: UIImageView!
    @IBOutlet weak var signUpbtn: SecondaryButton!
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loginButton: PrimaryButton!
    
    let backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()


       
        
    }
    @IBAction func showToast(_ sender: Any) {
        let font = UIFont(name: "BalooChettan2-Regular", size: 14.0) ?? UIFont(name: "Helvetica", size: 14.0)
        self.showToastMessage(message: "Hello", font: font!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.transparentNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //set view background image
        containerView.layer.contents = #imageLiteral(resourceName: "home_background").cgImage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SignupController{
           
            vc.testText = "Arthur Dent"
        }
    }
//    
    @IBAction func unWindtoHome(unwindSegue: UIStoryboardSegue){}
}


