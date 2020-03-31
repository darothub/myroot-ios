//
//  TreeModel.swift
//  myrootsinafrica
//
//  Created by Darot on 29/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit


struct Tree:Codable {
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
    var longitude: String?=""
    var latitude: String?=""
    var userid:String?
    var token:String?
    var new:Bool? = false
}

struct Reason:Codable {
    var isOccasion:Bool = false
    var isGift: Bool = false
    
//    private enum CodingKeys: String, CodingKey {
//        case isOccasion = "is0cassion"
//
//    }

}
