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
//  EdmInt32.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 27/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Implementation of the EDM primitive type Int32
public final class EdmInt32:SingletonPrimitiveType {
  
  private static let INSTANCE:EdmInt32 = EdmInt32()
  
  // MARK: - Stored Properties
  
  
  // MARK: - Computed Properties

  public static var instance: EdmInt32 {
    return INSTANCE
  }

  
  public override var defaultType: Any { // Class<?> {
    return Int.self
   }
 
  
  // MARK: - Init
  
  
  // MARK: - Methods
  
  /// Convert the value provided as a string into the actual value of the type specified by returnType
  /// - parameters:
  ///   - value: value as string to be converted
  ///   - isnilable: is the value allowed to be nil
  ///   - maxlength: max length of value string
  ///   - precision: precision value
  ///   - scale: scale value
  ///   - isUnicode: is the value in unicode format
  ///   - returnType: returnType expected
  /// - returns: value of string of type T
  /// - throws: EDMPrimtiveType Error
  override func internalValueOfString<T>(value:String,isnilable:Bool,maxLength:Int?,precision:Int,scale:Int,isUnicode:Bool,returnType:T) throws -> T {
    
    guard let valueInteger = Int(value) else {
      throw EdmPrimitiveTypeException.LiteralHasIllegalContent  //("The literal '" + value + "' has illegal content.", e)
    }
    
    let numConvertor = EdmInt64()
    let convertedNumber = try numConvertor.convertNumber(valueInteger, returnType: returnType)
    return convertedNumber
   }


  
  // TODO: func isCompatible(primitiveType:EdmPrimitiveType ) -> Bool
  /*
  public override func isCompatible(primitiveType:EdmPrimitiveType ) -> Bool {
    return primitiveType is EdmByte
      || primitiveType is EdmSByte
        || primitiveType is EdmInt16
          || primitiveType is EdmInt32COLLECTION
  }
 */
  
  
  
  
  
  // TODO: internalValueToString
  /*
  protected <T> String internalValueToString(final T value,
  final Boolean isNullable, final Integer maxLength, final Integer precision,
  final Integer scale, final Boolean isUnicode) throws EdmPrimitiveTypeException {
    
    if (value instanceof Byte || value instanceof Short || value instanceof Integer) {
      return value.toString()
    } else if (value instanceof Long) {
      if ((Long) value >= Integer.MIN_VALUE && (Long) value <= Integer.MAX_VALUE) {
        return value.toString()
      } else {
        throw new EdmPrimitiveTypeException("The value '" + value + "' is not valid.")
      }
    } else if (value instanceof BigInteger) {
      if (((BigInteger) value).bitLength() < Integer.SIZE) {
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
