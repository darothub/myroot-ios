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
    let userId:String?=nil
    let type:String?=nil
    let description:String?=nil
    let longitude:String?=nil
    let latitude:String?=nil
    let picture:String?=nil
}


struct AltResponse:Codable{
    let status:Int?
    let message: String?
}


