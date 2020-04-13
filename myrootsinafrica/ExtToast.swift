//
//  ExtToast.swift
//  myrootsinafrica
//
//  Created by Darot on 13/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//


import UIKit

extension UIViewController {

func showToastMessage(message : String, font: UIFont?) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100,
                                           y: self.view.frame.size.height-100,
                                           width: 200, height: 40))
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





//    @IBAction func showToast(_ sender: Any) {
//        let font = UIFont(name: "BalooChettan2-Regular", size: 14.0) ?? UIFont(name: "Helvetica", size: 14.0)
//        self.showToastMessage(message: "Hello", font: font!)
//    }
//
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? SignupController{
//
//            vc.testText = "Arthur Dent"
//        }
//    }
////
//    @IBAction func unWindtoHome(unwindSegue: UIStoryboardSegue){}
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        navigationController?.setNavigationBarHidden(true, animated: animated)
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//    }


        //        containerView.horizontalToSuperview()
       
//        imageView.bottom(to: containerView)
//        imageView.leadingToSuperview()
//        imageView.trailingToSuperview()
        
//        setupScrollView()
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
        //set view background image
//        view.layer.contents = #imageLiteral(resourceName: "homeBackground").cgImage
//         parentViewWrapper .layer.contents = #imageLiteral(resourceName: "homeBackground").cgImage
