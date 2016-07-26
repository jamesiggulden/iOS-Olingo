/*
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with this work for additional information
  regarding copyright ownership.  The ASF licenses this file
  to you under the Apache License, Version 2.0 (the
  "License") you may not use this file except in compliance
  with the License.  You may obtain a copy of the License at
 
    http://www.apache.org/licenses/LICENSE-2.0
 
  Unless required by applicable law or agreed to in writing,
  software distributed under the License is distributed on an
  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  KIND, either express or implied.  See the License for the
  specific language governing permissions and limitations
  under the License.
 */



//
//  Valuable.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * Defines a value with an according type.
 */
// TODO: This should be Abstract class
public class Valuable {  //: Annotatable {
  
  // MARK: - Stored Properties

  public var valueType:ValueType?

  //public var valueType:ValueType = ValueType(baseType: ValueType.PRIMITIVE)  //G
  public var value: Any?  //G
  public var type:String = ""  //GS
  
  // MARK: - Computed Properties
  
  /// Check if according value is `nil`
  public var isNil: Bool {
    return value == nil
  }
  
  /// Check if Valuable contains a PRIMITIVE or COLLECTION_PRIMITIVE ValueType
  public var isPrimitive:Bool {
    get {
      return valueType == ValueType.PRIMITIVE || valueType == ValueType.COLLECTION_PRIMITIVE
    }
  }
  
  /// Check if Valuable contains a GEOSPATIAL or COLLECTION_GEOSPATIAL ValueType
  public var isGeospatial:Bool {
    get {
      return valueType == ValueType.GEOSPATIAL || valueType == ValueType.COLLECTION_GEOSPATIAL
    }
  }
  
  /// Check if Valuable contains a ENUM or COLLECTION_ENUM ValueType
  public var isEnum:Bool {
    get {
      return valueType == ValueType.ENUM || valueType == ValueType.COLLECTION_ENUM
    }
  }
  
  /// Check if Valuable contains a COMPLEX or COLLECTION_COMPLEX ValueType
  public var isComplex:Bool {
    get {
      return valueType == ValueType.COMPLEX || valueType == ValueType.COLLECTION_COMPLEX
    }
  }
  
  /// Check if Valuable contains a COLLECTION_* ValueType
  public var isCollection: Bool {
    get{
      if let valueType = valueType {
        return valueType.rawValue > 10
      }
      else {
        return false
      }
    }
  }
  
  /// Get the value in its primitive representation or nil if it is not based on a primitive ValueType
  public var asPrimitive: Any? {
    if isPrimitive && !isCollection {
      return value
    }
    else {
      return  nil
    }
    
  }

  /// Get the value in its enum representation or nil if it is not based on a enum ValueType
  public var asEnum: Any? {
    if isEnum && !isCollection {
      return value
    }
    else {
      return nil
    }
  }
  
  /// Get the value in its complex representation or nil if it is not based on a complex ValueType
  public var asComplex: ComplexValue? {
    if isComplex && !isCollection {
      return value as! ComplexValue
    }
    else {
      return nil
    }
  }

  /// Get the value in its geospatial representation or null if it is not based on a geospatial ValueType
  public func  asGeospatial() -> Geospatial? {
    if isGeospatial && !isCollection {
      return value as! Geospatial
    }
    else {
      return nil
    }
  }

  /// Get the value as collection or null if it is not a collection ValueType

  public var asCollection: [Any]? {
    if isCollection {
      return value as! [Any]
    }
    else {
      return nil
    }
  }

  // MARK: - Init

  
  // MARK: - Methods
  

  /// Set value and value type.
  /// - parameters:
  ///   - valueType: value type
  ///   - value: value
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  public func setValue(valueType:ValueType, value: Any) {
    self.valueType = valueType
    self.value = String(value)
  }


  public func equals( o:AnyObject) -> Bool {
    if (self  === o) {
      return true
    }
    else {
      return false
      // TODO: Add extra checks
      /*
      if (o == nil || getClass() != o.getClass()) {
        return false
      }
      final Valuable other = (Valuable) o
      return getAnnotations().equals(other.getAnnotations())
        && (valueType == null ? other.valueType == null : valueType.equals(other.valueType))
        && (value == null ? other.value == null : value.equals(other.value))
        && (type == null ? other.type == null : type.equals(other.type))
      */
    }
    
    
  }
  
  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    int result = getAnnotations().hashCode()
//    result = 31 * result + (valueType == null ? 0 : valueType.hashCode())
//    result = 31 * result + (value == null ? 0 : value.hashCode())
//    result = 31 * result + (type == null ? 0 : type.hashCode())
//    return result
//  }
  

  public func toString() -> String {
    if let value = value {
      return String(value)
    }
    else {
      return ""
    }
    //return value == nil ? "nil" : String(value)  //.toString()
  }
}

