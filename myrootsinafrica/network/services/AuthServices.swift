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
    func resetPassword(email: String, code: String, password: String) -> Observable<AuthResponse> {
        let parameters: [String: String] = [
              "email": email,
              "code": code,
              "password":password
          ]
          return Observable.create{observer -> Disposable in
              let task = AF.request(URLString.resetPasswordURL, method: .post, parameters: parameters,
                                    encoder: JSONParameterEncoder.default)
              task.validate(statusCode: 200..<500)
               .responseDecodable(of: AuthResponse.self){ res in
                   
                   switch res.result {
                     
                       case let .failure(error): observer.onError(error); print(error)
                           
                       case let .success(authResponse):
                           observer.onNext(authResponse)
                   }
                   
               }
               
               return Disposables.create {
                   
               }
           }
    }
    
    func forgotPassword(email: String) -> Observable<AuthResponse> {
        let parameters: [String: String] = [
              "email": email

          ]
          return Observable.create{observer -> Disposable in
              let task = AF.request(URLString.forgotPasswordURL, method: .post, parameters: parameters,
                                    encoder: JSONParameterEncoder.default)
              task.validate(statusCode: 200..<500)
               .responseDecodable(of: AuthResponse.self){ res in
                   
                   switch res.result {
                     
                       case let .failure(error): observer.onError(error); print(error)
                           
                       case let .success(authResponse):
                           observer.onNext(authResponse)
                   }
                   
               }
               
               return Disposables.create {
                   
               }
           }
    }
    
    func getUserTrees(token: String) -> Observable<TreeResponse> {
        let headers:HTTPHeaders = [
            "Authorization" : "Bearer \(token)"
        ]
        return Observable.create{observer -> Disposable in
            let task = AF.request(URLString.userTreeURL, method: .get, headers: headers)
            
            task.validate(statusCode: 0..<600)
            .responseDecodable(of: TreeResponse.self){ res in
                
                switch res.result {
                    case let .failure(error): observer.onError(error)
                        
                    case let .success(treeResponse):
                        observer.onNext(treeResponse)
                }
                
            }
            
            return Disposables.create {
                
            }
        }

    }
    
  
    
    func reserveTree(tree: Tree, token:String) -> Observable<AuthResponse> {
        let headers:HTTPHeaders = [
                   "Authorization" : "Bearer \(token)"
               ]
        print("headers \(headers)")
        return Observable.create{observer -> Disposable in
            let task = AF.request(URLString.treeReservationURL, method: .post, parameters: tree, encoder: JSONParameterEncoder.default, headers: headers)
            
            task.validate(statusCode: 200..<600)
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
    
    
    
    func userLogin(email: String, password: String) -> Observable<AuthResponse> {
 
        
        let parameters: [String: String] = [
            "email": email,
            "password":password
        ]
        return Observable.create{observer -> Disposable in
            let task = AF.request(URLString.loginURL, method: .post, parameters: parameters,
                                  encoder: JSONParameterEncoder.default)
            task.validate(statusCode: 200..<500)
             .responseDecodable(of: AuthResponse.self){ res in
                 
                 switch res.result {
                   
                     case let .failure(error): observer.onError(error); print(error)
                         
                     case let .success(authResponse):
                         observer.onNext(authResponse)
                 }
                 
             }
             
             return Disposables.create {
                 
             }
         }
    }
    
    
    func registerUser(user: UserDetails) -> Observable<AuthResponse> {
        return Observable.create{observer -> Disposable in
            let task = AF.request(URLString.registerURL, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            
            task.validate(statusCode: 200..<600)
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
        
        let parameters: [String: String] = [
            "code": code
        ]
        return Observable.create{observer -> Disposable in
            let task = AF.request(URLString.verificationURL, method: .put, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            task.validate(statusCode: 0..<500)
             .responseDecodable(of: AuthResponse.self){ res in
                 
                 switch res.result {
                   
                     case let .failure(error): observer.onError(error); print(error)
                         
                     case let .success(authResponse):
                         observer.onNext(authResponse)
                 }
                 
             }
             
             return Disposables.create {
                 
             }
         }
    }
    
    


    
}
