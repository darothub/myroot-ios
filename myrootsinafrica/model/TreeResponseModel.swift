//
//  TreeResponseModel.swift
//  myrootsinafrica
//
//  Created by Darot on 31/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
struct TreeResponse:Codable{
    let status:Int?
    let error:String?
    let message: String?
    let payload:Payloads?

    
}

// MARK: - Payload
struct Payloads: Codable {
    let countries, greenWall: [Country]
}

// MARK: - Country
struct Country: Codable {
    let locationType, id: String
    let picture: String
    let treeType: String
    let reason: Reasons
    let occassion: String?
    let country: String
    let longitude, latitude: Int?
    let userid, createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case locationType
        case id = "_id"
        case picture, treeType, reason, occassion, country, longitude, latitude, userid, createdAt, updatedAt
        case v = "__v"
    }
}

// MARK: - Reason
struct Reasons: Codable {
    let isOcassion: Bool?
    let isGift: Bool
    let isOccasion: Bool?
}

//struct TreePayload:Codable{
//    let countries:[Tree]
//    let greenWall:[Tree]
//}
//
//
//struct Countries:Codable{
//    let tree:Tree
//}
//
//struct GreenWall:Codable {
//    let tree:Tree
//}


//"locationType": "54C",
//"_id": "5e80bee5716cd9002f7c7eb3",
//"picture": "https://res.cloudinary.com/myroot/image/upload/v1575115687/c62ee4559ca391a822f0a19a039763aa_uxi2ya.png",
//"treeType": "string",
//"reason": {
//    "isOcassion": true,
//    "isGift": true
//},
//"occassion": "string",
//"country": "string",
//"longitude": null,
//"latitude": null,
//"userid": "5e7dec43400f98002fd9eeaf",
//"createdAt": "2020-03-29T15:29:41.308Z",
//"updatedAt": "2020-03-29T15:29:41.308Z",
