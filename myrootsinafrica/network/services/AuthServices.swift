//
//  AuthServices.swift
//  myrootsinafrica
//
//  Created by Darot on 25/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class AuthService : NetworkProtocol{
    
    func registerUser(user: User) -> Observable<AuthResponse> {
        return Observable.create{observer -> Disposable in
            let task = AF.request(URLString.registerURL, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            
            task.validate(statusCode: 200..<500)
            .responseDecodable(of: AuthResponse.self){ res in
                
                switch res.result {
                    case let .failure(error): observer.onError(error)
                        
                    case let .success(authResponse):
                        observer.onNext(authResponse)
                }
                
            }
            
            return Disposables.create {
                
            }
        }

    }
    
    func verifyUser(code: String, token:String) -> Observable<AuthResponse> {
        let headers:HTTPHeaders = [
            "Authorization" : "Bearer \(token)"
        ]
        
        return Observable.create{observer -> Disposable in
            let task = AF.request(URLString.verificationURL, method: .put, parameters: code, encoder: JSONParameterEncoder.default, headers: headers)
            
    
             
             task.validate(statusCode: 200..<500)
             .responseDecodable(of: AuthResponse.self){ res in
                 
                 switch res.result {
                     case let .failure(error): observer.onError(error)
                         
                     case let .success(authResponse):
                         observer.onNext(authResponse)
                 }
                 
             }
             
             return Disposables.create {
                 
             }
         }
    }
    


    
}
