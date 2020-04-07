//
//  ViewGenerators.swift
//  myrootsinafrica
//
//  Created by Darot on 07/04/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension UIViewController{
    var contentViewSize :CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func createButton(with text:String, and color:UIColor, action:Selector)->UIButton{
        let button:UIButton = {
            let button = UIButton()
            button.height(55.0)
            button.backgroundColor = color
            button.setTitle(text, for: .normal)
            button.layer.cornerRadius = 27
            button.addTarget(self, action: action, for: .touchUpInside)
            return button
        }()
        return button
    }
    
    func createUIlabel(with text:String, and size:CGFloat, color:UIColor=#colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1))-> UILabel{
        
        let headerTexts:UILabel = {
            let label = UILabel()
            label.text = text
            label.font = UIFont(name: "BalooChettan2-Regular", size: size) ?? UIFont(name: "Helvetica", size: size)
            label.textColor = color
            label.numberOfLines = 0
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            return label
         }()
        return headerTexts
    }
    
    func createUIlabelBold(with text:String, and size:CGFloat, color:UIColor=#colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1))-> UILabel{
        
        let headerTexts:UILabel = {
            let label = UILabel()
            label.text = text
            label.font = UIFont(name: "BalooChettan2-Regular", size: size) ?? UIFont(name: "Helvetica", size: size)
            label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
            label.textColor = color
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
         }()
        return headerTexts
    }
    
    func createScrollView() -> UIView{
        let scrollView:UIView = {
            let view = UIScrollView(frame: .zero)
            view.backgroundColor = .clear
            view.contentSize = contentViewSize
            view.autoresizingMask = .flexibleHeight
            view.bounces = true
            view.showsVerticalScrollIndicator = false
            view.frame = self.view.bounds
            return view
        }()
        return scrollView
    }

    func createImageView(with size:CGSize=CGSize(width: 0, height: 0)) -> UIImageView{
        let view:UIImageView = {
            let view = UIImageView()
            view.image = #imageLiteral(resourceName: "my_roots_logo")
            view.frame.size = size
            return view
        }()
        return view
    }
    
    func createView(with color:UIColor)->UIView{
         let view:UIView = {
            let view = UIView()
            view.backgroundColor = color
            view.frame.size = self.contentViewSize
            return view
        }()
        return view
    }
    
    func createCustomView(with color:UIColor, height:CGFloat, width:CGFloat)->UIView{
        let view:UIView = {
            let view = UIView()
            view.backgroundColor = color
            view.height(height)
            view.width(width)
            return view
        }()
        return view
    }
    
    func createUITextField(with placeholder:String, height:CGFloat, type:UIKeyboardType) -> UITextField{
        let view:UITextField = {
            let view = UITextField()
            view.isUserInteractionEnabled = true
            view.placeholder = placeholder
            view.height(height)
            view.keyboardType = type
            view.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            view.borderStyle = UITextField.BorderStyle.none
            view.autocapitalizationType = .none
            return view
        }()
        return view
    }
    
    func setleftAnchorToContainerView(parent: UIView, views:UIView...){
        for view in views {
            view.left(to: parent, offset: 20, isActive: true)
        }
    }
    
    func customAddToSubView(parent: UIView, views:UIView...){
        for view in views {
            parent.addSubview(view)
        }
    }
    
    func setToEqualLeadingAndTrailing(parent:UIView, leading:CGFloat, trailing:CGFloat, views:UIView...){
        for view in views {
            view.right(to: parent, offset: trailing, isActive: true)
            view.left(to: parent, offset: leading, isActive: true)
        }
    }
  
    func createUIActivityIndicatorView() -> UIActivityIndicatorView  {
        let view:UIActivityIndicatorView = {
            let view = UIActivityIndicatorView()
            view.isUserInteractionEnabled = true
            view.style = .large
            view.color = #colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1)
            view.startAnimating()
            view.isHidden = true
            return view
        }()
        return view
    }
    
    func moveToDestination(with identifier:String){
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: identifier) as! ViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
