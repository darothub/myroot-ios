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
    let scrollview = DScrollView()
    let scrollViewContainer = DScrollViewContainer(axis: .vertical, spacing: 10)
    let scrollViewElement = DScrollViewElement(height: 900, backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
        .withBackground(image: UIImage(named: "home_background")!, contentMode: .scaleAspectFill)
    
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
    
//
//    func setBackground(){
//                view.addSubview(backgroundImageView)
//                backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
//                backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//                backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//                backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//                backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//                backgroundImageView.image = UIImage(named: "home_background")
//                view.sendSubviewToBack(backgroundImageView)
//    }
    
    func setupScrollView(){
        view.addScrollView(scrollview,
                           withSafeArea: .none,
                           hasStatusBarCover: false,
                           statusBarBackgroundColor: .green,
                           container: scrollViewContainer,
                           elements: [scrollViewElement])
        scrollViewElement.addSubview(SubParentView)
        view.sendSubviewToBack(scrollview)
    }
}


