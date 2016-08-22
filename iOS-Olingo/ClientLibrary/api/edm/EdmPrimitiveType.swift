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
//  EdmPrimitiveType.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 08/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// EdmPrimitiveType is a primitive type as defined in the Entity Data Model (EDM).
///
/// There are methods to convert EDM primitive types from and to Swift objects, respectively.
/// For all EDM primitive types, the `nilable` facet is taken into account. For `Binary` and
/// `String`, `MaxLength` is also applicable. For `String`, the facet
/// `Unicode` is considered additionally. The EDM primitive types `DateTimeOffset`,
/// `Decimal`, `Duration`, and `TimeOfDay` can have a `Precision` facet
/// Additionally, `Decimal` can have the facet `Scale`.
public protocol EdmPrimitiveType: EdmType {
  
  /// Returns the default Swift type for this EDM primitive type 
  var defaultType: Any {get}

  /// Checks type compatibility.
  /// - parameters:
  ///   - primitiveType: the `EdmPrimitiveType` to be tested for compatibility
  /// - returns: `true` if the provided type is compatible to this type
  /// - throws: No error conditions are expected
  func isCompatible(EprimitiveType:EdmPrimitiveType ) -> Bool

  /// Validates literal value.
  /// - parameters:
  ///   - value: the literal representation of value
  ///   - isnilable: whether the `nil` value is allowed
  ///   - maxLength: the maximum length
  ///   - precision: the precision
  ///   - scale: the scale
  ///   - isUnicode: whether non-ASCII characters are allowed (relevant only for Edm.String)
  /// - returns: `true` if the validation is successful
  /// - throws: No error conditions are expected
  func validate(value:String?,isnilable:Bool,maxLength:Int,precision:Int,scale:Int,isUnicode:Bool) -> Bool

  /// Converts literal representation of value to system data type.
  /// - parameters:
  ///   - value: the literal representation of value
  ///   - isnilable: whether the `nil` value is allowed
  ///   - maxLength: the maximum length
  ///   - precision: the precision
  ///   - scale: the scale
  ///   - isUnicode: whether non-ASCII characters are allowed (relevant only for Edm.String)
  ///   - returnType the class of the returned value it must be one of EdmPrimitiveType
  /// - returns: the value as an instance of the class the parameter `returnType` indicates
  /// - throws: EdmPrimitiveTypeException
  func valueOfString <T> (value:String?,isnilable:Bool,maxLength:Int?,precision:Int,scale:Int,isUnicode:Bool,returnType: T) throws -> T?

  /// Converts system data type to literal representation of value.
  /// Returns `nil` if value is `nil` and `nil` is an allowed value.
  /// - parameters:
  ///   - value: the Swift value as Object its type must be one of EdmPrimitiveType
  ///   - isnilable: whether the `nil` value is allowed
  ///   - maxLength: the maximum length
  ///   - precision: the precision
  ///   - scale: the scale
  ///   - isUnicode: whether non-ASCII characters are allowed (relevant only for Edm.String)
  /// - returns: literal representation as String
  /// - throws: EdmPrimitiveTypeException
  func valueToString(value:AnyObject?,isnilable:Bool,maxLength:Int,precision:Int,scale:Int,isUnicode:Bool) throws -> String?

  /// Converts default literal representation to URI literal representation.
  /// Returns `nil` if the literal is `nil`. Does not perform any validation.
  /// - parameters:
  ///   - literal: the literal in default representation
  /// - returns: URI literal representation as String
  /// - throws: No error conditions are expected
  func toUriLiteral(literal:String?) -> String?

  /// Converts URI literal representation to default literal representation.
  /// Returns `nil` if the literal is `nil`. Checks the presence of a required prefix and of required surrounding quotation marks but does not perform any further validation.
  /// - parameters:
  ///   - literal: the literal in URI representation
  /// - returns: default literal representation as String
  /// - throws: EdmPrimitiveTypeException if a required prefix or required surrounding quotation marks are missing
  func fromUriLiteral(literal:String?) throws -> String?

}
