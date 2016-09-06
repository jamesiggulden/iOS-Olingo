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
//  EdmTest.
//
//  Created by EnergySys on 28/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation
import XCTest
@testable import iOS_Olingo

// MARK: - Class
public class EdmTest: XCTestCase {
  
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
  
  func testEdmRetrieval() {
    do {
      let myEdm = try getEdm()
      XCTAssert(myEdm != nil)
    }
    catch {
      XCTFail()
    }
  }
  
  func testRetrieveSchemas() {
    do {
      let myEdm = try getEdm()
      XCTAssert(myEdm!.getSchemas().count == 2)
      XCTAssert(myEdm!.getSchema("NorthwindModel").getEntityTypes().count > 1)
    }
    catch {
      XCTFail()
    }
  }
  
  func testRetrieveEntityType() {
    do {
      let myEdm = try getEdm()
      let myEntityType = myEdm!.getEntityType(FullQualifiedName(namespace: "NorthwindModel", name: "Customer"))
      XCTAssert(myEntityType!.name == "Customer")
    }
    catch {
      XCTFail()
    }
  }
  
  func testRetrieveEntityTypeProperties() {
    var myPropertyExists = false
    do {
      let myEdm = try getEdm()
      let myEntityType = myEdm!.getEntityType(FullQualifiedName(namespace: "NorthwindModel", name: "Customer"))
      let myKeyPropertyRefs = myEntityType?.getKeyPropertyRefs()
      for myKeyPropertyRef in myKeyPropertyRefs! {
        let myPropName = myKeyPropertyRef.name
        if (myPropName == "ContactTitle") {
          myPropertyExists = true
        }
      }
    }
    catch {
      XCTFail()
    }
    XCTAssert(myPropertyExists)
  }

  func testRetrieveEntityTypePropertyAttributes() {
    var myPropertyExists = false
    do {
      let myEdm = try getEdm()
      let myEntityType = myEdm!.getEntityType(FullQualifiedName(namespace: "NorthwindModel", name: "Customer"))
      let myKeyPropertyRefs = myEntityType?.getKeyPropertyRefs()
      for myKeyPropertyRef in myKeyPropertyRefs! {
        let myPropName = myKeyPropertyRef.name
        if (myPropName == "ContactTitle") {
          myPropertyExists = true
          let myProperty = myKeyPropertyRef.property
          XCTAssert(myProperty.isNilable == true)
          XCTAssert(myProperty.maxLength == 30)
        }
      }
    }
    catch {
      XCTFail()
    }
    XCTAssert(myPropertyExists)
  }

  func testRetrieveEntityTypePropertyTypeString() {
    var myPropertyExists = false
    do {
      let myEdm = try getEdm()
      let myEntityType = myEdm!.getEntityType(FullQualifiedName(namespace: "NorthwindModel", name: "Customer"))
      let myKeyPropertyRefs = myEntityType?.getKeyPropertyRefs()
      for myKeyPropertyRef in myKeyPropertyRefs! {
        let myPropName = myKeyPropertyRef.name
        if (myPropName == "ContactTitle") {
          myPropertyExists = true
          let myProperty = myKeyPropertyRef.property
          let myPropertyType = myProperty.type
          XCTAssert(myPropertyType is EdmString)
        }
      }
    }
    catch {
      XCTFail()
    }
    XCTAssert(myPropertyExists)
  }
  
  ///The following need implementing:
  ///func testRetrieveEntityTypePropertyTypeDouble()
  ///Unfortunately, no EdmDoubles in the NorthWind feed...
  
  func testRetrieveEntityTypePropertyTypeBoolean() {
    var myPropertyExists = false
    do {
      let myEdm = try getEdm()
      let myEntityType = myEdm!.getEntityType(FullQualifiedName(namespace: "NorthwindModel", name: "Product"))
      let myKeyPropertyRefs = myEntityType?.getKeyPropertyRefs()
      for myKeyPropertyRef in myKeyPropertyRefs! {
        let myPropName = myKeyPropertyRef.name
        if (myPropName == "Discontinued") {
          myPropertyExists = true
          let myProperty = myKeyPropertyRef.property
          let myPropertyType = myProperty.type
          XCTAssert(myPropertyType is EdmBoolean)
        }
      }
    }
    catch {
      XCTFail()
    }
    XCTAssert(myPropertyExists)
  }
  
  func testRetrieveEntityTypePropertyTypeDateTimeOffset() {
    var myPropertyExists = false
    do {
      let myEdm = try getEdm()
      let myEntityType = myEdm!.getEntityType(FullQualifiedName(namespace: "NorthwindModel", name: "Order"))
      let myKeyPropertyRefs = myEntityType?.getKeyPropertyRefs()
      for myKeyPropertyRef in myKeyPropertyRefs! {
        let myPropName = myKeyPropertyRef.name
        if (myPropName == "OrderDate") {
          myPropertyExists = true
          let myProperty = myKeyPropertyRef.property
          let myPropertyType = myProperty.type
          XCTAssert(myPropertyType is EdmDateTimeOffset)
        }
      }
    }
    catch {
      XCTFail()
    }
    XCTAssert(myPropertyExists)
  }


  func testRetrieveEntityTypePropertyTypeInt32() {
    var myPropertyExists = false
    do {
      let myEdm = try getEdm()
      let myEntityType = myEdm!.getEntityType(FullQualifiedName(namespace: "NorthwindModel", name: "Employee"))
      let myKeyPropertyRefs = myEntityType?.getKeyPropertyRefs()
      for myKeyPropertyRef in myKeyPropertyRefs! {
        let myPropName = myKeyPropertyRef.name
        if (myPropName == "ReportsTo") {
          myPropertyExists = true
          let myProperty = myKeyPropertyRef.property
          let myPropertyType = myProperty.type
          XCTAssert(myPropertyType is EdmInt32)
        }
      }
    }
    catch {
      XCTFail()
    }
    XCTAssert(myPropertyExists)
  }
  
}