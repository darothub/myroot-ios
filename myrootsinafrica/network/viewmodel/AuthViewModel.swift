//
//  AuthRepository.swift
//  myrootsinafrica
//
//  Created by Darot on 25/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxSwift

class AuthViewModel{
    let authProtocol:NetworkProtocol
    init(authProtocol:NetworkProtocol){
        self.authProtocol = authProtocol
    }
    func registerUser(user:UserDetails) -> Observable<AuthResponse> {
        return authProtocol.registerUser(user:user)
    }
    
    func verifyUser(code:String, token:String) -> Observable<AuthResponse>{
        return authProtocol.verifyUser(code:code, token:token)
    }
    
    func userLogin(email:String, password:String) -> Observable<AuthResponse>{
         return authProtocol.userLogin(email:email, password:password)
     }
    func reserveTree(tree:Tree, token:String)->Observable<AuthResponse> {
        return authProtocol.reserveTree(tree: tree, token: token)
    }
    
    func getUserTrees(token:String)->Observable<TreeResponse>{
        return authProtocol.getUserTrees(token: token)
    }
    
    func forgotPassword(email:String)->Observable<AuthResponse>{
        return authProtocol.forgotPassword(email: email)
    }
    
    func resetPassword(email:String, code:String, password:String)->Observable<AuthResponse>{
        return authProtocol.resetPassword(email: email, code: code, password: password)
    }
    
}
