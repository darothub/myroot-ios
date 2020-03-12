//
//  primarybutton.swift
//  myrootsinafrica
//
//  Created by Darot on 12/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class PrimaryButton:UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setUpButton()
    }
    
    
    func setUpButton(){
        backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.862745098, blue: 0, alpha: 1)
//        backgroundColor = UIColor(named: "primaryGreen")
        layer.cornerRadius = frame.size.height/2
        setTitleColor(.white, for: .normal)
    }
}
