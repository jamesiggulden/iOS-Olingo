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
  
  private var _name:String = ""
  
  private var _namespace: String = ""
  
  //public var kind: EdmTypeKind = EdmTypeKind()

  // MARK: - Computed Properties
  
  public var defaultType:Any {
    return ("" as Any)
  }
  
  public var kind:EdmTypeKind? {
    return nil
  }
  
  public var name:String {
    return _name
  }
  
  public var namespace:String {
    return _namespace
  }
  
  public var fullQualifiedName: FullQualifiedName {
    return FullQualifiedName(namespace: namespace, name: name)
  }
  
  // MARK: - Init

  
  // MARK: - Methods

  // TODO: Stubbed to get past methods defined to be called from subclasses
  /*
  public func getNamespace() -> String {
   // only implnented to test vaibility of enforcing the creation of the method in a concrete class.
   // Swift does not provide an abstarct method capability.
   // Alternative it is create a protocol for this abstract class
    fatalError("Must be implmented in subclass")
  }
  
  public func getName() -> String {
   // only implnented to test vaibility of enforcing the creation of the method in a concrete class.
   // Swift does not provide an abstarct method capability.
   // Alternative it is create a protocol for this abstract class
    fatalError("Must be implmented in subclass")
  }
  
  public func getKind() -> EdmTypeKind {
   // only implnented to test vaibility of enforcing the creation of the method in a concrete class.
   // Swift does not provide an abstarct method capability.
   // Alternative it is create a protocol for this abstract class
    fatalError("Must override")
  }

  */
  

  public func isCompatible(primitiveType:EdmPrimitiveType) -> Bool {
    return true
    //TODO: equals(primitiveType)
    //return equals(primitiveType)
  }
  
 
  /// Validate primitive type
  /// - parameters:
  ///   - value: value as string
  ///   - isnilable: is the value allowed to be nil
  ///   - maxlength: max length of value string
  ///   - precision: precision value
  ///   - scale: scale value
  ///   - isUnicode: is the value in unicode format
  /// - returns: true if value can be obtained from value as string
  /// - throws: No error conditions are expected
  public func validate(value:String?,isnilable:Bool,maxLength:Int,precision:Int,scale:Int,isUnicode:Bool) -> Bool {
    
    do {
      try valueOfString(value, isnilable: isnilable, maxLength: maxLength, precision: precision, scale: scale, isUnicode: isUnicode, returnType: defaultType)
      return true
    }
    catch {
      return false
    }
  }
  
  /// get value of value as string
  /// - parameters:
  ///   - value: value as string
  ///   - isnilable: is the value allowed to be nil
  ///   - maxlength: max length of value string
  ///   - precision: precision value
  ///   - scale: scale value
  ///   - isUnicode: is the value in unicode format
  ///   - returnType: returnType expected
  /// - returns: value of type T
  /// - throws: No error conditions are expected
  public final func valueOfString <T> (value:String?,isnilable:Bool,maxLength:Int?,precision:Int,scale:Int,isUnicode:Bool,  returnType:T) throws  -> T? {
    
    guard let value = value else {
      if isnilable != true {
        throw EdmPrimitiveTypeException.LiteralNilNotAllowed
      }
      return nil
    }
    do {
      return try self.internalValueOfString(value, isnilable: isnilable, maxLength: maxLength, precision: precision, scale: scale, isUnicode: isUnicode, returnType: returnType)
    }
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
  func internalValueOfString <T> (value:String,isnilable:Bool,maxLength:Int?,precision:Int,scale:Int,isUnicode:Bool,returnType: T)throws -> T  {
    // only implnented to test vaibility of enforcing the creation of the method in a concrete class. 
    // Swift does not provide an abstarct method capability.
    // Alternative it is create a protocol for this abstract class
    fatalError("Must override")
  }
  
  /// Convert the value provided to a string
  /// - parameters:
  ///   - value: value of generic type T to be converted
  ///   - isnilable: is the value allowed to be nil
  ///   - maxlength: max length of value string
  ///   - precision: precision value
  ///   - scale: scale value
  ///   - isUnicode: is the value in unicode format
  /// - returns: value as string
  /// - throws: No error expected
  func internalValueToString <T> (value: T,isnilable:Bool, maxLength:Int, precision:Int, scale:Int,isUnicode:Bool) throws -> String {
    // only implnented to test vaibility of enforcing the creation of the method in a concrete class.
    // Swift does not provide an abstarct method capability.
    // Alternative it is create a protocol for this abstract class
    fatalError("Must override")
  }
  


  /// get value as string of value
  /// - parameters:
  ///   - value: value
  ///   - isnilable: is the value allowed to be nil
  ///   - maxlength: max length of value string
  ///   - precision: precision value
  ///   - scale: scale value
  ///   - isUnicode: is the value in unicode format
  /// - returns: value as string
  /// - throws: EdmPrimitiveTypeException.LiteralNilNotAllowed
  public final func valueToString(value:AnyObject?,isnilable:Bool,maxLength:Int,precision:Int,scale:Int,isUnicode:Bool) throws -> String? {
    guard value != nil else {
      if !isnilable {
        throw EdmPrimitiveTypeException.LiteralNilNotAllowed
      }
      return nil
    }
    return try internalValueToString(value, isnilable: isnilable, maxLength: maxLength, precision: precision, scale: scale, isUnicode: isUnicode)
  }
  
  /// Wrap uri prefix and suffix values to literal string
  /// - parameters:
  ///   - literal: string to be wrapped
  /// - returns: string with prefix & suffix added
  /// - throws: No error expected
  public func toUriLiteral(literal:String?) -> String? {
    guard let literal = literal else {
      return nil
    }
    return uriPrefix.isEmpty && uriSuffix.isEmpty ? literal : uriPrefix + literal + uriSuffix
  }
  
 
  /// Strip uri prefix and suffix values from literal string
  /// - parameters:
  ///   - literal: string to be stripped
  /// - returns: string with prefix & suffix removed if found
  /// - throws: EdmPrimitiveTypeException.LiteralHasIllegalContent
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
  
  public func isEqualTo(object: EdmPrimitiveType) -> Bool {
    return false

  }
}
