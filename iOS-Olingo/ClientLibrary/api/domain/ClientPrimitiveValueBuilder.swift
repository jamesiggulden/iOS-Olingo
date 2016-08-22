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
//  Builder.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public protocol ClientPrimitiveValueBuilder {
  
  /// set primitive type
  /// - parameters:
  ///   - type: EDM primitive type
  /// - returns: Primtive Value Builder instance
  /// - throws: IllegalArgumentException.InvalidFormat
  func setType(type:EdmType ) throws -> ClientPrimitiveValueBuilderImpl?
  
  /// set primitive type
  /// - parameters:
  ///   - type: EDM primitive type kind
  /// - returns: Primtive Value Builder instance
  /// - throws: IllegalArgumentException.InvalidFormat
  func setType(type:EdmPrimitiveTypeKind?) throws  -> ClientPrimitiveValueBuilderImpl
  
  /// set value
  /// - parameters:
  ///   - value: value to set
  /// - returns: Primtive Value Builder instance
  /// - throws: IllegalArgumentException.InvalidFormat
  func setValue(value:Any?) -> ClientPrimitiveValueBuilderImpl
  
  /// build client primtive value instance
  /// - parameters:
  ///   - none:
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  func build() throws -> ClientPrimitiveValue
 
  /// build boolean primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  func buildBoolean(value:Bool) throws -> ClientPrimitiveValue
  
  /// build int16 primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  func buildInt16(value:Int16) throws -> ClientPrimitiveValue
  
  /// build int32 primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  func buildInt32(value:Int32) throws -> ClientPrimitiveValue
  
  /// build int64 primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  func buildInt64(value:Int64) throws -> ClientPrimitiveValue
  
  /// build single primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  func buildSingle(value:Float32) throws -> ClientPrimitiveValue
  
  /// build double primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  func buildDouble(value:Float64) throws -> ClientPrimitiveValue
  
  /// build string primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  func buildString(value:String) throws -> ClientPrimitiveValue
  
  /// build guid primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  func buildGuid(value:NSUUID) throws -> ClientPrimitiveValue
  
  /// build binary primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  func buildBinary(value:[UInt8]) throws -> ClientPrimitiveValue
  
  /// build decimal primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  func buildDecimal(value:NSDecimalNumber) throws -> ClientPrimitiveValue
  
  /// build duration primtive value instance
  /// - parameters:
  ///   - value: value to build with
  /// - returns: Primitive Value
  /// - throws: IllegalArgumentException.InvalidFormat
  func buildDuration(value:NSDecimalNumber) throws -> ClientPrimitiveValue

}

