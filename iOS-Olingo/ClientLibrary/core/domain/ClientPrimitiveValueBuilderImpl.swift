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


//
//  BuilderImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class BuilderImpl: Builder {
    
    var instance:ClientPrimitiveValueImpl
    
    init() {
      instance =  ClientPrimitiveValueImpl()
    }
  
    
    public func setType(type: EdmType ) throws -> BuilderImpl {
      let  primitiveTypeKind: EdmPrimitiveTypeKind?
      if (type.getKind() != EdmTypeKind.PRIMITIVE) {
        throw IllegalArgumentException(String.format("Provided type %s is not primitive", type))
      }
      primitiveTypeKind = EdmPrimitiveTypeKind.valueOf(type.getName())
      
      return setType(primitiveTypeKind)
    }
    
    
    public func setType(type: EdmPrimitiveTypeKind) throws -> BuilderImpl{
      if (type == EdmPrimitiveTypeKind.Stream) {
        throw IllegalArgumentException.InvalidFormat //(String.format("Cannot build a primitive value for %s", EdmPrimitiveTypeKind.Stream.toString()))
      }
      if (type == EdmPrimitiveTypeKind.Geography || type == EdmPrimitiveTypeKind.Geometry) {
        throw IllegalArgumentException.InvalidFormat  //("\(type) is not an instantiable type. An entity can declare a property to be of type Geometry. An instance of an entity MUST NOT have a value of type Geometry. Each value MUST be of some subtype.")
      }
      
      instance.typeKind = type == nil ? EdmPrimitiveTypeKind.String : type
      instance.type = EdmPrimitiveTypeFactory.getInstance(instance.typeKind)
      
      return self
    }
    
    
    public func setValue(value:AnyObject) -> BuilderImpl {
      instance.value = value
      return self
    }
    
    
    public func build() throws -> ClientPrimitiveValue {
      if (instance.type == nil) {
        do {
          try setType(EdmPrimitiveTypeKind.String)
        }
        
      }
      return instance
    }
    
    
    public func buildBoolean(Boolean value:Bool) throws -> ClientPrimitiveValue {
      do {
      return try setType(EdmPrimitiveTypeKind.Boolean).setValue(value).build()
      }
    }
    
    
    public func buildInt16(value:Int) throws ->ClientPrimitiveValue {
      do {
        return try setType(EdmPrimitiveTypeKind.Int16).setValue(value).build()
      }
    }
    
    
    public func buildInt32(value: Int) throws -> ClientPrimitiveValue {
      do {
        return try setType(EdmPrimitiveTypeKind.Int32).setValue(value).build()
      }
    }
    
    
    public func buildInt64(value:Int64) throws -> ClientPrimitiveValue { // long
      do {
        return try setType(EdmPrimitiveTypeKind.Int64).setValue(value).build()
      }
    }
    
    
    public func buildSingle(value:Float) throws -> ClientPrimitiveValue {
      do {
        return try setType(EdmPrimitiveTypeKind.Single).setValue(value).build()
      }
    }
    
    
    public func buildDouble(value:Double) throws -> ClientPrimitiveValue {
      do {
        return try setType(EdmPrimitiveTypeKind.Double).setValue(value).build()
      }
    }
    
    
    public func buildString(value:String) throws -> ClientPrimitiveValue {
      do {
        return try setType(EdmPrimitiveTypeKind.String).setValue(value).build()
      }
    }
    
    
    public func buildGuid(value:NSUUID) throws -> ClientPrimitiveValue {
      do {
        return try setType(EdmPrimitiveTypeKind.Guid).setValue(value).build()
      }
    }
    
    
    public func buildBinary(value:[UInt8]) throws -> ClientPrimitiveValue { //byte[]
      do {
        return try setType(EdmPrimitiveTypeKind.Binary).setValue(value).build()
      }
    }
    
    
  public func buildDecimal(value:NSDecimal) throws -> ClientPrimitiveValue{
    do {
      return try setType(EdmPrimitiveTypeKind.Decimal).setValue(value).build()
      }
    }
    
    
  public func buildDuration(BigDecimal value:NSDecimal) throws -> ClientPrimitiveValue{
    do {
      return try setType(EdmPrimitiveTypeKind.Duration).setValue(value).build()
    }
  }
    
  }

