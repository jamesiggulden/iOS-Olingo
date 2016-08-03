
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
//  EdmDecimal.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 27/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * Implementation of the EDM primitive type Decimal.
 */
public final class EdmDecimal:SingletonPrimitiveType {
  
  // MARK: - Stored Properties

  // TODO: Pattern
  //private static final Pattern PATTERN = Pattern.compile("(?:\\+|-)?(?:0*(\\p{Digit}+?))(?:\\.(\\p{Digit}+?)0*)?")
  
  private static let INSTANCE:EdmDecimal  = EdmDecimal()
  
  
  // MARK: - Computed Properties
  
  // Get the static instance
  public static var instance: EdmDecimal {
    return INSTANCE
  }
  
  // get the default class
  public override var defaultType: Any { // Class<?> {
    return NSDecimalNumber.self
  }

  // MARK: - Init
  
  // MARK: - Methods
  
   /// Convert the value provided as a string into the actual value of the specified type
   /// - parameters:
   ///   - value: value as string to be converted
   ///   - isnilable: is the value allowed to be nil
   ///   - maxlength: max length of value string
   ///   - precision: precision value
   ///   - scale: scale value
   ///   - isUnicode: is the value in unicode format
   ///   - returnType: returnType expected
   
   /// - returns: NSDate with values obtained from value string
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
    //return dec as! T
    /*

   
   
   try {
   return convertDecimal(new BigDecimal(value), returnType)
    
    
   } catch (final IllegalArgumentException e) {
   throw new EdmPrimitiveTypeException("The literal '" + value
   + "' cannot be converted to value type " + returnType + ".", e)
   } catch (final ClassCastException e) {
   throw new EdmPrimitiveTypeException("The value type " + returnType + " is not supported.", e)
   } */
  }

  
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
    
    // Obsolete from java olingo
    /*
     final Matcher matcher = PATTERN.matcher(value)
     matcher.matches()
     final int significantIntegerDigits = matcher.group(1).equals("0") ? 0 : matcher.group(1).length()
     final int decimals = matcher.group(2) == null ? 0 : matcher.group(2).length()
     return (precision == null || precision >= significantIntegerDigits + decimals)
     && (decimals <= (scale == null ? 0 : scale))
     */


  }
 

   /**
   * Converts a {@link BigDecimal} value into the requested return type if possible.
   *
   * @param value the value
   * @param returnType the class of the returned value it must be one of {@link BigDecimal}, {@link Double},
   * {@link Float}, {@link BigInteger}, {@link Long}, {@link Integer}, {@link Short}, or {@link Byte}
   * @return the converted value
   * @throws IllegalArgumentException if the conversion is not possible or would lead to loss of data
   * @throws ClassCastException if the return type is not allowed
   */
  func convertDecimal<T>(value:NSDecimalNumber,returnType:T) throws -> T {
  
    log.debug("ConvertDecimal: \(returnType.dynamicType)")
    if returnType is NSDecimalNumber.Type {
      return  value as! T //returnType.cast(value)
    }
    else if returnType is Double.Type  {
      let doubleValue = value.doubleValue
      if value.isEqual(doubleValue) {
        return value as! T //returnType.cast(doubleValue)
      }
      else {
        throw EdmPrimitiveTypeException.LiteralHasIllegalContent
      }
    }
    else if returnType is Float.Type {
      let floatValue = value.floatValue
      if value.isEqual(floatValue) {
        return value as! T //returnType.cast(doubleValue)
      }
      else {
        throw EdmPrimitiveTypeException.LiteralHasIllegalContent
      }
    }
    else {

      if returnType is Int.Type {
        return returnType as T //.cast(value.toBigIntegerExact())
      }
      /*
      else if returnType.isAssignableFrom(Long.class)) {
         return returnType.cast(value.longValueExact())
      } else if (returnType.isAssignableFrom(Integer.class)) {
         return returnType.cast(value.intValueExact())
      } else if (returnType.isAssignableFrom(Short.class)) {
         return returnType.cast(value.shortValueExact())
      } else if (returnType.isAssignableFrom(Byte.class)) {
         return returnType.cast(value.byteValueExact())
      }
 */
      else {
        throw EdmPrimitiveTypeException.ValueTypeNotSupported   //("unsupported return type " + returnType.getSimpleName())
      }
    }
  }
  

  
  
  //TODO: isCompatible
  /*
  public boolean isCompatible(final EdmPrimitiveType primitiveType) {
    return primitiveType instanceof EdmByte
      || primitiveType instanceof EdmSByte
        || primitiveType instanceof EdmInt16
          || primitiveType instanceof EdmInt32
            || primitiveType instanceof EdmInt64
              || primitiveType instanceof EdmSingle
                || primitiveType instanceof EdmDouble
                  || primitiveType instanceof EdmDecimal
  }
  */
  
  
  
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

