/*
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with this work for additional information
  regarding copyright ownership.  The ASF licenses this file
  to you under the Apache License, Version 2.0 (the
  "License"); you may not use this file except in compliance
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
//  BuilderImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class ClientPrimitiveValueBuilderImpl: ClientPrimitiveValueBuilder {
  
  // MARK: - Stored Properties
  
  public var instance:ClientPrimitiveValueImpl
  
  // MARK: - Computed Properties

  // MARK: - Init

  init() {
    instance = ClientPrimitiveValueImpl()
  }
  
  // MARK: - Methods
     
  /// set primitive type
  /// - parameters:
  ///   - type: EDM primitive type
  /// - returns: Primtive Value Builder instance
  /// - throws: IllegalArgumentException.InvalidFormat
  public func setType(type: EdmType ) throws -> ClientPrimitiveValueBuilderImpl? {
    let  primitiveTypeKind: EdmPrimitiveTypeKind?
    if (type.kind != EdmTypeKind.PRIMITIVE) {
      throw IllegalArgumentException.InvalidFormat // (String.format("Provided type %s is not primitive", type))
    }
    primitiveTypeKind = EdmPrimitiveTypeKind(rawValue: type.name)
    if primitiveTypeKind != nil {
      return try setType(primitiveTypeKind!)
    }
    else {
      throw IllegalArgumentException.InvalidFormat // (String.format("Provided type %s is not primitive", type))
    }
  }
  
  /// set primitive type
  /// - parameters:
  ///   - type: EDM primitive type kind
  /// - returns: Primtive Value Builder instance
  /// - throws: IllegalArgumentException.InvalidFormat
  public func setType(type: EdmPrimitiveTypeKind?) throws -> ClientPrimitiveValueBuilderImpl {
    if (type == EdmPrimitiveTypeKind.STREAM) {
      throw IllegalArgumentException.InvalidFormat //(String.format("Cannot build a primitive value for %s",
    }
    if (type == EdmPrimitiveTypeKind.GEOGRAPHY || type == EdmPrimitiveTypeKind.GEOMETRY) {
      throw IllegalArgumentException.InvalidFormat  //("\(type) is not an instantiable type. An entity can declare a property to be of type Geometry. An instance of an entity MUST NOT have a value of type Geometry. Each value MUST be of some subtype.")
    }
    if type == nil {
      instance.typeKind = EdmPrimitiveTypeKind.STRING
    }
    else {
      instance.typeKind = type
    }
    instance.type = try EdmPrimitiveTypeFactory.getInstance(instance.typeKind!)
    return self
  }
  
  /// set value
  /// - parameters:
  ///   - value: value to set
  /// - returns: Primtive Value Builder instance
  /// - throws: IllegalArgumentException.InvalidFormat
  public func setValue(value:Any?) -> ClientPrimitiveValueBuilderImpl {
    if let value = value {
      instance.value = value
    }
    return self
  }
  
  /// build client primtive value instance
  /// - parameters:
  ///   - none:
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  public func build() throws -> ClientPrimitiveValue {
    if (instance.type == nil) {
      do {
        try setType(EdmPrimitiveTypeKind.STRING)
      }
    }
    return instance
  }
  
  /// build boolean primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  public func buildBoolean(value:Bool) throws -> ClientPrimitiveValue {
    return try setType(EdmPrimitiveTypeKind.BOOLEAN).setValue(value).build()
  }
  
  /// build int16 primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  public func buildInt16(value:Int16) throws ->ClientPrimitiveValue {
    do {
      return try setType(EdmPrimitiveTypeKind.INT16).setValue(value).build()
    }
  }
  
  /// build int32 primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  public func buildInt32(value: Int32) throws -> ClientPrimitiveValue {
    do {
      return try setType(EdmPrimitiveTypeKind.INT32).setValue(value).build()
    }
  }
  
  /// build int64 primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  public func buildInt64(value:Int64) throws -> ClientPrimitiveValue { // long
    do {
      return try setType(EdmPrimitiveTypeKind.INT64).setValue(value).build()
    }
  }
  
  /// build single primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  public func buildSingle(value:Float) throws -> ClientPrimitiveValue {
    do {
      return try setType(EdmPrimitiveTypeKind.SINGLE).setValue(value).build()
    }
  }
  
  /// build double primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  public func buildDouble(value:Double) throws -> ClientPrimitiveValue {
    do {
      return try setType(EdmPrimitiveTypeKind.DOUBLE).setValue(value).build()
    }
  }
  
  /// build string primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  public func buildString(value:String) throws -> ClientPrimitiveValue {
    do {
      return try setType(EdmPrimitiveTypeKind.STRING).setValue(value).build()
    }
  }
  
  /// build guid primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  public func buildGuid(value:NSUUID) throws -> ClientPrimitiveValue {
    do {
      return try setType(EdmPrimitiveTypeKind.GUID).setValue(value).build()
    }
  }
  
  /// build binary primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  public func buildBinary(value:[UInt8]) throws -> ClientPrimitiveValue { //byte[]
    do {
      return try setType(EdmPrimitiveTypeKind.BINARY).setValue(value).build()
    }
  }
  
  /// build decimal primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  public func buildDecimal(value:NSDecimalNumber) throws -> ClientPrimitiveValue{
    do {
      return try setType(EdmPrimitiveTypeKind.DECIMAL).setValue(value).build()
    }
  }
  
  /// build duration primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  public func buildDuration(value:NSDecimalNumber) throws -> ClientPrimitiveValue {
    do {
      return try setType(EdmPrimitiveTypeKind.DURATION).setValue(value).build()
    }
  }
  
}

