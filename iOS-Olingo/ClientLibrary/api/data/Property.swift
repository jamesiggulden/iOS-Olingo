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
//  Property.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * Data representation for a property.
 */
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
  
  // TODO: func equals(o:Object) -> Bool
//  public func equals(o:Object) -> Bool {
//    return super.equals(o)
//      && (name == nil ? ((Property) o).name == null : name.equals(((Property) o).name))
//  }
  
  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    int result = super.hashCode()
//    result = 31 * result + (name == null ? 0 : name.hashCode())
//    return result
//  }
  
 
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
