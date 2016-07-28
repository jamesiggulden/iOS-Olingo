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
//  EdmInt64.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 28/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Implementation of the EDM primitive type Int64.
public final class EdmInt64:SingletonPrimitiveType {
 
  // MARK: - Stored Properties

  private static let INSTANCE:EdmInt64 = EdmInt64()
  // MARK: - Computed Properties


  public static var instance:EdmInt64 {
    return INSTANCE
  }
  
  public var getDefaultType:Any{
    // swift does not provide a specific long int will be 64bit where allowed
    return Int.self
  }
  
  // MARK: - Init

  // MARK: - Methods

  // TODO: isCompatible(primitiveType:EdmPrimitiveType )
  /*
  public override func isCompatible(primitiveType:EdmPrimitiveType ) -> Bool {
    return primitiveType is EdmByte
      || primitiveType is EdmSByte
        || primitiveType is EdmInt16
          || primitiveType is EdmInt32
            || primitiveType is EdmInt64
  }
 */
  
  

  override func internalValueOfString<T>(value:String,isnilable:Bool,maxLength:Int?,precision:Int,scale:Int,isUnicode:Bool,returnType:T) throws -> T {
  

    guard let valueLong = Int(value) else {
      throw EdmPrimitiveTypeException.LiteralHasIllegalContent //("The literal '" + value + "' has illegal content.", e)
    }
    do {
      let convertedNumber = try convertNumber(valueLong, returnType: returnType)
      return convertedNumber
    }
  }
  

  /// Converts a whole Number value into the requested return type if possible
  /// - parameters:
  ///   - value: the value
  ///   - eturnType the class of the returned value it must be one of BigInteger, Long, Integer, Short or Byte
  /// - returns: the converted value
  /// - throws: EdmPrimitiveTypeException if the conversion is not possible or if the return type is not allowed

  public func convertNumber <T> (value:NSNumber, returnType:T) throws -> T {
  
    

    // No specific long in Swift defaults to Int 64 or int 32 dependent on device
    //if (returnType.isAssignableFrom(Int.self)) {
    //
    
    //TODO: Why does this not work?  Workaround to convertt to string and check as strings
    //if returnType.self is Int {
    if String(returnType.self) == "Int" {
      return  Int(value) as! T
    }
    // TODO: BigInt, Byte & Short
    /*
      else if (returnType.isAssignableFrom(BigInteger.class)) {
        return returnType.cast(BigInteger.valueOf(value.longValue()))
      }
   
    else if (returnType.isAssignableFrom(Byte.class)) {
      if (value.longValue() >= Byte.MIN_VALUE && value.longValue() <= Byte.MAX_VALUE) {
        return returnType.cast(value.byteValue())
      } else {
        throw new IllegalArgumentException()
      }
    }
    else if (returnType.isAssignableFrom(Short.class)) {
      if (value.longValue() >= Short.MIN_VALUE && value.longValue() <= Short.MAX_VALUE) {
        return returnType.cast(value.shortValue())
      } else {
        throw new IllegalArgumentException()
      }
    }
  
    else if (returnType.isAssignableFrom(Int.self)) {
      if (value.longValue() >= Integer.MIN_VALUE && value.longValue() <= Integer.MAX_VALUE) {
        return returnType.cast(value.intValue())
      } else {
        throw new IllegalArgumentException()
      }
    }
       */
    else if returnType is EdmInt32 {
      return  Int(value) as! T
    }
    else {
      throw EdmPrimitiveTypeException.ValueTypeNotSupported
      // throw new ClassCastException("unsupported return type " + returnType.getSimpleName())
    }
  }
  
  //TODO: internalValueToString
/*
  protected <T> String internalValueToString(final T value,
  final Boolean isNullable, final Integer maxLength, final Integer precision,
  final Integer scale, final Boolean isUnicode) throws EdmPrimitiveTypeException {
    
    if (value instanceof Byte || value instanceof Short || value instanceof Integer || value instanceof Long) {
      return value.toString()
    } else if (value instanceof BigInteger) {
      if (((BigInteger) value).bitLength() < Long.SIZE) {
        return value.toString()
      } else {
        throw new EdmPrimitiveTypeException("The value '" + value + "' is not valid.")
      }
    } else {
      throw new EdmPrimitiveTypeException("The value type " + value.getClass() + " is not supported.")
    }
  }
 */
}
