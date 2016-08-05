/*
 * Copyright 2015 EnergySys Limited. All Rights Reserved.
 *
 * This software is the proprietary information of EnergySys Limited.
 * Use is subject to licence terms.
 * This software is not designed or supplied to be used in circumstances where
 * personal injury, death or loss of or damage to property could result from any
 * defect in the software.
 * In no event shall the developers or owners be liable for personal injury,
 * death or loss or damage to property, loss of business, revenue, profits, use,
 * data or other economic advantage or for any indirect, punitive, special,
 * incidental, consequential or exemplary loss or damage resulting from the use
 * of the software or documentation.
 * Developer and owner make no warranties, representations or undertakings of
 * any nature in relation to the software and documentation.
 */

//
//  EdmMetadataRequestTest.
//
//  Created by EnergySys on 28/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation
import XCTest
@testable import iOS_Olingo

// MARK: - Class
public class EdmMetadataRequestTest: XCTestCase {
  
  let SERVICE_ROOT = "http://services.odata.org/V4/Northwind/Northwind.svc"
  
  func testExecution() {
    let myODataClient = ODataClientFactory.getClient()
    let myRetriveRequestFactory = myODataClient.retrieveRequestFactory
    let myUri:NSURL = NSURL(string:SERVICE_ROOT)!
    let myRequest = myRetriveRequestFactory.getMetadataRequest(myUri)
    do {
      try myRequest.execute()
    }
    catch {
      XCTFail()
    }
  }
  
  func testFailExecution() {
    let myODataClient = ODataClientFactory.getClient()
    let myRetriveRequestFactory = myODataClient.retrieveRequestFactory
    let myUri:NSURL = NSURL(string:"http://BADHOST/BADPATH")!
    let myRequest = myRetriveRequestFactory.getMetadataRequest(myUri)
    var myResponse: ODataRetrieveResponse?
    do {
      myResponse = try myRequest.execute()
    }
    catch {
      XCTAssert(myResponse == nil)
      return
    }
    XCTFail()
  }
  
}