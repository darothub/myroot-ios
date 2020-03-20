//
//  DashBoardViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 19/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit


class DashBoardViewController : UIViewController{
    let backgroundImageView = UIImageView()
    @IBOutlet weak var parentScrollView: UIScrollView!
    override func viewDidLoad() {
        print("We are here dashy")
//
//        self.setBackgroundImage("dashboardBackground", contentMode: .scaleAspectFill)
        
        backgroundImageView.image = UIImage(named: "dashboardBackground")
        
//        view.insertSubview(backgroundImageView, at: 0)
//        parentScrollView.addSubview(backgroundImageView)
////        parentScrollView.sendSubviewToBack(backgroundImageView)
//        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
//        backgroundImageView.topAnchor.constraint(equalTo: parentScrollView.topAnchor).isActive = true
//        backgroundImageView.heightAnchor.constraint(equalTo: parentScrollView.heightAnchor).isActive = true
//        backgroundImageView.widthAnchor.constraint(equalTo: parentScrollView.widthAnchor).isActive = true
//        backgroundImageView.bottomAnchor.constraint(equalTo: parentScrollView.bottomAnchor).isActive = true
//        backgroundImageView.contentMode = .scaleToFill
//        view.sendSubviewToBack(parentScrollView)
    }
}
