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
    func registerUser(user:User) -> Observable<AuthResponse> {
        return authProtocol.registerUser(user:user)
    }
    
    
}
