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
//  EdmDouble.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/08/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Implementation of the EDM primitive type Double
public final class EdmDouble: SingletonPrimitiveType {
  
  // MARK: - Stored Properties
  
  let NEGATIVE_INFINITY:String = "-INF" // Static
  
  let POSITIVE_INFINITY:String = "INF"  // Static
  
  let  NaN:String = "NaN"
  
  // ignore pattern matching as we can catch it with the number conversion from string
 // private static final Pattern PATTERN = Pattern.compile("(?:\\+|-)?\\p{Digit}{1,17}(?:\\.\\p{Digit}{1,17})?(?:(?:E|e)(?:\\+|-)?\\p{Digit}{1,3})?")
  
  
  // needed to be lazy to allow unit tests
  private final lazy var  INSTANCE:EdmDouble  =  EdmDouble()
  
  // MARK: - Computed Properties

  public var instance: EdmDouble {
    return INSTANCE
  }
  
  public override var defaultType:Any{
    return Double.self
  }
  
  // MARK: - Init

  // MARK: - Methods

  public override func isCompatible(primitiveType:EdmPrimitiveType) -> Bool {
    return primitiveType is EdmInt32
            || primitiveType is EdmInt64
                || primitiveType is EdmDouble
    
    // TODO: Additional types to be implmented
    /*
    return primitiveType is EdmByte
      || primitiveType is EdmSByte
      || primitiveType is EdmInt16
      || primitiveType is EdmInt32
      || primitiveType is EdmInt64
      || primitiveType is EdmSingle
      || primitiveType is EdmDouble
    */
  }
  
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
    
    var result:Double = 0.0
    var bigDecimalValue:NSDecimalNumber = 0.0
    
    // Handle special values first.
    if value == NEGATIVE_INFINITY {
      result = Double.infinity * -1
    } else if value == POSITIVE_INFINITY {
      result = Double.infinity
    } else if value == NaN {
      result = Double.NaN
    } else {
      // Now only "normal" numbers remain.
      // ignore pattern matching as we can catch it with the number conversion from string
      /*
      if (!PATTERN.matcher(value).matches()) {
        throw new EdmPrimitiveTypeException("The literal '" + value + "' has illegal content.")
      }
       */
      // The number format is checked above, so we don't have to catch NumberFormatException.
      bigDecimalValue = NSDecimalNumber.init(string: value)
      if let res = Double(value){
        if res.isNaN {
          throw EdmPrimitiveTypeException.LiteralHasIllegalContent //("The literal '" + value + "' has illegal content.")
        }
        result = res
      }
      else {
        throw EdmPrimitiveTypeException.LiteralHasIllegalContent //("The literal '" + value + "' has illegal content.")
      }
      // "Real" infinite values have been treated already above, so we can throw an exception
      // if the conversion to a double results in an infinite value.
      if result.isInfinite  {
        throw EdmPrimitiveTypeException.LiteralHasIllegalContent  //("The literal '" + value + "' has illegal content.")
      }
      //TODO: Handling difference between NSDecimal value when converted to dbl rounds differently so the comparision fails 
      // when they shoudl be the same.
      /*
      if !bigDecimalValue.isEqualToNumber(result)) {
      throw EdmPrimitiveTypeException.LiteralHasIllegalContent  //("The literal '" + value + "' has illegal content.")
      }
       */
    }
    
    // do sepecifc check for NSDecimal first as dbl check picks up NSDecimal as a dbl
    if returnType is NSDecimalNumber {
      return try EdmDecimal().convertDecimal(bigDecimalValue,returnType: returnType)
    }
    if returnType is Double {
      return  result as! T //Double //returnType.cast(result)
    }
    if returnType is Float {
      return Float(result) as! T
    }
    else if result.isInfinite || result.isNaN {
      if returnType is Float {
        return Float(result) as!  T //Float  //returnType.cast(result.floatValue())
      } else {
        throw EdmPrimitiveTypeException.LiteralCannotBeConvertedToValueType //("The literal '" + value + "' cannot be converted to value type " + returnType + ".")
      }
    }
    else {
      do {
        return try EdmDecimal().convertDecimal(bigDecimalValue,returnType: returnType)
      }
    }
  }
  
  // TODO: internalValueToString
  /*
  protected <T> String internalValueToString(final T value,
  final Boolean isNullable, final Integer maxLength, final Integer precision,
  final Integer scale, final Boolean isUnicode) throws EdmPrimitiveTypeException {
    if (value instanceof Long) {
      if (Math.abs((Long) value) < 1L << 51) {
        return value.toString()
      } else {
        throw new EdmPrimitiveTypeException("The value '" + value + "' is not valid.")
      }
    } else if (value instanceof Integer || value instanceof Short || value instanceof Byte) {
      return value.toString()
    } else if (value instanceof Double) {
      return (Double) value == Double.NEGATIVE_INFINITY ? NEGATIVE_INFINITY
        : (Double) value == Double.POSITIVE_INFINITY ? POSITIVE_INFINITY : value.toString()
    } else if (value instanceof Float) {
      return (Float) value == Float.NEGATIVE_INFINITY ? NEGATIVE_INFINITY
        : (Float) value == Float.POSITIVE_INFINITY ? POSITIVE_INFINITY : value.toString()
    } else if (value instanceof BigDecimal) {
      final double doubleValue = ((BigDecimal) value).doubleValue()
      if (!Double.isInfinite(doubleValue) && BigDecimal.valueOf(doubleValue).compareTo((BigDecimal) value) == 0) {
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
