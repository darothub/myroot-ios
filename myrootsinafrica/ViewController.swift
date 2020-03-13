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
    let scrollViewElement = DScrollViewElement(height: 900, backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
        .withBackground(image: UIImage(named: "home_background")!, contentMode: .scaleAspectFit)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupScrollView()
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
        
        
    }
    @IBAction func showToast(_ sender: Any) {
        self.showToast(message: "hello", font: UIFont(name: "BalooChettan2-Regular", size: 14.0)!)
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
    
    func setupScrollView(){
        view.addScrollView(scrollview,
                           withSafeArea: .none,
                           hasStatusBarCover: false,
                           statusBarBackgroundColor: .green,
                           container: scrollViewContainer,
                           elements: [scrollViewElement])
        view.sendSubviewToBack(scrollview)
    }
}
extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75,
                                           y: self.view.frame.size.height-100,
                                           width: 150, height: 40))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 5.0, delay: 0.3, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }

