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
    static let BaseURL = "https://fathomless-badlands-69782.herokuapp.com/api/"
    static let registerURL = "\(BaseURL)user"
    static let verificationURL =  "\(BaseURL)auth/verify"
    static let loginURL =  "\(BaseURL)user/login"
    static let treeReservationURL = "\(BaseURL)tree"
    static let userTreeURL = "\(BaseURL)tree/user/tree"
    static let forgotPasswordURL = "\(BaseURL)auth/forgot-password"
    static let resetPasswordURL = "\(BaseURL)auth/reset-password"
}

protocol NetworkProtocol {
    func registerUser(user:UserDetails) -> Observable<AuthResponse>
    func verifyUser(code:String, token:String) -> Observable<AuthResponse>
    func userLogin(email:String, password:String) -> Observable<AuthResponse>
    func reserveTree(tree:Tree, token:String) -> Observable<AuthResponse>
    func getUserTrees(token:String) -> Observable<TreeResponse>
    func getUserTrees(token:String, completionHandler: @escaping (Result<TreeResponse, NetworkError>) -> Void)
//    func getUserTrees(token:String, completionHandler: @escaping (Result<Observable<TreeResponse>, NetworkError>) -> Void)
    func forgotPassword(email:String)-> Observable<AuthResponse>
    func resetPassword(email:String, code:String, password:String) -> Observable<AuthResponse>

//    func resendVerificationCode(user:User) -> Observable<AuthResponse>
}


enum NetworkError:Error{
    case networkError
}
