//
//  setViewShadowExtension.swift
//  myrootsinafrica
//
//  Created by Darot on 18/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension UIView{
    
    func setViewShadow(using shadowRadius:Float, color:CGColor){
        self.layer.shadowColor = color
         self.layer.shadowOpacity = 1
         self.layer.shadowOffset = .zero
         self.layer.shadowRadius = CGFloat(shadowRadius)
    }

 
}
