//
//  NetworkServicesTests.swift
//  myrootsinafricaTests
//
//  Created by Darot on 11/04/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking
import RxTest
import Alamofire

@testable import myrootsinafrica

class ForgotPasswordVCTest: XCTestCase {
    
    
    var vc:ForgotPasswordViewController!
    var token:String!
    var authViewModel: AuthViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        token = "token".localized
        authViewModel = AuthViewModel(authProtocol: AuthService())
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        vc = (storyBoard.instantiateViewController(identifier: "forgotstory") as! ForgotPasswordViewController)
        super.setUp()
    
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testForgotPasswordViewModel(){
        let mockViewModel = MockViewModel()
        vc.authViewModel = mockViewModel
        vc.authViewModel.forgotPassword(email: "")
        _ = vc.view
        XCTAssertEqual(mockViewModel.checkCount, 1)
    }
//    func testGetUserTrees(){
//
//        let expect = expectation(description: "Fetch user trees")
//
//        authViewModel.getUserTrees(token: token){ result in
//            expect.fulfill()
//            switch result {
//            case .success(let treeResponse):
//                XCTAssertNotNil(treeResponse.status)
//                XCTAssertNotNil(treeResponse.payload)
//                print(treeResponse.message!)
//            case .failure(let error):
//                XCTFail()
//                print(error)
//            }
//
//        }
//        waitForExpectations(timeout: 2.0, handler: nil)
//    }
//
//    func testGetUserObservableTrees(){
//        XCTAssertNotNil(try authViewModel.getUserTrees(token: token).toBlocking().single().payload)
//    }
//
//    func testRegisterUser(){
//        var userDetails = UserDetails()
//        userDetails.name = "Kunle"
//        userDetails.email = "email@email.com"
//        userDetails.password = "password123"
//        userDetails.country = "Nigeria"
//        userDetails.phone = "0807089089000"
//        XCTAssertNotNil(try authViewModel.registerUser(user: userDetails).toBlocking().single().payload)
//    }
//
////    func testGetUserTreesConnectionError(){
////
////        let expect = expectation(description: "Fetch user trees")
////        let authViewModel = AuthViewModel(authProtocol: AuthService())
////        authViewModel.getUserTrees(token: token){ result in
////            expect.fulfill()
////            switch result {
////            case .success:
////                XCTFail()
////            case .failure(let error):
////                XCTAssertNotNil(error)
////                print(error.localizedDescription)
////            }
////
////        }
////        waitForExpectations(timeout: 2.0, handler: nil)
////    }
//
//    func testGetUserTreesInvalidTokenError(){
//        token = "token"
//        let expect = expectation(description: "Fetch user trees")
//        let authViewModel = AuthViewModel(authProtocol: AuthService())
//        authViewModel.getUserTrees(token: token){ result in
//            expect.fulfill()
//            switch result {
//            case .success(let response):
//                XCTAssertNil(response.status)
//                XCTAssertNotNil(response.error)
//                print(response.error!)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//
//        }
//        waitForExpectations(timeout: 2.0, handler: nil)
//    }
//
//    func testBlocking(){
//
//        XCTAssertEqual(try Observable.of(10, 20, 30).toBlocking().first(), 10)
//    }

}
