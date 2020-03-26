//
//  responsemodel.swift
//  myrootsinafrica
//
//  Created by Darot on 25/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
struct AuthResponse:Decodable{
    let status:Int?
    let error:String?
    let message: String?
    let payload: Payload?
    let token:String?
    
    
}

struct Payload:Decodable{
    let isVerified:Bool?
    let _id:String?
    let fullName:String?
    let email:String?
    let password:String?
    let country:String?
    let phone:String?
}


