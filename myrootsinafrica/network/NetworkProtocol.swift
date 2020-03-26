//
//  NetworkProtocol.swift
//  myrootsinafrica
//
//  Created by Darot on 25/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxSwift

class URLString{
    static let registerURL = "https://fathomless-badlands-69782.herokuapp.com/api/user"
    static let verificationURL =  "https://fathomless-badlands-69782.herokuapp.com/api/auth/verify"
}

protocol NetworkProtocol {
    func registerUser(user:User) -> Observable<AuthResponse>
    func verifyUser(code:String, token:String) -> Observable<AuthResponse>
}
