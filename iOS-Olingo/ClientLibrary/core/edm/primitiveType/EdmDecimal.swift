
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
//  EdmDecimal.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 27/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Implementation of the EDM primitive type Decimal.
public final class EdmDecimal:SingletonPrimitiveType {
  
  // MARK: - Stored Properties

  // TODO: Pattern
  //private static final Pattern PATTERN = Pattern.compile("(?:\\+|-)?(?:0*(\\p{Digit}+?))(?:\\.(\\p{Digit}+?)0*)?")
  
  private static let INSTANCE:EdmDecimal = EdmDecimal()
  
  
  // MARK: - Computed Properties
  
  // Get the static instance
  public  static var instance: EdmDecimal {
    return INSTANCE
  }
  
  // get the default class
  public override var defaultType: Any { // Class<?> {
    return NSDecimalNumber.self
  }

  // MARK: - Init
  
  // MARK: - Methods
  
   /// Convert the value provided as a string into the actual value of the specified type
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

    
    let dec = NSDecimalNumber(string: value)
    if dec == NSDecimalNumber.notANumber() {
      throw EdmPrimitiveTypeException.LiteralHasIllegalContent
    }
    
    if !validatePrecisionAndScale(value, precision:precision, scale:scale) {
      throw EdmPrimitiveTypeException.DoesNotMatchFacetsConstraints // ("The literal '" + value + "' does not match the facets' constraints.")
    }
    let convertedDecimal = try convertDecimal(dec,returnType: returnType)
    return convertedDecimal
  }

   
  /// Validate value against the precision and scale values
  /// - parameters:
  ///   - value: value as string to validate
  ///   - precision: precision value
  ///   - scale: scale value
  /// - returns: true if validation passed otherwise false
  /// - throws: No error conditions are expected
  private func validatePrecisionAndScale(value:String, precision:Int, scale:Int) -> Bool {
    
    let wholeNumSize:Int
    let decSize:Int
    
    if value.containsString(".") {
      let splitVals = value.componentsSeparatedByString(".")
      if splitVals[0].startsWith("+") || splitVals[0].startsWith("-") {
        wholeNumSize = splitVals[0].characters.count - 1
      }
      else {
        wholeNumSize = splitVals[0].characters.count
      }
      decSize = splitVals[1].characters.count
      
    }
    else {
      if value.startsWith("+") || value.startsWith("-") {
        wholeNumSize = value.characters.count - 1
      }
      else {
        wholeNumSize = value.characters.count
      }
      decSize = 0
    }
    if (wholeNumSize + decSize <= precision) && decSize <= scale {
      return true
    }
    else {
      return false
    }
  }
 

  /// Converts a Decimal value into the requested return type if possible
  /// - parameters:
  ///   - value: the value
  ///   - returnType: the class of the returned value it must be one of NSDecimalNumber, Double,
  ///      Float, Integer or Byte
  /// - returns: the converted value
  /// - throws: IllegalArgumentException if the conversion is not possible or would lead to loss of data or if the the return type is not allowed
  func convertDecimal<T>(value:NSDecimalNumber,returnType:T) throws -> T {
  
    log.debug("ConvertDecimal: \(returnType.dynamicType)")
    if returnType is NSDecimalNumber {
      return  value as! T //returnType.cast(value)
    }
    else if returnType is NSDecimalNumber.Type {
      return value as! T
    }
    else if returnType is Double  {
      let doubleValue = value.doubleValue
      if value.isEqualToNumber(doubleValue) {  // .isEqualTo(doubleValue)
        return value.doubleValue as! T //returnType.cast(doubleValue)
      }
      else {
        throw EdmPrimitiveTypeException.LiteralHasIllegalContent
      }
    }
    else if returnType is Float {
      let floatValue = value.floatValue
      if value.isEqualToNumber(floatValue) { //.isEqual(floatValue)
        return value.floatValue as! T //returnType.cast(doubleValue)
      }
      else {
        throw EdmPrimitiveTypeException.LiteralHasIllegalContent
      }
    }
    else {

      if returnType is Int {
        return value.integerValue as! T //.cast(value.toBigIntegerExact())
      }
      else {
        throw EdmPrimitiveTypeException.ValueTypeNotSupported   //("unsupported return type " + returnType.getSimpleName())
      }
    }
  }
  

   
  /// Check if type conversion is valid
  /// - parameters:
  ///   - primitiveType: EDM prmitive type to be validated
  /// - returns: true is conversion valid otherwise false
  /// - throws: No error conditions are expected
  public override func isCompatible(primitiveType:EdmPrimitiveType)-> Bool {
    return primitiveType is EdmInt32
      || primitiveType is EdmInt64
      || primitiveType is EdmDouble
      || primitiveType is EdmDecimal
    
    // TODO: Adding in EdmTypes when implemented
    /*
    return primitiveType is EdmByte
      || primitiveType is EdmSByte
      || primitiveType is EdmInt16
      || primitiveType is EdmInt32
      || primitiveType is EdmInt64
      || primitiveType is EdmSingle
      || primitiveType is EdmDouble
      || primitiveType is EdmDecimal
    */

  }
  
  
  
  
  //TODO: validate
  /*
  public boolean validate(final String value,
  final Boolean isNullable, final Integer maxLength, final Integer precision,
  final Integer scale, final Boolean isUnicode) {
    
    return value == null
      ? isNullable == null || isNullable
      : validateLiteral(value) && validatePrecisionAndScale(value, precision, scale)
  }
 */
  
  //TODO: validateLiteral
  /*
  private static boolean validateLiteral(final String value) {
    return PATTERN.matcher(value).matches()
  }
 */
  
  
  // TODO: internalValueToString
  /*
  protected <T> String internalValueToString(final T value,
  final Boolean isNullable, final Integer maxLength, final Integer precision,
  final Integer scale, final Boolean isUnicode) throws EdmPrimitiveTypeException {
    
    String result
    if (value instanceof Long || value instanceof Integer || value instanceof Short
      || value instanceof Byte || value instanceof BigInteger) {
      result = value.toString()
      final int digits = result.startsWith("-") ? result.length() - 1 : result.length()
      if (precision != null && precision < digits) {
        throw new EdmPrimitiveTypeException("The value '" + value + "' does not match the facets' constraints.")
      }
      
    } else if (value instanceof Double || value instanceof Float || value instanceof BigDecimal) {
      BigDecimal bigDecimalValue
      try {
        bigDecimalValue = value instanceof Double ? BigDecimal.valueOf((Double) value)
          : value instanceof Float ? BigDecimal.valueOf((Float) value) : (BigDecimal) value
      } catch (final NumberFormatException e) {
        throw new EdmPrimitiveTypeException("The value '" + value + "' is not valid.", e)
      }
      
      final int digits = bigDecimalValue.scale() >= 0
        ? Math.max(bigDecimalValue.precision(), bigDecimalValue.scale())
        : bigDecimalValue.precision() - bigDecimalValue.scale()
      if ((precision == null || precision >= digits) && (bigDecimalValue.scale() <= (scale == null ? 0 : scale))) {
        result = bigDecimalValue.toPlainString()
      } else {
        throw new EdmPrimitiveTypeException("The value '" + value + "' does not match the facets' constraints.")
      }
      
    } else {
      throw new EdmPrimitiveTypeException("The value type " + value.getClass() + " is not supported.")
    }
    
    return result
  }
 */
}

