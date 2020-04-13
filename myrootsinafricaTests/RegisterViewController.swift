//
//  RegisterViewController.swift
//  myrootsinafricaTests
//
//  Created by Darot on 13/04/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import XCTest
import RxBlocking
import RxSwift
@testable import myrootsinafrica

class RegisterViewController: XCTestCase {

    var vc:SignupController!
    var mockViewModel:MockViewModel!
    var userDetails = UserDetails()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        vc = (storyBoard.instantiateViewController(identifier: "registerstory") as! SignupController)
        mockViewModel = MockViewModel()
        vc.authViewModel = mockViewModel
        
        
        userDetails.name = "Kunle"
        userDetails.email = "email@email.com"
        userDetails.password = "password123"
        userDetails.country = "Nigeria"
        userDetails.phone = "0807089089000"
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginViewController(){
        _ = vc.view
    }
    
    func testLoginViewControllerViewModel(){
       
        _ = vc.view
        XCTAssertEqual(mockViewModel.checkCount, 1)
    }
    
    func testObservablePayload(){
        
        XCTAssertNotNil(try vc.authViewModel.registerUser(user: userDetails).toBlocking().single().payload)
    }
    
    func testObservableStatus(){
        
        XCTAssertEqual(try vc.authViewModel.registerUser(user: userDetails).toBlocking().single().status, 201)
    }
    
    func testObservableUserDetails(){
       
        vc.authViewModel.registerUser(user: userDetails)
        XCTAssertEqual(try vc.authViewModel.registerUser(user: userDetails).toBlocking().single().payload?.name, userDetails.name)
    }


}
