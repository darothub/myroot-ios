//
//  UserModel.swift
//  myrootsinafrica
//
//  Created by Darot on 01/04/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Unrealm
import RealmSwift

class User:Object, Codable {
    @objc dynamic var name:String?
    @objc dynamic var email:String?
    @objc dynamic var password:String?
    @objc dynamic var country:String?
    @objc dynamic var phone:String?
    @objc dynamic var token:String?
    @objc dynamic var changedPassword = false
    @objc dynamic var loggedIn = false
    

  
    override static func primaryKey() -> String? {
        return "email"
    }
}
