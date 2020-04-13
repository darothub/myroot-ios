//
//  CalculatorTest.swift
//  myrootsinafricaTests
//
//  Created by Darot on 10/04/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import XCTest
@testable import myrootsinafrica
class CalculatorTest: XCTestCase {
    
    var calculator:Calculator!
    override func setUp() {
        calculator = Calculator()
    }

    override func tearDown() {
        calculator = nil
    }


    func testAdd(){
        let result = calculator.add(1, 2)
        XCTAssertEqual(result, 3, "Expected 4 but got \(result)")
    }

}
