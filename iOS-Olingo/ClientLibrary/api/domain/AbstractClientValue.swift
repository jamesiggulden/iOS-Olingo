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
//  AbstractClientValue.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class AbstractClientValue: ClientValue {
  
  // MARK: - Stored Properties

  /// Type name
  public let typeName:String? // G
  
  // MARK: - Computed Properties
  
  public var isPrimitive: Bool {
    get {
      return self is ClientPrimitiveValue
    }
  }
  
  /// Casts to primitive value
  public var asPrimitive: ClientPrimitiveValue? {
    get {
      if isPrimitive {
        let val = self as! ClientPrimitiveValue
        return val
      }
      else {
        return nil
      }
    }
  }
  
  /// Check is a complex value
  public var isComplex: Bool {
    get {
      return (self is ClientComplexValue)
    }
  }
  
  
  /// Casts to complex value
  public var asComplex: ClientComplexValue?  {
    get {
      if isComplex {
        return self as? ClientComplexValue
      }
      else {
        return nil
      }
    }
  }
  
  /// Check is a collection value
  public var isCollection: Bool {
    get {
      return (self is ClientCollectionValue)
    }
  }
  
  // Cast as collection Value
  public  var  asCollection: ClientCollectionValue? {
    return isCollection ?  self as? ClientCollectionValue : nil
  }
  
  /// Check is a collection value
  public var isEnum: Bool {
    get {
      return (self is ClientEnumValue)
    }
  }
  
  // Cast as collection Value
  public  var  asEnum: ClientEnumValue? {
    return isEnum ?  self as? ClientEnumValue : nil
  }


  // MARK: - Init

  init(typeName: String?) {
    self.typeName = typeName
  }
  
  // MARK: - Methods
  
  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    final int prime = 31
//    int result = 1
//    result = prime * result + ((typeName == nil) ? 0 : typeName.hashCode())
//    return result
//  }
  
   
  /// Retrun string representation of the object
  /// - parameters:
  ///   - none:
  /// - returns: String representation of object
  /// - throws: No error conditions are expected
  public func toString() -> String {
    return "AbstractClientValue [typeName=\(typeName)]"
  }
}

// MARK: - Extension

extension AbstractClientValue: Equatable {}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:AbstractClientValue,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is AbstractClientValue) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? AbstractClientValue else {
    return false
  }
  if lhs === rhs {
    return true
  }
  if (lhs.typeName == nil) {
    if (rhs.typeName != nil) {
      return false
    }
  } else if lhs.typeName != rhs.typeName {
    return false
  }
  return true
}

