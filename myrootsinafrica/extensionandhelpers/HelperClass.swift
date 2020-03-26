//
//  setViewShadowExtension.swift
//  myrootsinafrica
//
//  Created by Darot on 18/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class HelperClass {
    
    static func validateField(textFields:UITextField...) -> [UITextField:Bool]{
        var result = [UITextField:Bool]()
        for field in textFields{
            guard let fieldText = field.text else{
                fatalError("\(field) is nil")
            }
            if fieldText.isEmpty {
                result[field] = false
            }
        }
        return result
    }
}
