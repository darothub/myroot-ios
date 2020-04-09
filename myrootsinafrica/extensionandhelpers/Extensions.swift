//
//  UnderlineTextFunc.swift
//  myrootsinafrica
//
//  Created by Darot on 15/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SpriteKit

extension UILabel{
    func underlineText(){
        if let textUnwrapped = self.text{
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underAttributedString = NSAttributedString(string: textUnwrapped, attributes: underlineAttribute)
            self.attributedText = underAttributedString
        }
    }
}

extension UIView{
    func setBottomBorderUIView(using color:CGColor){
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.8)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func showSelectorCard() -> Bool{
        self.backgroundColor = .white
        self.setViewShadow(using: 4, color: UIColor.black.cgColor)
        self.layer.cornerRadius = 5
        
        return true
    }
    
    func unSelectCard() -> Bool{
        self.backgroundColor = .clear
        self.setViewShadow(using: 0, color: UIColor.black.cgColor)
        self.layer.cornerRadius = 0
        
        return true
    }
    
    func initiateTapGesture(action:Selector?){
        let singleTap = UITapGestureRecognizer(target: self, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(singleTap)
     }
    
//    @objc func tapDetectedForProfile(){
//        print("profile setting")
//        let dashboard = DashBoardViewController(nibName: "DashBoardViewController", bundle: nil)
//        dashboard.present(dashboard, animated: false, completion: nil)
//
//    }
    
    func setViewShadow(using shadowRadius:Float, color:CGColor){
        self.layer.shadowColor = color
         self.layer.shadowOpacity = 1
         self.layer.shadowOffset = .zero
         self.layer.shadowRadius = CGFloat(shadowRadius)
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
    func setMaxLength(){
        self.addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
    }
    
    @objc private func editingChanged(sender: UITextField) {
        
        if let text = sender.text, text.count >= 1 {
            sender.text = String(text.dropLast(text.count - 1))
            return
        }
    }
}

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    var isValidPassword:Bool{
        NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9@$!%*#?&]{6,}$").evaluate(with: self)
    }
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

extension UINavigationController {

    func removeViewController(_ controller: UIViewController.Type) {
        if let viewController = viewControllers.first(where: { $0.isKind(of: controller.self) }) {
            viewController.removeFromParent()
        }
    }
}

//extension ViewController{
//    var containerView :UIView {
//        return self.createView(with: .clear)
//    }
//    var scrollView:UIView {
//        return self.createScrollView()
//        
//    }
//}


