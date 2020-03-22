//
//  WhiteButton.swift
//  myrootsinafrica
//
//  Created by Darot on 22/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit


class WhiteButton:UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setUpButton()
    }
    
    
    func setUpButton(){
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        backgroundColor = UIColor(named: "primaryGreen")
        layer.cornerRadius = frame.size.height/2
        let color = #colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1)
        setTitleColor(color, for: .normal)
    }
}

