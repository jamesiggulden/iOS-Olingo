//
//  RequestEntityOrderTest.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 16/08/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import XCTest
@testable import iOS_Olingo

class RequestEntityOrderTest: XCTestCase {

  let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
  let client:ODataClient = ODataClientFactory().getClient()
  let entitySet = "Orders"
  
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
    uriBuilder.appendKeySegment(10248)
    do {
      let uri = try uriBuilder.build()
      guard let entity = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let id = entity.id
      let testID = NSURL(string:root + "/Orders(10248)")
      XCTAssert(id == testID)
      
      var property = entity.properties[16]
      checkPropertyValue(property,aName:"CustomerID",aVal:"VINET",aTypeKind:"String")
      property = entity.properties[14]
      checkPropertyValue(property,aName:"EmployeeID",aVal:"5",aTypeKind:"Int64")
      property = entity.properties[13]
      checkPropertyValue(property,aName:"Freight",aVal:"32.38",aTypeKind:"Decimal")
      property = entity.properties[12]
      checkPropertyValue(property,aName:"OrderDate",aVal:"1996-07-04 00:00:00 +0000",aTypeKind:"DateTimeOffset")
      
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
    uriBuilder.appendKeySegment(10248)
    uriBuilder.select("ShipCountry")
    do {
      let uri = try uriBuilder.build()
      guard let entity = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let id = entity.id
      let testID = NSURL(string:root + "/Orders" + "(10248)")
      XCTAssert(id == testID)
      
      let property = entity.properties[0]
      checkPropertyValue(property,aName:"ShipCountry",aVal:"France",aTypeKind:"String")
      
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
    uriBuilder.appendKeySegment(10248)
    uriBuilder.select("ShipCountry","OrderID")
    do {
      let uri = try uriBuilder.build()
      guard let entity = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let id = entity.id
      let testID = NSURL(string:root + "/Orders" + "(10248)")
      XCTAssert(id == testID)
      
      var property = entity.properties[0]
      checkPropertyValue(property,aName:"ShipCountry",aVal:"France",aTypeKind:"String")
      property = entity.properties[1]
      checkPropertyValue(property,aName:"OrderID",aVal:"10248",aTypeKind:"Int64")
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
    uriBuilder.appendKeySegment(10248)
    uriBuilder.select("ShipCountry,OrderID")
    do {
      let uri = try uriBuilder.build()
      guard let entity = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let id = entity.id
      let testID = NSURL(string:root + "/Orders" + "(10248)")
      XCTAssert(id == testID)
      
      var property = entity.properties[0]
      checkPropertyValue(property,aName:"ShipCountry",aVal:"France",aTypeKind:"String")
      property = entity.properties[1]
      checkPropertyValue(property,aName:"OrderID",aVal:"10248",aTypeKind:"Int64")
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
    uriBuilder.appendKeySegment(10248)
    uriBuilder.select("ShipCountry, OrderID")
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
    uriBuilder.appendKeySegment(101)
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
    uriBuilder.appendKeySegment(10248)
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
