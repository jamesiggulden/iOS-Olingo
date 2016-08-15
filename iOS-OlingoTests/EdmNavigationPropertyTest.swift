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
//  EdmNavigationPropertyTest.
//
//  Created by EnergySys on 28/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation
import XCTest
@testable import iOS_Olingo

// MARK: - Class
public class EdmNavigationPropertyTest: XCTestCase {
  
  let SERVICE_ROOT = "http://services.odata.org/V4/Northwind/Northwind.svc"
  
  private func getEdm() throws -> EdmProviderImpl? {
    var myEdm: EdmProviderImpl?
    let myODataClient = ODataClientFactory.getClient()
    let myRetriveRequestFactory = myODataClient.retrieveRequestFactory
    let myUri:NSURL = NSURL(string:SERVICE_ROOT)!
    let myRequest = myRetriveRequestFactory.getMetadataRequest(myUri)
    let myResponse = try myRequest.execute()
    myEdm = (myResponse.getBody() as! EdmProviderImpl)
    return myEdm
  }
  
  func testRetrieval() {
    do {
      let myEdm = try getEdm()
      let myEntityType = myEdm!.getEntityType(FullQualifiedName(namespace: "NorthwindModel", name: "Order"))
      XCTAssert(myEntityType?.theNavigationProperties?.count == 4)
      let myNavigationProperties = myEntityType?.theNavigationProperties
      var myNavPropertyFound = false
      for myNavigationProperty in myNavigationProperties! {
        if (myNavigationProperty.name == "Customer") {
          myNavPropertyFound = true
        }
      }
      XCTAssert(myNavPropertyFound)
    }
    catch {
      XCTFail()
    }
  }
  
  func testAttributes() {
    do {
      let myEdm = try getEdm()
      let myEntityType = myEdm!.getEntityType(FullQualifiedName(namespace: "NorthwindModel", name: "Order"))
      let myNavigationProperties = myEntityType?.theNavigationProperties
      var myNavPropertyFound = false
      for myNavigationProperty in myNavigationProperties! {
        if (myNavigationProperty.name == "Customer") {
          myNavPropertyFound = true
          XCTAssert(myNavigationProperty.containsTarget == false)
          XCTAssert(myNavigationProperty.isNullable == true)
          XCTAssert(myNavigationProperty.isCollection == false)
        }
      }
      XCTAssert(myNavPropertyFound)
    }
    catch {
      XCTFail()
    }
  }

  func testGetType() {
    do {
      let myEdm = try getEdm()
      let myEntityType = myEdm!.getEntityType(FullQualifiedName(namespace: "NorthwindModel", name: "Order"))
      let myNavigationProperties = myEntityType?.theNavigationProperties
      var myNavPropertyFound = false
      for myNavigationProperty in myNavigationProperties! {
        if (myNavigationProperty.name == "Customer") {
          myNavPropertyFound = true
          XCTAssert(myNavigationProperty.type?.name == "Customer")
        }
      }
      XCTAssert(myNavPropertyFound)
    }
    catch {
      XCTFail()
    }
  }

  func testGetPartner() {
    do {
      let myEdm = try getEdm()
      let myEntityType = myEdm!.getEntityType(FullQualifiedName(namespace: "NorthwindModel", name: "Order"))
      let myNavigationProperties = myEntityType?.theNavigationProperties
      var myNavPropertyFound = false
      for myNavigationProperty in myNavigationProperties! {
        if (myNavigationProperty.name == "Customer") {
          myNavPropertyFound = true
          XCTAssert(myNavigationProperty.partner?.name == "Orders")
        }
      }
      XCTAssert(myNavPropertyFound)
    }
    catch {
      XCTFail()
    }
  }

  func testGetReferentialConstraints() {
    do {
      let myEdm = try getEdm()
      let myEntityType = myEdm!.getEntityType(FullQualifiedName(namespace: "NorthwindModel", name: "Order"))
      let myNavigationProperties = myEntityType?.theNavigationProperties
      var myNavPropertyFound = false
      for myNavigationProperty in myNavigationProperties! {
        if (myNavigationProperty.name == "Customer") {
          myNavPropertyFound = true
          let myReferentialConstraint = myNavigationProperty.referentialConstraints.first
          XCTAssert(myReferentialConstraint?.propertyName == "CustomerID")
          XCTAssert(myReferentialConstraint?.referencedPropertyName == "CustomerID")
        }
      }
      XCTAssert(myNavPropertyFound)
    }
    catch {
      XCTFail()
    }
  }

}