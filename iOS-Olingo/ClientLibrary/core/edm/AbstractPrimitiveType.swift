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
//  AbstractPrimitiveType.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 08/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Abstract implementation of the EDM primitive-type interface.

public class AbstractPrimitiveType : EdmPrimitiveType {
  
  // MARK: - Stored Properties

  var uriPrefix:String = ""
  
  var uriSuffix:String = ""
  
  public var name:String = ""
  
  public var namespace: String = ""
  
  //public var kind: EdmTypeKind = EdmTypeKind()

  // MARK: - Computed Properties
  
  public var defaultType:Any {
    return ("" as? Any)!
  }
  
  public var kind:EdmTypeKind? {
    return nil
  }
  
  public var fullQualifiedName: FullQualifiedName {
    return FullQualifiedName(namespace: namespace, name: name)
  }
  
  // MARK: - Init

  
  // MARK: - Methods

  // TODO: Stubbed to get past methods defined to be called from subclasses
  /*
  public func getNamespace() -> String {
    fatalError("Must be implmented in subclass")
  }
  
  public func getName() -> String {
    fatalError("Must be implmented in subclass")
  }
  
  public func getKind() -> EdmTypeKind {
    fatalError("Must override")
  }

  */
  

  public func isCompatible(primitiveType:EdmPrimitiveType) -> Bool {
    
    return true
    //TODO: equals(primitiveType)
    //return equals(primitiveType)
  }
  

  public func validate(value:String?,isnilable:Bool,maxLength:Int,precision:Int,scale:Int,isUnicode:Bool) -> Bool {
    
    do {
      try valueOfString(value, isnilable: isnilable, maxLength: maxLength, precision: precision, scale: scale, isUnicode: isUnicode, returnType: defaultType)
      return true
    }
    catch {
      return false
    }
  }
  

  public final func valueOfString <T> (value:String?,isnilable:Bool,maxLength:Int?,precision:Int,scale:Int,isUnicode:Bool,  returnType:T) throws  -> T? {
    
    guard let value = value else {
      if (!isnilable) {
        throw EdmPrimitiveTypeException.LiteralNilNotAllowed
      }
      return nil
    }
    do {
      // TODO: How do you call teh child version rather than the abstartc parent?
      return value as! T
      //return try internalValueOfString(value, isnilable: isnilable, maxLength: maxLength, precision: precision, scale: scale, isUnicode: isUnicode, returnType: returnType)
    }

  }
  
  func internalValueOfString <T> (value:String,isnilable:Bool,maxLength:Int?,precision:Int,scale:Int,isUnicode:Bool,returnType: T)throws -> T  {
    fatalError("Must override")
  }
  

  public final func valueToString(value:AnyObject?,isnilable:Bool,maxLength:Int,precision:Int,scale:Int,isUnicode:Bool) throws -> String? {
    guard value != nil else {
      if !isnilable {
        throw EdmPrimitiveTypeException.LiteralNilNotAllowed
      }
      return nil
    }
    return try internalValueToString(value, isnilable: isnilable, maxLength: maxLength, precision: precision, scale: scale, isUnicode: isUnicode)
  }
  
  func internalValueToString <T> (value: T,isnilable:Bool, maxLength:Int, precision:Int, scale:Int,isUnicode:Bool) throws -> String {
    fatalError("Must override")
  }
  

  public func toUriLiteral(literal:String?) -> String? {
    guard let literal = literal else {
      return nil
    }
    return uriPrefix.isEmpty && uriSuffix.isEmpty ? literal : uriPrefix + literal + uriSuffix
  }
  

  public func fromUriLiteral(literal:String?) throws -> String? {
    guard let literal = literal else {
      return nil
    }
    if (uriPrefix.isEmpty && uriSuffix.isEmpty) {
      return literal
    }
    else if (literal.characters.count >= uriPrefix.characters.count + uriSuffix.characters.count) {
      guard let prefixIdx = literal.rangeOfString(uriPrefix)?.startIndex,
        let suffixIdx = literal.rangeOfString(uriSuffix, options: .BackwardsSearch)?.startIndex else {
        throw EdmPrimitiveTypeException.LiteralHasIllegalContent
      }
      if prefixIdx == literal.startIndex && suffixIdx == literal.endIndex.advancedBy(-1 - uriSuffix.characters.count){
        return literal.substringWithRange(Range(prefixIdx ..< suffixIdx))
      }
      else
      {
        throw EdmPrimitiveTypeException.LiteralHasIllegalContent
      }
    }
    else {
      return nil
    }
  }
  

  public func toString() -> String {
    return fullQualifiedName.fqn
  }
}
