//
//  RequestEntitySet.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 05/08/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import XCTest
@testable import iOS_Olingo

class RequestEntitySetTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

  
  func checkPropertyValue(property:ClientProperty,nameX:String,valX:String,tkX:String) {
    
    if let propertyValue = property.value.asPrimitive {
      if let propertyValueValue = propertyValue.value {
        let name = String(property.name)
        let val = String(propertyValueValue)
        if let tk = propertyValue.typeKind?.toString() {
          XCTAssert(name == nameX)
          XCTAssert(val == valX)
          XCTAssert(tk == tkX)
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


  func testRequestValidEntitySet() {

    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
        do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let entity = entitySet.entities[2]
      let id = entity.id
      let testID = NSURL(string:uri.absoluteString + "('ANTON')")
      XCTAssert(id == testID)
      
      let property = entity.properties[2]
      checkPropertyValue(property,nameX:"Phone",valX:"(5) 555-3932",tkX:"String")
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetOrderedByCountryAsc() {
    
    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
    uriBuilder.orderBy("Country")
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let entity = entitySet.entities[1]
      let id = entity.id
      let testID = NSURL(string:root + "/Customers" + "('OCEAN')")
      XCTAssert(id == testID)
      
      let property = entity.properties[7]
      checkPropertyValue(property,nameX:"Country",valX:"Argentina",tkX:"String")
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetOrderedByCountryDesc() {
    
    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
    uriBuilder.orderBy("Country desc")
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let entity = entitySet.entities[1]
      let id = entity.id
      let testID = NSURL(string:root + "/Customers" + "('HILAA')")
      XCTAssert(id == testID)
      
      let property = entity.properties[7]
      checkPropertyValue(property,nameX:"Country",valX:"Venezuela",tkX:"String")
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetNumRecordsToReturn() {
    
    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    let numRecs = 10
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
    uriBuilder.top(numRecs)
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      
      let count = entitySet.entities.count
      XCTAssert(count == numRecs)
      
      let entity = entitySet.entities[1]
      let id = entity.id
      let testID = NSURL(string:root + "/Customers" + "('ANATR')")
      XCTAssert(id == testID)
      
      let property = entity.properties[7]
      checkPropertyValue(property,nameX:"Country",valX:"Mexico",tkX:"String")
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetCount() {
    
    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    let numRecs = 91

    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
    uriBuilder.count(true)
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      XCTAssert(entitySet.count == numRecs)
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySkipRecordsToReturn() {
    
    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    let numRecs = 10
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
    uriBuilder.skip(numRecs)
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      
      let entity = entitySet.entities[1]
      let id = entity.id
      let testID = NSURL(string:root + "/Customers" + "('CACTU')")
      XCTAssert(id == testID)
      
      let property = entity.properties[7]
      checkPropertyValue(property,nameX:"Country",valX:"Argentina",tkX:"String")
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySkipAndTopRecordsToReturn() {
    
    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    let numRecs = 10
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
    uriBuilder.skip(numRecs)
    uriBuilder.top(numRecs)
    uriBuilder.count(true)
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let count = entitySet.entities.count
      XCTAssert(count == numRecs)
      
      let entity = entitySet.entities[1]
      let id = entity.id
      let testID = NSURL(string:root + "/Customers" + "('CACTU')")
      XCTAssert(id == testID)
      
      let property = entity.properties[7]
      checkPropertyValue(property,nameX:"Country",valX:"Argentina",tkX:"String")
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetFilterSingleProperty() {
    
    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
    uriBuilder.select("Country")
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let entity = entitySet.entities[1]
      let id = entity.id
      let testID = NSURL(string:root + "/Customers" + "('ANATR')")
      XCTAssert(id == testID)
      
      let property = entity.properties[0]
      checkPropertyValue(property,nameX:"Country",valX:"Mexico",tkX:"String")
      
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetFilterMultipleProperties() {
    
    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
    uriBuilder.select("Country","CustomerID")
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let entity = entitySet.entities[1]
      let id = entity.id
      let testID = NSURL(string:root + "/Customers" + "('ANATR')")
      XCTAssert(id == testID)
      
      var property = entity.properties[0]
      checkPropertyValue(property,nameX:"CustomerID",valX:"ANATR",tkX:"String")
      property = entity.properties[1]
      checkPropertyValue(property,nameX:"Country",valX:"Mexico",tkX:"String")
      
      
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetFilterMultiplePropertiesAsString() {
    
    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
    uriBuilder.select("Country,CustomerID")
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let entity = entitySet.entities[1]
      let id = entity.id
      let testID = NSURL(string:root + "/Customers" + "('ANATR')")
      XCTAssert(id == testID)
      
      var property = entity.properties[0]
      checkPropertyValue(property,nameX:"CustomerID",valX:"ANATR",tkX:"String")
      property = entity.properties[1]
      checkPropertyValue(property,nameX:"Country",valX:"Mexico",tkX:"String")
      
      
    }
    catch {
      XCTFail()
    }
  }

  
  func testRequestValidEntitySetFilterCheckNumberMultipleProperties() {
    
    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
    uriBuilder.select("Country, CustomerID")
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let entity = entitySet.entities[1]
      XCTAssert(entity.properties.count == 2)
    }
    catch {
      XCTFail()
    }
  }
  
  
  func testRequestValidEntitySetSingleQueryAsString() {
    
    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
    uriBuilder.filter("Country eq 'UK'")
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let entity = entitySet.entities[1]
      let id = entity.id
      let testID = NSURL(string:root + "/Customers" + "('BSBEV')")
      XCTAssert(id == testID)
      
      let property = entity.properties[7]
      checkPropertyValue(property,nameX:"Country",valX:"UK",tkX:"String")
      
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetMultipleQueryAsString() {
    
    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
    uriBuilder.filter("Country eq 'UK' and City eq 'London'")
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let entity = entitySet.entities[1]
      let id = entity.id
      let testID = NSURL(string:root + "/Customers" + "('BSBEV')")
      XCTAssert(id == testID)
      
      var property = entity.properties[7]
      checkPropertyValue(property,nameX:"Country",valX:"UK",tkX:"String")
      property = entity.properties[11]
      checkPropertyValue(property,nameX:"City",valX:"London",tkX:"String")
      
    }
    catch {
      XCTFail()
    }
  }
  
  


  func testRequestValidEntitySetQueryAsStringResultCount() {
    
    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    let numRecsReturned = 6
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
    uriBuilder.filter("Country eq 'UK' and City eq 'London'")
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      XCTAssert(entitySet.entities.count == numRecsReturned)
      
    }
    catch {
      XCTFail()
    }
  }
  


  
  func testRequestValidEntitySetAllTypesofParams() {
    
    let client:ODataClient = ODataClientFactory.getClient()
    let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
    let top = 2
    let page = 3
    let propertyFilter = "Country,City,CustomerID"
    let filter = "Country eq 'UK' and City eq 'London'"
    let order = "CustomerID desc"
    
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customers")
    uriBuilder.top(top)
    uriBuilder.skip(page-1*top)
    uriBuilder.orderBy(order)
    uriBuilder.select(propertyFilter)
    uriBuilder.filter(filter)
    
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      let entity = entitySet.entities[0]
      let id = entity.id
      let testID = NSURL(string:root + "/Customers('NORTS')")
      XCTAssert(id == testID)
      
      var property = entity.properties[0]
      checkPropertyValue(property,nameX:"CustomerID",valX:"NORTS",tkX:"String")
      property = entity.properties[1]
      checkPropertyValue(property,nameX:"Country",valX:"UK",tkX:"String")
      property = entity.properties[2]
      checkPropertyValue(property,nameX:"City",valX:"London",tkX:"String")
      XCTAssert(top == entitySet.entities.count)
    }
    catch {
      XCTFail()
    }
  }


  
  
  func executeAndBuild(client:ODataClient,uri:NSURL) -> ClientEntitySet? {
    
    let entitySetRequest = client.retrieveRequestFactory.entitySetRequest(uri)
    guard let response = entitySetRequest.execute() else {
      XCTFail()
      return nil
    }
    do {
      return try response.getBody()
    }
    catch {
      XCTFail()
      return nil
    }
    
  }
  
  

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    

}
