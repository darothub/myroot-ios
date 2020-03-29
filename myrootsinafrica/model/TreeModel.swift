//
//  TreeModel.swift
//  myrootsinafrica
//
//  Created by Darot on 29/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit


struct Tree:Encodable {
    var name:String?
    var email:String?
    var picture: String?
    var treeType: String?
    var locationType: String?
    var reason: Reason?
    var occasion: String?
    var date: String?
    var country: String?
    var location: String?
    var longitude: String?
    var latitude: String?
    var message=""
    var error = false
    var new = false
}

struct Reason:Encodable {
    var isOccasion:Bool = false
    var isGift: Bool = false
}
