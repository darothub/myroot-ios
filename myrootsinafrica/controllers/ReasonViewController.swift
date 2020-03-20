//
//  ReasonViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 20/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import M13Checkbox
import SimpleCheckbox

class ReasonViewController : ViewController{

    
    @IBOutlet weak var climateCardView: UIView!
    @IBOutlet weak var giftCardView: UIView!
    @IBOutlet weak var jobCardView: UIView!
   
    var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Reason now")
        let color = #colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1) as CGColor
        climateCardView.setBottomBorderUIView(using: color)
        jobCardView.setBottomBorderUIView(using: color)
        giftCardView.setBottomBorderUIView(using: color)
        

        
//        
//        let checkbox = M13Checkbox(frame: CGRect(x: 1.4, y: 1.4, width: 0.0, height: 0.0))
        let checkbox = Checkbox(frame: CGRect(x: 50, y: 50, width: 25, height: 25))
//        checkbox.setCheckState(.checked, animated: false)
//        // The background color of the veiw.
//        checkbox.backgroundColor = .white
//        // The tint color when in the selected state.
//        checkbox.tintColor = .yellow
//        // The line width of the box.
//        checkbox.boxLineWidth = 2.0
//        // The corner radius of the box if it is a square.
//        checkbox.cornerRadius = 4.0
//        // Whether the box is a square, or circle.
//        checkbox.boxType = .square
//        // Whether or not to hide the box.
//        checkbox.hideBox = false
//        checkbox.borderStyle = .circle
//        checkbox.borderStyle = .square
//        checkbox.checkmarkStyle = .tick
//        checkbox.checkmarkColor = .blue
//        
////        view.addSubview(checkbox)
//        
//        checkbox.translatesAutoresizingMaskIntoConstraints = false
//        cardView.addSubview(checkbox)
//        checkbox.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
//        checkbox.widthAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
//        checkbox.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16).isActive = true
//        checkbox.rightAnchor.constraint(equalToSystemSpacingAfter: cardView.rightAnchor, multiplier: 0).isActive = true
//        checkbox.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
//        checkbox.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        

        
        
    }
}
