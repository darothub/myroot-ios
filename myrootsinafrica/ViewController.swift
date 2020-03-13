//
//  ViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 12/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let backgroundImageView = UIImageView()
    let scrollview = DScrollView()
    let scrollViewContainer = DScrollViewContainer(axis: .vertical, spacing: 10)
    let scrollViewElement = DScrollViewElement(height: 900, backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        .withBackground(image: UIImage(named: "home_background")!, contentMode: .scaleAspectFit)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        setBackground()
        
        view.addScrollView(scrollview,
                           withSafeArea: .none,
                           hasStatusBarCover: false,
                           statusBarBackgroundColor: .green,
                           container: scrollViewContainer,
                           elements: [scrollViewElement])
        view.sendSubviewToBack(scrollview)
    }

    
    func setBackground(){
                view.addSubview(backgroundImageView)
                backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
                backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                backgroundImageView.image = UIImage(named: "home_background")
                view.sendSubviewToBack(backgroundImageView)
    }
}

