//
//  myrootsinafricaUITests.swift
//  myrootsinafricaUITests
//
//  Created by Darot on 12/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import XCTest

class myrootsinafricaUITests: XCTestCase {

    let app = XCUIApplication()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testHomeWelcomeText(){
        XCTAssertTrue(app.staticTexts["World's #1 \nClimate Action App"].exists)
    }
    
    func testHomeSceneSignupButton(){
        app.buttons["Signup"].tap()

    }
    
    func testHomeSceneLoginButton(){

        app.buttons.staticTexts["Login"].tap()
        
    }
    
    func testNavigationToLoginScene(){
        app.buttons.staticTexts["Login"].tap()
        let textLabelQuery = app.staticTexts["Email"]
        XCTAssertTrue(textLabelQuery.exists)
    }
    func testNavigationToRegisterScene(){
          app.buttons.staticTexts["Signup"].tap()
          let textLabelQuery = app.staticTexts["Welcome"]
          XCTAssertTrue(textLabelQuery.exists)
      }
}
