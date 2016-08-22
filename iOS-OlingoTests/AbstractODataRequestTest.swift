//
//  AbstractODataRequestTest.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 05/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import XCTest
@testable import iOS_Olingo


class AbstractODataRequestTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
  
    func testexecute() {
      let odataClient = ODataClientImpl()
      
      guard let uri:NSURL = NSURL(string:"http://services.odata.org/V4/Northwind/Northwind.svc/Customers")! else {
        return
      }
      do {
        let odataRequest = AbstractODataRequest(odataClient: odataClient,method: HttpMethod.POST,uri: uri)
        let odataResponse = try odataRequest.doExecute()
        XCTAssert(odataResponse.response.statusCode == 200)
      }
      catch {
        XCTFail()
      }
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
