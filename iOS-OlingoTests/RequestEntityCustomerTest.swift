//
//  RequestEntityTest.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 16/08/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import XCTest

class RequestEntityCustomerTest: XCTestCase {

  let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
  let client:ODataClient = ODataClientFactory.getClient()
  let entitySet = "Customers"
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func checkPropertyValue(property:ClientProperty,aName:String,aVal:String,aTypeKind:String) {
    
    if let propertyValue = property.value.asPrimitive {
      if let propertyValueValue = propertyValue.value {
        let name = String(property.name)
        let val = String(propertyValueValue)
        if let tk = propertyValue.typeKind?.toString() {
          XCTAssert(name == aName)
          XCTAssert(val == aVal)
          XCTAssert(tk == aTypeKind)
        }
        else {
          XCTFail()
        }
      }
      else {
        XCTFail()
      }
    }
    else {
      XCTFail()
    }
  }
  
  func testRequestValidEntity() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySet)
    uriBuilder.appendKeySegment("'ANTON'")
    do {
      let uri = try uriBuilder.build()
      guard let entity = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let id = entity.id
      let testID = NSURL(string:root + "/Customers('ANTON')")
      XCTAssert(id == testID)
      
      let property = entity.properties[2]
      checkPropertyValue(property,aName:"Phone",aVal:"(5) 555-3932",aTypeKind:"String")
    }
    catch {
      XCTFail()
    }
  }
  
  
  func testRequestValidEntityFilterSingleProperty() {
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySet)
    uriBuilder.appendKeySegment("'ANATR'")
    uriBuilder.select("Country")
    do {
      let uri = try uriBuilder.build()
      guard let entity = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let id = entity.id
      let testID = NSURL(string:root + "/Customers" + "('ANATR')")
      XCTAssert(id == testID)
      
      let property = entity.properties[0]
      checkPropertyValue(property,aName:"Country",aVal:"Mexico",aTypeKind:"String")
      
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntityFilterMultipleProperties() {
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySet)
    uriBuilder.appendKeySegment("'ANATR'")
    uriBuilder.select("Country","CustomerID")
    do {
      let uri = try uriBuilder.build()
      guard let entity = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let id = entity.id
      let testID = NSURL(string:root + "/Customers" + "('ANATR')")
      XCTAssert(id == testID)
      
      var property = entity.properties[0]
      checkPropertyValue(property,aName:"CustomerID",aVal:"ANATR",aTypeKind:"String")
      property = entity.properties[1]
      checkPropertyValue(property,aName:"Country",aVal:"Mexico",aTypeKind:"String")
      
      
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntityFilterMultiplePropertiesAsString() {
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySet)
    uriBuilder.appendKeySegment("'ANATR'")
    uriBuilder.select("Country,CustomerID")
    do {
      let uri = try uriBuilder.build()
      guard let entity = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let id = entity.id
      let testID = NSURL(string:root + "/Customers" + "('ANATR')")
      XCTAssert(id == testID)
      
      var property = entity.properties[0]
      checkPropertyValue(property,aName:"CustomerID",aVal:"ANATR",aTypeKind:"String")
      property = entity.properties[1]
      checkPropertyValue(property,aName:"Country",aVal:"Mexico",aTypeKind:"String")
      
      
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntityFilterCheckNumberMultipleProperties() {
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySet)
    uriBuilder.appendKeySegment("'ANATR'")
    uriBuilder.select("Country, CustomerID")
    do {
      let uri = try uriBuilder.build()
      guard let entity = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      XCTAssert(entity.properties.count == 2)
    }
    catch {
      XCTFail()
    }
  }
  
  
  
  func testRequestInvalidEntity() {
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customer")
    uriBuilder.appendKeySegment("'ANA'")
    do {
      let uri = try uriBuilder.build()
      
      guard let response = client.retrieveRequestFactory.entityRequest(uri).execute() else {
        XCTFail()
        return
      }
      XCTAssert(response.statusCode == 404)
      do {
        let body = try response.getBody()
      }
      catch {
        XCTAssert(true)
      }
      
    }
    catch {
      XCTFail()
    }
  }
  
  
  func testRequestInvalidEntityFilter() {
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySet)
    uriBuilder.appendKeySegment("'ANATR'")
    uriBuilder.select("Countries")
    do {
      let uri = try uriBuilder.build()
      
      guard let response = client.retrieveRequestFactory.entityRequest(uri).execute() else {
        XCTFail()
        return
      }
      XCTAssert(response.statusCode == 400)
      do {
        let body = try response.getBody()
      }
      catch {
        XCTAssert(true)
      }
      
    }
    catch {
      XCTFail()
    }
  }
  
  
  
  func executeAndBuild(client:ODataClient,uri:NSURL) -> ClientEntity? {
    
    let entityRequest = client.retrieveRequestFactory.entityRequest(uri)
    
    guard let response = entityRequest.execute() else {
      XCTFail()
      return nil
    }
    do {
      return try response.getBody()
    }
    catch is IllegalArgumentException{
      XCTFail()
      return nil
    }
    catch {
      XCTFail()
      return nil
    }
    
  }

}
