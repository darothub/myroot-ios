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
    static let loginURL =  "https://fathomless-badlands-69782.herokuapp.com/api/user/login"
    static let treeReservationURL = "https://fathomless-badlands-69782.herokuapp.com/api/tree"
    static let userTreeURL = "https://fathomless-badlands-69782.herokuapp.com/api/tree/user/tree"
}

protocol NetworkProtocol {
    func registerUser(user:User) -> Observable<AuthResponse>
    func verifyUser(code:String, token:String) -> Observable<AuthResponse>
    func userLogin(email:String, password:String) -> Observable<AuthResponse>
    func reserveTree(tree:Tree, token:String) -> Observable<AuthResponse>
    func getUserTrees(token:String) -> Observable<TreeResponse> 

//    func resendVerificationCode(user:User) -> Observable<AuthResponse>
}
