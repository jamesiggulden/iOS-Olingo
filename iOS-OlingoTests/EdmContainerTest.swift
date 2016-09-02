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
public class EdmContainerTest: XCTestCase {

  // MARK: - Properties
  let SERVICE_ROOT = "http://services.odata.org/V4/Northwind/Northwind.svc"
  
  // MARK: - Methods
  private func getSchema() throws -> EdmSchema? {
    var myEdm: Edm?
    let myODataClient = ODataClientFactory.getClient()
    let myRetriveRequestFactory = myODataClient.retrieveRequestFactory
    let myUri:NSURL = NSURL(string:SERVICE_ROOT)!
    let myRequest = myRetriveRequestFactory.getMetadataRequest(myUri)
    let myResponse = try myRequest.execute()
    myEdm = (myResponse.getBody() as! EdmProviderImpl)
    return myEdm?.getSchema("ODataWebExperimental.Northwind.Model")
  }
  
 func testRetrieveSchema() {
    do {
      let mySchema = try getSchema()
      XCTAssert(mySchema?.getNamespace() == "ODataWebExperimental.Northwind.Model")
    }
    catch {
      XCTFail()
    }
  }
  
  func testRetrieveEntityContainer() {
    do {
      let mySchema = try getSchema()
      XCTAssert(mySchema?.getEntityContainer() != nil)
    }
    catch {
      XCTFail()
    }
  }
  
  func testRetrieveEntitySet() {
    do {
      let mySchema = try getSchema()
      let myEntitySets = mySchema?.getEntityContainer()?.entitySets
      XCTAssert(myEntitySets?.count > 10)
      var myTargetEntitySet: EdmEntitySet?
      for myEntitySet in myEntitySets! {
        if (myEntitySet.name == "Orders")
        {
          myTargetEntitySet = myEntitySet
        }
      }
      XCTAssert(myTargetEntitySet != nil)
    }
    catch {
      XCTFail()
    }
  }
  
  func testRetrieveEntitySetEntityType() {
    do {
      let mySchema = try getSchema()
      let myEntitySets = mySchema?.getEntityContainer()?.entitySets
      XCTAssert(myEntitySets?.count > 10)
      var myTargetEntitySet: EdmEntitySet?
      for myEntitySet in myEntitySets! {
        if (myEntitySet.name == "Orders")
        {
          myTargetEntitySet = myEntitySet
        }
      }
      XCTAssert(myTargetEntitySet!.getEntityType()?.name == "Order")
    }
    catch {
      XCTFail()
    }
  }
  
  func testRetrieveEntitySetEntityTypeNavigationPropertyBindings() {
    do {
      let mySchema = try getSchema()
      let myEntitySets = mySchema?.getEntityContainer()?.entitySets
      XCTAssert(myEntitySets?.count > 10)
      var myTargetEntitySet: EdmEntitySet?
      for myEntitySet in myEntitySets! {
        if (myEntitySet.name == "Orders")
        {
          myTargetEntitySet = myEntitySet
        }
      }
      let myNavigationPropertyBindings = myTargetEntitySet?.getNavigationPropertyBindings()
      XCTAssert(myNavigationPropertyBindings?.count == 4)
      var myTargetNavPropertyBinding: EdmNavigationPropertyBinding?
      for myNavPropertyBinding in myNavigationPropertyBindings! {
        if (myNavPropertyBinding.path == "Shipper") {
          myTargetNavPropertyBinding = myNavPropertyBinding
        }
      }
      XCTAssert(myTargetNavPropertyBinding?.target == "Shippers")
    }
    catch {
      XCTFail()
    }
  }
  
  
}