//
//  MockNetworkProtocol.swift
//  myrootsinafricaTests
//
//  Created by Darot on 13/04/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import RxSwift
@testable import myrootsinafrica
class MockNetworkProtocol:NetworkProtocol{
    var forgotPasswordCount = 0
    func forgotPassword(email: String) -> Observable<AuthResponse> {
        forgotPasswordCount += 1
        print(forgotPasswordCount)
        return Observable.of(AuthResponse(status: nil, error: nil, message: nil, payload: nil, token: nil))
    }
    
    func registerUser(user: UserDetails) -> Observable<AuthResponse> {
        return Observable.of(AuthResponse(status: nil, error: nil, message: nil, payload: nil, token: nil))
    }
    
    func verifyUser(code: String, token: String) -> Observable<AuthResponse> {
        return Observable.of(AuthResponse(status: nil, error: nil, message: nil, payload: nil, token: nil))
    }
    
    func userLogin(email: String, password: String) -> Observable<AuthResponse> {
        return Observable.of(AuthResponse(status: nil, error: nil, message: nil, payload: nil, token: nil))
    }
    
    func reserveTree(tree: Tree, token: String) -> Observable<AuthResponse> {
        return Observable.of(AuthResponse(status: nil, error: nil, message: nil, payload: nil, token: nil))
    }
    
    func getUserTrees(token: String) -> Observable<TreeResponse> {
        return Observable.of(TreeResponse(status: nil, error: nil, message: nil, payload: nil))
    }
    
    func getUserTrees(token: String, completionHandler: @escaping (Result<TreeResponse, NetworkError>) -> Void) {
        
    }
    
    func resetPassword(email: String, code: String, password: String) -> Observable<AuthResponse> {
        return Observable.of(AuthResponse(status: nil, error: nil, message: nil, payload: nil, token: nil))
    }
    
  

}
