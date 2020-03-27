//
//  UserModel.swift
//  myrootsinafrica
//
//  Created by Darot on 25/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

struct User:Encodable {
    let name:String?
    let email:String?
    let password:String?
    var country:String?
    let phone:String?
    var token:String?
}
