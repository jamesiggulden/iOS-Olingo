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

// Implementation based on Olingo's original java V4 implmentation.  Further details can be found at http://olingo.apache.org

//
//  Property.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Data representation for a property
public class Property : Valuable {
  
  // MARK: - Stored Properties

  public var name:String = ""
  
  // MARK: - Computed Properties

  // MARK: - Init

  override init() {
    super.init()
  }
  
  /// Creates a new property
  /// - parameters:
  ///   - type: String representation of type (can be nil)
  ///   - name: Name of the property
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  init(type:String,  name:String) {
    super.init()
    self.name = name
    super.type = type
  }
   
  /// creates a new property
  /// - parameters:
  ///   - type: String representation of type (can be nil)
  ///   - name: Name of the property
  ///   - valueType: Kind of the property e.g. primitive property, complex property
  ///   - value: Value of the property
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  init(type:String, name:String, valueType:ValueType, value:AnyObject) {
    super.init()
    self.name = name
    super.type = type
    setValue(valueType, value: value)
  }
  
  
  // MARK: - Methods
 
  /// Check if this property is `null` (`value == nil`) or the type is `"Edm.Null"`
  /// - parameters:
  ///   - none
  /// - returns: `true` if this property is `nil` (value == nil) or the type is `"Edm.Nil"`. Otherwise `false`
  /// - throws: No error conditions are expected
  public func isNil()-> Bool {
    return self.value == nil || "Edm.Nil" == self.type
  }
  
  
  // TODO: func hashCode() -> Int
  /*
  public func hashCode() -> Int {
    int result = super.hashCode()
    result = 31 * result + (name == null ? 0 : name.hashCode())
    return result
  }
  */
  
 
  /// Generate string representation of name = value for property
  /// - parameters:
  ///   - none
  /// - returns: String in format `name = value`
  /// - throws: No error conditions are expected
  public override func toString() -> String {
    var val = "nil"
    var nam = "nil"
    if let value = self.value {
      val = value as! String
    }
    if !self.name.isEmpty {
      nam = name
    }
    
    return nam + "=" + val
  }
}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:Property,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is Property) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? Property else {
    return false
  }
  if lhs === rhs {
    return true
  }
  
  let lhsSuper = lhs as Valuable
  let rhsSuper = rhs as Valuable
  
  if lhsSuper == rhsSuper {
    if  (lhs.name.isEmpty ? rhs.name.isEmpty : lhs.name == rhs.name){
      return true
    }
  }
  return false
}
