//
//  responsemodel.swift
//  myrootsinafrica
//
//  Created by Darot on 25/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
struct AuthResponse:Codable{
    let status:Int?
    let error:String?
    let message: String?
    let payload: Payload?
    var token:String?
    
}

struct Payload:Codable{
    let isVerified:Bool?
    let _id:String?
    let name:String?
    let email:String?
    let password:String?
    let country:String?
    let phone:String?
    let userId:String?
    let type:String?
    let description:String?
    let longitude:String?
    let latitude:String?
    let picture:String?
}


struct AltResponse:Codable{
    let status:Int?
    let message: String?
}


