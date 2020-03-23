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
    override func viewDidLoad() {
        
        print("We are here dashy")
//
//        self.setBackgroundImage("dashboardBackground", contentMode: .scaleAspectFill)
        
        backgroundImageView.image = UIImage(named: "dashboardBackground")
        
        circleView.layer.cornerRadius = circleView.frame.width/2
        topBoardView.layer.cornerRadius = 25
        bottomBoardView.layer.cornerRadius = 25
        
//        view.insertSubview(backgroundImageView, at: 0)
//        parentScrollView.addSubview(backgroundImageView)
////        parentScrollView.sendSubviewToBack(backgroundImgeView)
//        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
//        backgroundImageView.topAnchor.constraint(equalTo: parentScrollView.topAnchor).isActive = true
//        backgroundImageView.heightAnchor.constraint(equalTo: parentScrollView.heightAnchor).isActive = true
//        backgroundImageView.widthAnchor.constraint(equalTo: parentScrollView.widthAnchor).isActive = true
//        backgroundImageView.bottomAnchor.constraint(equalTo: parentScrollView.bottomAnchor).isActive = true
//        backgroundImageView.contentMode = .scaleToFill
//        view.sendSubviewToBack(parentScrollView)
//        circleView.initiateTapGesture(action: #selector(circleView.tapDetectedForProfile))
//        initiateTapGestures(view: circleView, action: #selector(view.tapDetectedForProfile))
        
        circleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDetectedForProfile(_ :))))
    }
    

    func initiateTapGestures(view:UIView, action:Selector?){
        let singleTap = UITapGestureRecognizer(target: view, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
     }
    @objc func tapDetectedForProfile(_ sender : UITapGestureRecognizer){
        print("profile setting")
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "story") as! ViewController
//        let profile = ProfileViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    

}
