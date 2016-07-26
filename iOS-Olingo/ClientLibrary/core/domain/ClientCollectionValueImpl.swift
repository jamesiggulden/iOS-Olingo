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
//  ClientCollectionValueImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 13/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class ClientCollectionValueImpl<OV:ClientValue> :AbstractClientValue , ClientCollectionValue {
  
  // MARK: - Stored Properties
  
  /// Values
  var  values:[OV] = []

  // MARK: - Computed Properties
  public var isEnum:Bool {
    get {
      return false
    }
  }
  
  public override var isComplex: Bool {
    get {
      return false
    }
  }
  

  // MARK: - Init

  override init(typeName:String?) {
    guard let typeName = typeName else {
      super.init(typeName: nil)
      return
    }
    super.init(typeName: typeName.containsString("Collection(") ? typeName : "Collection(" + typeName + ")")
  }

  
  // MARK: - Methods
  
  public func asEnum() -> ClientEnumValue? {
    return nil
  }
  
  
  
  
  
  public func asSwiftCollection() -> [Any]  {
    var result:[Any] = []
    for value in values {
      if (value.isPrimitive) {
        result.append(value.asPrimitive!.value)
      } else if (value.isComplex) {
        result.append(value.asComplex!.asSwiftMap())
      } else if (value.isCollection) {
        result.append(value.asCollection!.asSwiftCollection())
      } else if (value.isEnum()) {
        result.append(value.asEnum().toString())
      }
    }
    
    return result
  }
  
  /// Adds a value to the collection
  /// - parameters:
  ///   - value: new value to add
  /// - returns: self
  /// - throws: No error conditions are expected
  public func add(value:ClientValue) -> ClientCollectionValue {
    values.append(value as! OV)
    return self
  }
  

  /// Gets number of items in collection
  /// - parameters:
  ///   - none
  /// - returns: number of items
  /// - throws: No error conditions are expected
  public func size() -> Int {
    return values.count
  }
  
   
  /// Checks if collection is empty
  /// - parameters:
  ///   - none
  /// - returns: `true` if empty `false` otherwise
  /// - throws: No error conditions are expected
  public func isEmpty() -> Bool {
    return values.isEmpty
  }
  
  //TODO: func hashCode() -> Int
  /*
  public func hashCode() -> Int {
    final int prime = 31
    int result = super.hashCode()
    result = prime * result + ((values == null) ? 0 : values.hashCode())
    return result
  }
  */
  
  
  public override func equals( obj:AnyObject) -> Bool {
    if (self === obj) {
      return true
    }
    else {
      return false
      //TODO: Add extra checks
      /*
      if (!super.equals(obj)) {
        return false
      }
      if (!(obj instanceof ClientCollectionValueImpl)) {
        return false
      }
      ClientCollectionValueImpl<?> other = (ClientCollectionValueImpl<?>) obj
      if (values == null) {
        if (other.values != null) {
          return false
        }
      } else if (!values.equals(other.values)) {
        return false
      }
      return true
      */
    }
        
  }
  
  
  public override func toString() -> String {
    return "ClientCollectionValueImpl [values=\(values)super[\(super.toString())]]"
  }
}
