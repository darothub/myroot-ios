//
//  LoginViewControllerTest.swift
//  myrootsinafricaTests
//
//  Created by Darot on 13/04/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import XCTest
import RxBlocking
import RxSwift
@testable import myrootsinafrica
class LoginViewControllerTest: XCTestCase {

    var vc:LoginViewController!
    var mockViewModel:MockViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        vc = (storyBoard.instantiateViewController(identifier: "loginstory") as! LoginViewController)
        mockViewModel = MockViewModel()
        vc.authViewModel = mockViewModel
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginViewController(){
        _ = vc.view
    }
    
    func testLoginViewControllerViewModel(){
        
        
        vc.authViewModel.userLogin(email: "", password: "")
        _ = vc.view
        XCTAssertEqual(mockViewModel.checkCount, 1)
    }
    
    func testObservablePayload(){
        XCTAssertNil(try vc.authViewModel.userLogin(email: "", password: "").toBlocking().single().payload)
    }
    
    func testObservableStatus(){
        XCTAssertEqual(try vc.authViewModel.userLogin(email: "", password: "").toBlocking().single().status, 200)
    }

}
