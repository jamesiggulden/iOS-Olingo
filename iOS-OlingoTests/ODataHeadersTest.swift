//
//  ODataHeadersTest.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 28/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import XCTest
@testable import iOS_Olingo



class ODataHeadersTest: XCTestCase {
  


    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

  
  
  func testODataHeaders() {
    var headers = ODataHeadersImpl()
    var headerNames = [String]()
    
    headers = headers.setHeader("A", value: "Letter A")
    XCTAssert(headers.getHeader("A") == "Letter A")
    headers = headers.setHeader("B", value: "Letter B")
    headers = headers.setHeader("C", value: "Letter C")
    headerNames = headers.getHeaderNames()
    XCTAssert(headerNames[0] == "A")
    XCTAssert(headerNames[1] == "B")
    XCTAssert(headerNames[2] == "C")
    XCTAssert(headers.removeHeader("B") == "Letter B")
    headerNames = headers.getHeaderNames()
    XCTAssert(headerNames[0] == "A")
    XCTAssert(headerNames[1] == "C")
    
  }
  

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
