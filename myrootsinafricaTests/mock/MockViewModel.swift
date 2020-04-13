//
//  MockViewModel.swift
//  myrootsinafricaTests
//
//  Created by Darot on 13/04/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import RxSwift
@testable import myrootsinafrica
class MockViewModel:AuthViewModel{
    let authProtocols = MockNetworkProtocol()
    var checkCount = 0
    init(){
        super.init(authProtocol: authProtocols)
    }
    
    override func forgotPassword(email: String) -> Observable<AuthResponse> {
        authProtocols.forgotPassword(email: email)
        checkCount += 1
        return Observable.of(AuthResponse(status: nil, error: nil, message: nil, payload: nil, token: nil))
    }
    
    override func userLogin(email: String, password: String) -> Observable<AuthResponse> {
        checkCount += 1
        authProtocols.userLogin(email: email, password: password)
        return Observable.of(AuthResponse(status: nil, error: nil, message: nil, payload: nil, token: nil))
    }
    
}
