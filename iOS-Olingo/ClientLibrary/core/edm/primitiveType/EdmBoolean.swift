/*
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with this work for additional information
  regarding copyright ownership.  The ASF licenses this file
  to you under the Apache License, Version 2.0 (the
  "License"); you may not use this file except in compliance
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
//  File.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/08/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * Implementation of the EDM primitive type Boolean.
 */
public final class EdmBoolean: SingletonPrimitiveType {
  
  // MARK: - Stored Properties

  private let INSTANCE = EdmBoolean()
  
  // MARK: - Computed Properties


  public var instance: EdmBoolean {
    return INSTANCE
  }
  
  public override var defaultType: Any { // Class<?> {
    return Bool.self
  }
  
  // MARK: - Init

  // MARK: - Methods

  public func validate(value:String?,isNilable:Bool?, maxLength:Int, precision:Int,scale:Int, isUnicode:Bool) -> Bool {
    
    return value == nil ? isNilable == nil || isNilable! : validateLiteral(value!)
  }
  
  private func validateLiteral(value:String) -> Bool {
    return ("true" == value || "false" == value)
  }
  
  override func internalValueOfString<T>(value:String,isnilable:Bool,maxLength:Int?,precision:Int,scale:Int,isUnicode:Bool,returnType:T) throws -> T {
  
    if (validateLiteral(value)) {
      if returnType is Bool {
        // no direct method to get bool value so cast as NSNumber first
        // will return false for all non bool descriptive strings
        return (value as NSString).boolValue as! T
        //return returnType.cast(Boolean.valueOf("true".equals(value)))
      } else {
        throw EdmPrimitiveTypeException.ValueTypeNotSupported
      }
    } else {
      throw EdmPrimitiveTypeException.LiteralHasIllegalContent
    }
  }
  
  func internalValueToString<T>(value:T,isNilable:Bool,maxLength:Int, precision:Int,scale:Int,isUnicode:Bool) throws -> String {
    
    if value is Bool {
      return String(value)
    } else {
      throw EdmPrimitiveTypeException.ValueTypeNotSupported //("The value type " + value.getClass() + " is not supported.")
    }
  }
}

