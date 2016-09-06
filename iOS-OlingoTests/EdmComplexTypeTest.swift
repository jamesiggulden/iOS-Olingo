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

//  EdmContainerTest.
//  Created by EnergySys on 28/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.

import Foundation
import XCTest
@testable import iOS_Olingo

// MARK: - Class
public class EdmComplexTypeTest: XCTestCase {
  
  // MARK: - Properties
  let SERVICE_ROOT = "http://services.odata.org/v4/TripPinServiceRW/$metadata"
  
  // MARK: - Methods
  private func getSchema() throws -> EdmSchema? {
    var myEdm: Edm?
    let myODataClient = ODataClientFactory.getClient()
    let myRetriveRequestFactory = myODataClient.retrieveRequestFactory
    let myUri:NSURL = NSURL(string:SERVICE_ROOT)!
    let myRequest = myRetriveRequestFactory.getMetadataRequest(myUri)
    let myResponse = try myRequest.execute()
    myEdm = (myResponse.getBody() as! EdmProviderImpl)
    return myEdm?.getSchema("Microsoft.OData.SampleService.Models.TripPin")
  }
  
  func testRetrieveSchema() {
    do {
      let mySchema = try getSchema()
      XCTAssert(mySchema?.getNamespace() == "Microsoft.OData.SampleService.Models.TripPin")
    }
    catch {
      XCTFail()
    }
  }

  func testRetrieveComplexTypes() {
    do {
      let mySchema = try getSchema()
      XCTAssert(mySchema?.getComplexTypes().count == 4)
    }
    catch {
      XCTFail()
    }
  }
  
  func testRetrieveComplexType() {
    do {
      let mySchema = try getSchema()
      let myComplexTypes = mySchema?.getComplexTypes()
      var myComplexTypeFound = false
      for myComplexType in myComplexTypes! {
        if (myComplexType.name == "EventLocation") {
          myComplexTypeFound = true
        }
      }
      XCTAssert(myComplexTypeFound)
    }
    catch {
      XCTFail()
    }
  }
  
  func testRetrieveComplexTypeProperties() {
    do {
      let mySchema = try getSchema()
      let myComplexTypes = mySchema?.getComplexTypes()
      var myComplexTypeFound = false
      for myComplexType in myComplexTypes! {
        if (myComplexType.name == "EventLocation") {
          myComplexTypeFound = true
          let myProperty = myComplexType.getProperty("BuildingInfo")
          XCTAssert(myProperty!.type! is EdmString)
          let myInheritedProperty = myComplexType.getProperty("City")
          XCTAssert(myInheritedProperty!.type! is EdmComplexType)
        }
      }
      XCTAssert(myComplexTypeFound)
    }
    catch {
      XCTFail()
    }
  }
  
}