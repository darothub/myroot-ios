//
//  DashBoardViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 19/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SpriteKit


class DashBoardViewController : UIViewController{
    let backgroundImageView = UIImageView()
    @IBOutlet weak var parentScrollView: UIScrollView!
    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var topBoardView: UIView!
    @IBOutlet weak var bottomBoardView: UIView!
    var tokens = ""
    override func viewDidLoad() {
        
        print("We are here dashy")
        print("userToken \(tokens)")
//
//        self.setBackgroundImage("dashboardBackground", contentMode: .scaleAspectFill)
        
        backgroundImageView.image = UIImage(named: "dashboardBackground")
        
        circleView.layer.cornerRadius = circleView.frame.width/2
        topBoardView.layer.cornerRadius = 25
        bottomBoardView.layer.cornerRadius = 25
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        circleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDetectedForProfile(_ :))))
    }
    

    func initiateTapGestures(view:UIView, action:Selector?){
        let singleTap = UITapGestureRecognizer(target: view, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
     }
    @objc func tapDetectedForProfile(_ sender : UITapGestureRecognizer){
        print("profile setting")
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "profilestory") as! ViewController
//        let profile = ProfileViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    

}
