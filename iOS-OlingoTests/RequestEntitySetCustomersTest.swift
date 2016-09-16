//
//  RequestEntitySet.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 05/08/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
// 
import XCTest
@testable import iOS_Olingo


class RequestEntitySetCustomersTest: XCTestCase {
  
  let root = "http://services.odata.org/V4/Northwind/Northwind.svc"
  let client = ODataClientFactory.getClient()
  let entitySetValue = "Customers"
   
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
  
  
  func testRequestValidEntitySet() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
      checkPropertyValue(property,aName:"Phone",aVal:"(5) 555-3932",aTypeKind:"String")
    }
    catch {
      XCTFail()
    }
  }
  
  
  func testRequestValidEntitySetOrderedByCountryAsc() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
      checkPropertyValue(property,aName:"Country",aVal:"Argentina",aTypeKind:"String")
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetOrderedByCountryDesc() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
      checkPropertyValue(property,aName:"Country",aVal:"Venezuela",aTypeKind:"String")
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetNumRecordsToReturn() {
    let numRecs = 10
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
      checkPropertyValue(property,aName:"Country",aVal:"Mexico",aTypeKind:"String")
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetNumRecordsToReturnGrMax() {
    let numRecs = 100
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
    uriBuilder.top(numRecs)
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      
      let count = entitySet.entities.count
      XCTAssert(count == 20)
      
      
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetNumRecordsToReturnGrServicedefault() {
    let numRecs = 30
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
    uriBuilder.top(numRecs)
    do {
      let uri = try uriBuilder.build()
      guard let entitySet = executeAndBuild(client,uri:uri) else {
        XCTFail()
        return
      }
      
      let count = entitySet.entities.count
      XCTAssert(count == 20)
      
      
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetCount() {
    let numRecs = 91
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
    let numRecs = 10
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
      checkPropertyValue(property,aName:"Country",aVal:"Argentina",aTypeKind:"String")
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySkipAndTopRecordsToReturn() {
    let numRecs = 10
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
      checkPropertyValue(property,aName:"Country",aVal:"Argentina",aTypeKind:"String")
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetFilterSingleProperty() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
      checkPropertyValue(property,aName:"Country",aVal:"Mexico",aTypeKind:"String")
      
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetFilterMultipleProperties() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
      checkPropertyValue(property,aName:"CustomerID",aVal:"ANATR",aTypeKind:"String")
      property = entity.properties[1]
      checkPropertyValue(property,aName:"Country",aVal:"Mexico",aTypeKind:"String")
      
      
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetFilterMultiplePropertiesAsString() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
      checkPropertyValue(property,aName:"CustomerID",aVal:"ANATR",aTypeKind:"String")
      property = entity.properties[1]
      checkPropertyValue(property,aName:"Country",aVal:"Mexico",aTypeKind:"String")
      
      
    }
    catch {
      XCTFail()
    }
  } 
  
  func testRequestValidEntitySetFilterCheckNumberMultipleProperties() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
      checkPropertyValue(property,aName:"Country",aVal:"UK",aTypeKind:"String")
      
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestValidEntitySetMultipleQueryAsString() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
      checkPropertyValue(property,aName:"Country",aVal:"UK",aTypeKind:"String")
      property = entity.properties[11]
      checkPropertyValue(property,aName:"City",aVal:"London",aTypeKind:"String")
      
    }
    catch {
      XCTFail()
    }
  }
  
    
  func testRequestValidEntitySetQueryAsStringResultCount() {
    let numRecsReturned = 6
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
    let top = 2
    let page = 3
    let propertyFilter = "Country,City,CustomerID"
    let filter = "Country eq 'UK' and City eq 'London'"
    let order = "CustomerID desc"
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
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
      checkPropertyValue(property,aName:"CustomerID",aVal:"NORTS",aTypeKind:"String")
      property = entity.properties[1]
      checkPropertyValue(property,aName:"Country",aVal:"UK",aTypeKind:"String")
      property = entity.properties[2]
      checkPropertyValue(property,aName:"City",aVal:"London",aTypeKind:"String")
      XCTAssert(top == entitySet.entities.count)
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestInvalidEntitySet() {
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment("Customer")
    do {
      let uri = try uriBuilder.build()
      
      guard let response = client.retrieveRequestFactory.entitySetRequest(uri).execute() else {
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
  
  func testRequestInvalidEntitySetOrderBy() {
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
    uriBuilder.orderBy("Countries")
    do {
      let uri = try uriBuilder.build()
      
      guard let response = client.retrieveRequestFactory.entitySetRequest(uri).execute() else {
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
  
  func testRequestInvalidEntitySetOrderByDesc() {
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
    uriBuilder.orderBy("Country des")
    do {
      let uri = try uriBuilder.build()
      
      guard let response = client.retrieveRequestFactory.entitySetRequest(uri).execute() else {
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
  
  func testRequestInvalidEntitySetNumRecordsToReturn0() {
    
    let numRecs = 0
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
    uriBuilder.top(numRecs)
    do {
      let uri = try uriBuilder.build()
      
      guard let response = client.retrieveRequestFactory.entitySetRequest(uri).execute() else {
        XCTFail()
        return
      }
      XCTAssert(response.statusCode == 200)
      do {
        guard let body = try response.getBody() else {
          XCTAssert(true)
          return
        }
      }
      catch {
        XCTFail()
      }
      
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestInvalidEntitySetRecCount() {
    
    let numRecs = 0
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
    uriBuilder.count(false)
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
  
  func testRequestInvalidEntitySetSkip() {
    
    let numRecs = 100
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
    uriBuilder.skip(numRecs)
    do {
      let uri = try uriBuilder.build()
      
      guard let response = client.retrieveRequestFactory.entitySetRequest(uri).execute() else {
        XCTFail()
        return
      }
      XCTAssert(response.statusCode == 200)
      do {
        guard let body = try response.getBody() else {
          XCTAssert(true)
          return
        }
      }
      catch {
        XCTFail()
      }
      
    }
    catch {
      XCTFail()
    }
  }
  
  func testRequestInvalidEntityFilter() {
    
    let numRecs = 100
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
    uriBuilder.select("Countries")
    do {
      let uri = try uriBuilder.build()
      
      guard let response = client.retrieveRequestFactory.entitySetRequest(uri).execute() else {
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
  
  func testRequestInvalidEntityQueryOperator() {
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
    uriBuilder.filter("Country e 'UK'")
    do {
      let uri = try uriBuilder.build()
      
      guard let response = client.retrieveRequestFactory.entitySetRequest(uri).execute() else {
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
  
  func testRequestInvalidEntityQueryProperty() {
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
    uriBuilder.filter("Countries eq 'UK'")
    do {
      let uri = try uriBuilder.build()
      
      guard let response = client.retrieveRequestFactory.entitySetRequest(uri).execute() else {
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
  
  
  func testRequestInvalidEntityQueryValue() {
    
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    uriBuilder.appendEntitySetSegment(entitySetValue)
    uriBuilder.filter("Countries eq 'U'")
    do {
      let uri = try uriBuilder.build()
      
      guard let response = client.retrieveRequestFactory.entitySetRequest(uri).execute() else {
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
  
  
  func executeAndBuild(client:ODataClient,uri:NSURL) -> ClientEntitySet? {
    
    let entitySetRequest = client.retrieveRequestFactory.entitySetRequest(uri)
    
    guard let response = entitySetRequest.execute() else {
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
