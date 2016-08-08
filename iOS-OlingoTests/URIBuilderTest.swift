//
//  URIBuilder.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 04/08/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import XCTest
@testable import iOS_Olingo

class URIBuilderTest: XCTestCase {
  
  let client:ODataClient = ODataClientFactory().getClient()
  let root = "http://services.odata.org/V4/Northwind/Northwind.svc"

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
  
  func testRootBuild() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root)
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  func testEmptyRootBuild() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root)
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  // test to check if root is checked for validity
  // currently no check performed
  func testInvalidRootBuild() {
    let invalidRoot = "h;/anayay"
    guard let uriBuilder = client.newURIBuilder(invalidRoot) else {
      XCTFail()
      return
    }
    do {
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(invalidRoot)
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }

  
  func testEntitySetBuild() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root+"/Customers")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  func testAppendMultiEntitySetBuild() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      var uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      uriBuilder = uriBuilder.appendEntitySetSegment("Orders")
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root+"/Customers/Orders")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  func testEmptyEntitySetBuild() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("")
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root)
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  
  func testAppendKeySegmentWhenString() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      uriBuilder.appendKeySegment("'BOTTM'")
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root + "/Customers" + "('BOTTM')")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  
  func testAppendKeySegmentDblQuotesWhenString() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      uriBuilder.appendKeySegment("\"BOTTM\"")
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root + "/Customers" + "('BOTTM')")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  func testAppendKeySegmentNoQuotesWhenString() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      uriBuilder.appendKeySegment("BOTTM")
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root + "/Customers" + "(BOTTM)")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }

  func testAppendKeySegmentByPropertyWhenString() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let id = "BOTTM"
      uriBuilder.appendKeySegment(id)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root + "/Customers" + "(BOTTM)")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  func testAppendKeySegmentByPropertyWhenStringWithSingleQuotes() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let id = "'BOTTM'"
      uriBuilder.appendKeySegment(id)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root + "/Customers" + "('BOTTM')")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }

  func testAppendKeySegmentWhenNumeric() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      uriBuilder.appendKeySegment(27)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root + "/Customers" + "(27)")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  func testAppendKeySegmentByPropertyWhenNumeric() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let id = 27
      uriBuilder.appendKeySegment(id)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root + "/Customers" + "(27)")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  func testAppendKeySegmentByPropertyWhenStringEmpty() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let id:String = ""
      uriBuilder.appendKeySegment(id)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root+"/Customers")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  func testAppendFilter() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let filter:String = "Country eq 'UK'"
      uriBuilder.filter(filter)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root+"/Customers?$filter=Country eq 'UK'")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  func testAppendEmptyFilter() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let filter:String = ""
      uriBuilder.filter(filter)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root+"/Customers")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  func testAppendSelect() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let select:String = "Country"
      uriBuilder.select(select)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root+"/Customers?$select=Country")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  func testAppendEmptySelect() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let select:String = ""
      uriBuilder.select(select)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root+"/Customers")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }

  func testAppendOrderBy() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let order:String = "Country"
      uriBuilder.orderBy(order)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root+"/Customers?$orderby=Country")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }
  
  func testAppendEmptyOrderBy() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let order:String = ""
      uriBuilder.orderBy(order)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root+"/Customers")
      XCTAssert(uri == testUrl)
    }
    catch {
      XCTFail()
    }
  }

  
  
  

  func testURIAddSkip() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uri = try uriBuilder.skip(10).build()
      let test = root + "?" + "$skip=10"
      let testURL = encodeURL(test)
      XCTAssert(uri == testURL)
    }
    catch {
      XCTFail()
    }
  }

  func testURIAddTopToRoot() {
    guard let uriBuilder = client.newURIBuilder(root) else {
      XCTFail()
      return
    }
    do {
      let uri = try uriBuilder.top(10).build()
      let test = root + "?" + "$top=10"
      let testURL = encodeURL(test)
      XCTAssert(uri == testURL)
    }
    catch {
      XCTFail()
    }
  }

  func testURIAddTopToRootwithExisting() {
    let rootPlus = root + "?$skip=5"
    guard let uriBuilder = client.newURIBuilder(rootPlus) else {
      XCTFail()
      return
    }
    do {
      let uri = try uriBuilder.top(10).build()
      let test = rootPlus + "?$top=10"
      let testURL = encodeURL(test)
      XCTAssert(uri == testURL)
    }
    catch {
      XCTFail()
    }
  }
  
  func encodeURL(uri:String) -> NSURL {
    let escapedTest = uri.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
    return NSURL(string:escapedTest!)!
  }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
