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
//  ClientPrimitiveValueImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class ClientPrimitiveValueImpl: AbstractClientValue, ClientPrimitiveValue {
  
  // MARK: - Stored Properties

  /// Type kind
  public var typeKind:EdmPrimitiveTypeKind?  //G
  
  /// Type
  public var type:EdmPrimitiveType?  //G
  
  /// Actual value
  public var value:Any?  //G
  
  
  // MARK: - Computed Properties
  
  override public var isComplex: Bool {
    return false
  }
  
  override public var isEnum: Bool {
    return false
  }
  
  override public var asEnum: ClientEnumValue? {
    return nil
  }
  
  //TODO: typename exist in superclass but we are getting it from typekind??
//  public var typeName {
//    get{
//      return typeKind.getFullQualifiedName().toString()
//    }
//  }
  

  // MARK: - Init

  init() {
    super.init(typeName: nil)
  }
  
  // MARK: - Methods
  
  // TODO: func getTypeName() -> String
  /*
   public func getTypeName() -> String {
   return typeKind.getFullQualifiedName().toString()
   }
   */
  
  // TODO: func toCastValue<T>(reference:T ) throws -> T
  //  public func toCastValue<T>(reference:T ) throws -> T {
  //  //public <T> T toCastValue(final Class<T> reference) throws EdmPrimitiveTypeException {
  //    if (typeKind.isGeospatial()) {
  //      return reference.cast(value)
  //    } else {
  //      // TODO: set facets
  //      return type.valueOfString(type.valueToString(value,nil, nil,DEFAULT_PRECISION, DEFAULT_SCALE, nil),nil, nil, DEFAULT_PRECISION, DEFAULT_SCALE, nil, reference)
  //    }
  //  }
  
  // TODO: func toString() -> String
  //  public func toString() -> String {
  //    if (value == nil) {
  //      return ""
  //    } else if (typeKind.isGeospatial()) {
  //      return value.toString()
  //    } else {
  //      try {
  //        // TODO: set facets
  //        return type.valueToString(value, nil, nil, Constants.DEFAULT_PRECISION, Constants.DEFAULT_SCALE, nil)
  //      }
  //      catch (EdmPrimitiveTypeException e) {
  //        throw new IllegalArgumentException(e)
  //      }
  //    }
  //  }

  //TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    final int prime = 31
//    int result = super.hashCode()
//    result = prime * result + ((type == nil) ? 0 : type.hashCode())
//    result = prime * result + ((typeKind == nil) ? 0 : typeKind.hashCode())
//    result = prime * result + ((value == nil) ? 0 : value.hashCode())
//    return result
//  }
  
  
  public override func equals(obj: AnyObject) -> Bool {
    if self  === obj {
      return true
    }
    else {
      return false
      // TODO: additional comparisons between objects
      /*
      if (!super.equals(obj)) {
        return false
      }
      if (!(obj instanceof ClientPrimitiveValueImpl)) {
        return false
      }
      ClientPrimitiveValueImpl other = (ClientPrimitiveValueImpl) obj
      if (type == nil) {
        if (other.type != nil) {
          return false
        }
      } else if (!type.equals(other.type)) {
        return false
      }
      if (typeKind != other.typeKind) {
        return false
      }
      if (value == nil) {
        if (other.value != nil) {
          return false
        }
      } else if (!value.equals(other.value)) {
        return false
      }
      return true
       */
    }
  }
  
  
    
}
