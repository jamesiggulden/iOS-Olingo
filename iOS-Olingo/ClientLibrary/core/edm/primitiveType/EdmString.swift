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
//  EdmString.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 19/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * Implementation of the EDM primitive type String.
 */
public final class EdmString:SingletonPrimitiveType {
  
  // MARK: - Stored Properties

  // TODO:
  //private static final Pattern PATTERN_ASCII = Pattern.compile("\\p{ASCII}*")
  
  private static let INSTANCE:EdmString = EdmString()
  
  
  // MARK: - Computed Properties
  public static var instance: EdmString {
    return INSTANCE
  }
  
  
  public override var defaultType: Any { //Class<?> {
   return String.self
  }
 
  // MARK: - Init
  
  override init() {
    super.init()
    self.uriPrefix = "'"
    self.uriSuffix = "'"
  }

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
  override func internalValueOfString<T>(value:String,isnilable:Bool,maxLength:Int?,precision:Int,scale:Int,isUnicode:Bool,returnType:T) -> T {
    /*
   // TODO: pattern matching
   
    if (!isUnicode /*&& !PATTERN_ASCII.matcher(value).matches()*/ || maxLength != nil && maxLength < value.characters.count) {
      throw EdmPrimitiveTypeException.LiteralHasIllegalContent //("The literal '" + value + "' does not match the facets' constraints.")
    }
    
    if (returnType.isAssignableFrom(String.self)) {
      return value as String //returnType
    } else {
      throw EdmPrimitiveTypeException.LiteralHasIllegalContent //("The value type " + returnType + " is not supported.")
    }
    
    /*
    if (isUnicode != nil && !isUnicode && !PATTERN_ASCII.matcher(value).matches() || maxLength != nil && maxLength < value.length()) {
      throw EdmPrimitiveTypeException.LiteralHasIllegalContent //("The literal '" + value + "' does not match the facets' constraints.")
    }
    
    if (returnType.isAssignableFrom(String.class)) {
      return returnType.cast(value)
    } else {
      throw EdmPrimitiveTypeException.LiteralHasIllegalContent //("The value type " + returnType + " is not supported.")
    */
 */
    
   // let retVal = value as EdmString
    return value as! T
  }
  
  /// Strip uri prefix and suffix values and remove quotesfrom literal string
  /// - parameters:
  ///   - literal: string to be stripped
  /// - returns: string with prefix & suffix removed if found and invalid quotes
  /// - throws: EdmPrimitiveTypeException.LiteralHasIllegalContent
  public func fromUriLiteral(literal:String) throws -> String? {
    if literal.isEmpty {
      return ""
    }
    else {
      do {
        return try super.fromUriLiteral(literal)?.stringByReplacingOccurrencesOfString("''", withString: "'")
      }
    }
    
  }
  
  // TODO: internalValueToString
  /*
  protected <T> String internalValueToString(final T value,
  final Boolean isnilable, final Integer maxLength, final Integer precision,
  final Integer scale, final Boolean isUnicode) throws EdmPrimitiveTypeException {
    
    final String result = value instanceof String ? (String) value : String.valueOf(value)
    
    if (isUnicode != nil && !isUnicode && !PATTERN_ASCII.matcher(result).matches()
      || maxLength != nil && maxLength < result.length()) {
      throw new EdmPrimitiveTypeException("The value '" + value + "' does not match the facets' constraints.")
    }
    
    return result
  }
   */
  
  // TODO: toUriLiteral
  /*
  public func toUriLiteral(literal:String) -> String {
    if literal.isEmpty {
      return ""
    }
    
    let length = literal.characters.count
    
    var uriLiteral:String = ""
    uriLiteral += uriPrefix
    for (int i = 0 i < length i++) {
      final char c = literal.charAt(i)
      if (c == "'") {
        uriLiteral.append(c)
      }
      uriLiteral.append(c)
    }
    uriLiteral += uriSuffix
    return uriLiteral
  }
 */
 
}
