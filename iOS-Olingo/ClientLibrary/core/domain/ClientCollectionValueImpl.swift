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
  override public var isEnum:Bool {
    get {
      return false
    }
  }
  
  /// Checks if is complex type
  public override var isComplex: Bool {
    get {
      return false
    }
  }
  
  /// Return value as Enum type
  override public var asEnum: ClientEnumValue? {
    return nil
  }
  
  /// Gets number of items in collection
  public var size:Int {
    return values.count
  }
  
  /// Checks if collection is empty
  public var isEmpty: Bool {
    return values.isEmpty
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
  
  /// Build array of native swift types
  /// - parameters:
  ///   - none
  /// - returns: array of native types
  /// - throws: No error conditions are expected
  public func asNativeTypeCollection() -> [Any]  {
    var result:[Any] = []
    for value in values {
      if (value.isPrimitive) {
        result.append(value.asPrimitive!.value)
      } else if (value.isComplex) {
        result.append(value.asComplex!.asNativeTypeMap())
      } else if (value.isCollection) {
        result.append(value.asCollection!.asNativeTypeCollection())
      } else if (value.isEnum) {
        result.append(value.asEnum!.toString())
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
  
  public override func toString() -> String {
    return "ClientCollectionValueImpl [values=\(values)super[\(super.toString())]]"
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

}

// MARK: - Extension

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T,OV:ClientValue>(lhs:ClientCollectionValueImpl<OV>,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is ClientCollectionValueImpl<OV>) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? ClientCollectionValueImpl<OV> else {
    return false
  }
  if lhs === rhs {
    return true
  }
  
  let lhsSuper = lhs as AbstractClientValue
  let rhsSuper = rhs as AbstractClientValue
  if lhsSuper != rhsSuper {
    return false
  }
  // TODO: equality check
  /*
  if lhs.values != rhs.values {
    return false
  }
  */
  return true
}
