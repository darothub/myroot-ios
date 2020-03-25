//
//  CardSelectionHelper.swift
//  myrootsinafrica
//
//  Created by Darot on 22/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class CardSelectionHelper{
    var delegate:TestProtocolDelegate?
    func tapInitiation(){
        delegate?.testing()
//        let singleTap = UITapGestureRecognizer(target: self, action: action)
//        view.isUserInteractionEnabled = true
//        view.addGestureRecognizer(singleTap)
    }

}

class AnotherClass{
    var newInst = CardSelectionHelper()
    init(){
        newInst.delegate = self as! TestProtocolDelegate
    }
    func wtsup(){
        newInst.tapInitiation()
    }
}

protocol TestProtocolDelegate {
    func testing()
}


extension AnotherClass : TestProtocolDelegate{
    func testing() {
        print("Testing")
    }
    
    
}

