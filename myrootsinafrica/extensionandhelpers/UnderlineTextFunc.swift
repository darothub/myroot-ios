//
//  UnderlineTextFunc.swift
//  myrootsinafrica
//
//  Created by Darot on 15/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension UILabel{
    func underlineText(){
        if let textUnwrapped = self.text{
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underAttributedString = NSAttributedString(string: textUnwrapped, attributes: underlineAttribute)
            self.attributedText = underAttributedString
        }
    }
}

extension UITextField{
    func setBottomBorder(){
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.8)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func addRightImageToTextField(using image:UIImage){
        let rightImageView = UIImageView()
        
        rightImageView.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        rightImageView.widthAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        
        rightImageView.image = image
        self.rightView = rightImageView
        self.rightViewMode = .always
        self.initiateTapGesture(imageView: rightImageView)
    }
    
    func initiateTapGesture(imageView : UIImageView){
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.tapDetected))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(singleTap)
     }
    
    @objc func tapDetected(){
        print("Yup")
        self.isSecureTextEntry = !self.isSecureTextEntry
        if self.isSecureTextEntry {
            guard let passwordImage = UIImage(named: "eyeiconclose") else{
                fatalError("Password image not found")
            }
            self.addRightImageToTextField(using: passwordImage)
        }else{
            guard let passwordImage = UIImage(named: "eyeiconopen") else{
                fatalError("Password image not found")
            }
            self.addRightImageToTextField(using: passwordImage)
        }
        
    }
}






