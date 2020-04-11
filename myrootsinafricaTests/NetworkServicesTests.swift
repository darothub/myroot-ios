//
//  NetworkServicesTests.swift
//  myrootsinafricaTests
//
//  Created by Darot on 11/04/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import XCTest
import RxSwift
@testable import myrootsinafrica
class NetworkServicesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetUserTrees(){
        let expect = expectation(description: "Fetch user trees")
        let authViewModel = AuthViewModel(authProtocol: AuthService())
        authViewModel.getUserTrees(token: "token").subscribe(onNext: { (TreeResponse) in
            
            print(TreeResponse)
        }, onError: { (Error) in
            XCTFail()
        }, onCompleted: {
            print("completed")
        }) {
            expect.fulfill()
            print("disposed")
        }.disposed(by: DisposeBag())
        waitForExpectations(timeout: 2.0, handler: nil)
    }

}
