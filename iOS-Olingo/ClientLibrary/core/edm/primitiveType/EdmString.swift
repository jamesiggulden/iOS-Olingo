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
  
  // TODO:
  //private static final Pattern PATTERN_ASCII = Pattern.compile("\\p{ASCII}*")
  
  private static let INSTANCE:EdmString = EdmString()
  
  //internal let uriPrefix = "'"
  //internal let uriSuffix = "'"
  
  public static func getInstance() -> EdmString {
    return INSTANCE
  }
  
  func internalValueOfString<T>(value:String,isnilable:Bool,maxLength:Int,precision:Int,scale:Int,isUnicode:Bool,returnType:T)  -> T {
  //func internalValueOfString<T>(value:String,isnilable:Bool,maxLength:Int,precision:Int,scale:Int,isUnicode:Bool,returnType:Class<T>) throws -> T {
    
   // TODO:
   /*
    if (isUnicode != nil && !isUnicode && !PATTERN_ASCII.matcher(value).matches() || maxLength != nil && maxLength < value.length()) {
      throw EdmPrimitiveTypeException.LiteralHasIllegalContent //("The literal '" + value + "' does not match the facets' constraints.")
    }
    
    if (returnType.isAssignableFrom(String.class)) {
      return returnType.cast(value)
    } else {
      throw EdmPrimitiveTypeException.LiteralHasIllegalContent //("The value type " + returnType + " is not supported.")
    }
 */
    return value as! T
  }

  
  //TODO:
  /*func internalValueOfString<T>(value:String,isnilable:Bool,maxLength:Int,precision:Int,scale:Int,isUnicode:Bool,returnType:Class<T>) throws -> T {
  public func getDefaultType() -> Class<?> {
    return String.class
  }
  
  
  func internalValueOfString<T>(value:String,isnilable:Bool,maxLength:Int,precision:Int,scale:Int,isUnicode:Bool,returnType:Class<T>) throws -> T {
    
    if (isUnicode != nil && !isUnicode && !PATTERN_ASCII.matcher(value).matches() || maxLength != nil && maxLength < value.length()) {
      throw EdmPrimitiveTypeException.LiteralHasIllegalContent //("The literal '" + value + "' does not match the facets' constraints.")
    }
    
    if (returnType.isAssignableFrom(String.class)) {
      return returnType.cast(value)
    } else {
      throw EdmPrimitiveTypeException.LiteralHasIllegalContent //("The value type " + returnType + " is not supported.")
    }
  }
  
  
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
  
  
  public func toUriLiteral(literal:String) -> String {
    if literal.isEmpty {
      return ""
    }
    
    let length = literal.characters.count
    
    var uriLiteral:String = ""
    uriLiteral += uriPrefix
    for (int i = 0 i < length i++) {
      final char c = literal.charAt(i)
      if (c == '\'') {
        uriLiteral.append(c)
      }
      uriLiteral.append(c)
    }
    uriLiteral += uriSuffix
    return uriLiteral
  }
  
  
  public func fromUriLiteral(literal:String) throws -> String {
    return literal == nil ? nil : super.fromUriLiteral(literal).replace("''", "'")
  }
 */
}
