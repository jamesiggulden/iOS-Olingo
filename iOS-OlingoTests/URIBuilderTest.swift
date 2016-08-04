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
  
  func encodeURL(uri:String) -> NSURL {
    let escapedTest = uri.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
    return NSURL(string:escapedTest!)!
  }
  
  func testRootBuild() {
    let uriBuilder = client.newURIBuilder(root)
    do {
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root)
      XCTAssert(uri == testUrl)
    }
    catch {
      
    }
  }
  
  func testEntitySetBuild() {
    let uriBuilder = client.newURIBuilder(root)
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root+"/Customers")
      XCTAssert(uri == testUrl)
    }
    catch {
      
    }
  }
  
  func testAppendMultiEntitySetBuild() {
    let uriBuilder = client.newURIBuilder(root)
    do {
      var uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      uriBuilder = uriBuilder.appendEntitySetSegment("Orders")
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root+"/Customers/Orders")
      XCTAssert(uri == testUrl)
    }
    catch {
      
    }
  }
  
  func testEmptyEntitySetBuild() {
    let uriBuilder = client.newURIBuilder(root)
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("")
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root)
      XCTAssert(uri == testUrl)
    }
    catch {
      
    }
  }
  
  
  func testAppendKeySegmentWhenString() {
    let uriBuilder = client.newURIBuilder(root)
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      uriBuilder.appendKeySegment("'BOTTM'")
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root + "/Customers" + "('BOTTM')")
      XCTAssert(uri == testUrl)
    }
    catch {
      
    }
  }
  
  
  func testAppendKeySegmentDblQuotesWhenString() {
    let uriBuilder = client.newURIBuilder(root)
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      uriBuilder.appendKeySegment("\"BOTTM\"")
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root + "/Customers" + "('BOTTM')")
      XCTAssert(uri == testUrl)
    }
    catch {
      
    }
  }
  
  func testAppendKeySegmentNoQuotesWhenString() {
    let uriBuilder = client.newURIBuilder(root)
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      uriBuilder.appendKeySegment("BOTTM")
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root + "/Customers" + "('BOTTM')")
      XCTAssert(uri == testUrl)
    }
    catch {
      
    }
  }

  func testAppendKeySegmentByPropertyWhenString() {
    let uriBuilder = client.newURIBuilder(root)
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let id = "BOTTM"
      uriBuilder.appendKeySegment(id)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root + "/Customers" + "('BOTTM')")
      XCTAssert(uri == testUrl)
    }
    catch {
      
    }
  }
  
  func testAppendKeySegmentByPropertyWhenStringWithSingleQuotes() {
    let uriBuilder = client.newURIBuilder(root)
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let id = "'BOTTM'"
      uriBuilder.appendKeySegment(id)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root + "/Customers" + "('BOTTM')")
      XCTAssert(uri == testUrl)
    }
    catch {
      
    }
  }

  func testAppendKeySegmentWhenNumeric() {
    let uriBuilder = client.newURIBuilder(root)
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      uriBuilder.appendKeySegment(27)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root + "/Customers" + "(27)")
      XCTAssert(uri == testUrl)
    }
    catch {
      
    }
  }
  
  func testAppendKeySegmentByPropertyWhenNumeric() {
    let uriBuilder = client.newURIBuilder(root)
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let id = 27
      uriBuilder.appendKeySegment(id)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root + "/Customers" + "(27)")
      XCTAssert(uri == testUrl)
    }
    catch {
      
    }
  }
  
  func testAppendKeySegmentByPropertyWhenStringEmpty() {
    let uriBuilder = client.newURIBuilder(root)
    do {
      let uriBuilder = uriBuilder.appendEntitySetSegment("Customers")
      let id:String = ""
      uriBuilder.appendKeySegment(id)
      let uri = try uriBuilder.build()
      let testUrl = encodeURL(root)
      XCTAssert(uri == testUrl)
    }
    catch {
      
    }
  }
  
  

    func testURIAddTopToRoot() {
      
      let uriBuilder = client.newURIBuilder(root)
      do {
        let uri = try uriBuilder.top(10).build()
        let test = root + "?" + "$top=10"
        let testURL = encodeURL(test)
        XCTAssert(uri == testURL)
      }
      catch {
        
      }
    }
  
  func testURIAddTopToRootwithExisting() {
    let rootPlus = root + "?$skip=5"
    let uriBuilder = client.newURIBuilder(rootPlus)
    do {
      let uri = try uriBuilder.top(10).build()
      let test = rootPlus + "?$top=10"
      let escapedTest = test.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
      let testURL = NSURL(string:escapedTest!)
      XCTAssert(uri == testURL)
    }
    catch {
      
    }
  }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
