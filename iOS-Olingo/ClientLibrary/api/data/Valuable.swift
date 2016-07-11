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


  public var valueType:ValueType?  //G
  public var value: AnyObject?  //G
  public var type:String = ""  //GS
  
  // MARK: - Computed Properties


  // MARK: - Init

  
  // MARK: - Methods
  
  /**
   *
   * @param valueType
   * @param value value
   */ 
  /// Set value and value type.
  /// - parameters:
  ///   - valueType: value type
  ///   - value: value
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  public func setValue(valueType:ValueType, value: AnyObject) {
    self.valueType = valueType
    self.value = value
  }


  
  // TODO: isNil
  /// Check if according value is `null`
  /// - parameters:
  ///   - none
  /// - returns: `true` if value is `nil`, otherwise `false`
  /// - throws: No error conditions are expected
  
//  public func isNil() -> Bool {
//    return value == nil
//  }
  
  
  /// Check if Valuable contains a PRIMITIVE or COLLECTION_PRIMITIVE ValueType
  /// - parameters:
  ///   - none
  /// - returns: true if ValueType is a PRIMITIVE or COLLECTION_PRIMITIVE, otherwise false
  /// - throws: No error conditions are expected
  public func isPrimitive() -> Bool {
    return valueType == ValueType.PRIMITIVE || valueType == ValueType.COLLECTION_PRIMITIVE
  }
  
  /**
   *
   *
   * @return
   */
   
  /// Check if Valuable contains a GEOSPATIAL or COLLECTION_GEOSPATIAL ValueType
  /// - parameters:
  ///   - none
  /// - returns: true if ValueType is a GEOSPATIAL or COLLECTION_GEOSPATIAL, otherwise false
  /// - throws: No error conditions are expected
  public func isGeospatial() -> Bool {
    return valueType == ValueType.GEOSPATIAL || valueType == ValueType.COLLECTION_GEOSPATIAL
  }
  
  /// Check if Valuable contains a ENUM or COLLECTION_ENUM ValueType
  /// - parameters:
  ///   - none
  /// - returns: true if ValueType is a ENUM or COLLECTION_ENUM, otherwise false
  /// - throws: No error conditions are expected
  public func isEnum() -> Bool {
    return valueType == ValueType.ENUM || valueType == ValueType.COLLECTION_ENUM
  }
  

  /// Check if Valuable contains a COMPLEX or COLLECTION_COMPLEX ValueType
  /// - parameters:
  ///   - none
  /// - returns: true if ValueType is a COMPLEX or COLLECTION_COMPLEX, otherwise false
  /// - throws: No error conditions are expected
  public func isComplex() -> Bool {
    return valueType == ValueType.COMPLEX || valueType == ValueType.COLLECTION_COMPLEX
  }
  
  // TODO: unc isCollection() -> Bool
  /// Check if Valuable contains a COLLECTION_* ValueType
  /// - parameters:
  ///   - none
  /// - returns: true if ValueType is a COLLECTION_*, otherwise false
  /// - throws: No error conditions are expected
//  public func isCollection() -> Bool {
//    return valueType != nil && valueType != valueType.getBaseType()
//  }
  
  // TODO: asPrimitive()
  /// Get the value in its primitive representation or nil if it is not based on a primitive ValueType
  /// - parameters:
  ///   - none
  /// - returns: rimitive representation or null if it is not based on a primitive ValueType
  /// - throws: No error conditions are expected
//  public func asPrimitive() -> AnyObject {
//    return isPrimitive() && !isCollection() ? value : nil
//  }
  
  // TODO: asGeospatial() -> Geospatial
  /// Get the value in its geospatial representation or null if it is not based on a geospatial ValueType
  /// - parameters:
  ///   - none
  /// - returns: geospatial representation or null if it is not based on a geospatial ValueType
  /// - throws: No error conditions are expected
//  public  asGeospatial() -> Geospatial {
//    return isGeospatial() && !isCollection() ? (Geospatial) value : nil
//  }
  
  // TODO: unc asEnum() -> AnyObject
  /// Get the value in its enum representation or null if it is not based on a enum ValueType
  /// - parameters:
  ///   - none
  /// - returns: enum representation or null if it is not based on a enum ValueType
  /// - throws: No error conditions are expected
//  public func asEnum() -> AnyObject {
//    return isEnum() && !isCollection() ? value : nil
//  }
  
  // TODO: func asComplex() -> ComplexValue
  /// Get the value in its complex representation or null if it is not based on a complex ValueType
  /// - parameters:
  ///   - none
  /// - returns: primitive complex or null if it is not based on a complex ValueType
  /// - throws: No error conditions are expected
//  public func asComplex() -> ComplexValue {
//    return isComplex() && !isCollection() ? (ComplexValue) value : nil
//  }
  
  // TODO: func asCollection() ->List<?>
  /// Get the value as collection or null if it is not a collection ValueType
  /// - parameters:
  ///   - none
  /// - returns: collection or null if it is not a collection ValueType
  /// - throws: No error conditions are expected
//  public func asCollection() ->List<?> {
//    return isCollection() ? (List<?>) value : nil
//  }
  
  
  
  // TODO: func equals( o:Object) -> Bool
//  public func equals( o:Object) -> Bool {
//    if (this == o) {
//      return true
//    }
//    if (o == null || getClass() != o.getClass()) {
//      return false
//    }
//    
//    final Valuable other = (Valuable) o
//    return getAnnotations().equals(other.getAnnotations())
//      && (valueType == null ? other.valueType == null : valueType.equals(other.valueType))
//      && (value == null ? other.value == null : value.equals(other.value))
//      && (type == null ? other.type == null : type.equals(other.type))
//  }
  
  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    int result = getAnnotations().hashCode()
//    result = 31 * result + (valueType == null ? 0 : valueType.hashCode())
//    result = 31 * result + (value == null ? 0 : value.hashCode())
//    result = 31 * result + (type == null ? 0 : type.hashCode())
//    return result
//  }
  
  // TODO: func toString() -> String
//  public func toString() -> String {
//    return value == nil ? "nil" : value.toString()
//  }
}

