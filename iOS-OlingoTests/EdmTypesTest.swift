//
//  EdmTypes.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 08/08/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import XCTest
@testable import iOS_Olingo

class EdmTypes: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  func testEdmDecimalConvertToFloat() {
    
    let edmDec = EdmDecimal()
    let flt:Float = 0.0
    let val = NSDecimalNumber.init(string: "123.456")
    do {
      let answer = try edmDec.convertDecimal(val, returnType: flt)
      XCTAssert(answer == 123.456)
    }
    catch {
      XCTFail()
    }
    
  }
  
  func testEdmDecimalConvertToDecimal() {
  
    let edmDec = EdmDecimal()
    let dec:NSDecimalNumber = 0.0
    let val = NSDecimalNumber.init(string: "123.456")
    do {
      let answer = try edmDec.convertDecimal(val, returnType: dec)
      XCTAssert(answer == val)
    }
    catch {
      XCTFail()
    }
    
  }
  
  func testEdmDecimalConvertToDbl() {
    
    let edmDec = EdmDecimal()
    let dbl:Double = 0.0
    let val = NSDecimalNumber.init(string: "123.456")
    do {
      let answer = try edmDec.convertDecimal(val, returnType: dbl)
      XCTAssert(answer == 123.456)
    }
    catch {
      XCTFail()
    }
  }
  
  func testEdmDecimalConvertToInt() {
    
    let edmDec = EdmDecimal()
    let int:Int = 0
    let val = NSDecimalNumber.init(string: "123.456")
    do {
      let answer = try edmDec.convertDecimal(val, returnType: int)
      XCTAssert(answer == 123)
    }
    catch {
      XCTFail()
    }
    
  }

    func testEdmDoubleToDouble() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      let edmDbl = EdmDouble()
      let dbl:Double = 0.0
      
      do{
        let newVal = try edmDbl.internalValueOfString("123.456", isnilable: true, maxLength: 40, precision: 40, scale: 0, isUnicode: true, returnType: dbl)
        XCTAssert(newVal.dynamicType == Double.self)
        XCTAssert(newVal == 123.456)
      }
      catch {
        XCTFail()
      }
    }
  
  
  func testEdmDoubleToFloat() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    let edmDbl = EdmDouble()
    let flt:Float = 0.0
    
    do{
      let newVal = try edmDbl.internalValueOfString("123.456", isnilable: true, maxLength: 40, precision: 40, scale: 0, isUnicode: true, returnType: flt)
      XCTAssert(newVal.dynamicType == Float.self)
      XCTAssert(newVal == 123.456)
    }
    catch {
      XCTFail()
    }
    
    
  }
  
  func testEdmDoubleToInt() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    let edmDbl = EdmDouble()
    let int:Int = 0
    
    do{
      let newVal = try edmDbl.internalValueOfString("123.456", isnilable: true, maxLength: 40, precision: 40, scale: 0, isUnicode: true, returnType: int)
      XCTAssert(newVal.dynamicType == Int.self)
      XCTAssert(newVal == 123)
    }
    catch {
      XCTFail()
    }
  }
  
  func testEdmDoubleToDecimal() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    let edmDbl = EdmDouble()
    let dec:NSDecimalNumber = NSDecimalNumber(double: 0.0)
    
    do{
      let newVal = try edmDbl.internalValueOfString("123.456", isnilable: true, maxLength: 40, precision: 40, scale: 0, isUnicode: true, returnType: dec)
      XCTAssert(newVal.dynamicType == NSDecimalNumber.self)
      
      //let result = newVal.compare(123.456).rawValue
      let newDecNumber = NSDecimalNumber.init(string: "123.456")
      XCTAssert(newVal == newDecNumber)
    }
    catch {
      XCTFail()
    }
  }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
