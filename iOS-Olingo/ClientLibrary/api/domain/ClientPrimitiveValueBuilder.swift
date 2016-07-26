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
//  Builder.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public protocol ClientPrimitiveValueBuilder {
  
  func setType(type:EdmType ) throws -> ClientPrimitiveValueBuilderImpl?
  //func setType(type:EdmType ) throws -> ClientPrimitiveValueBuilder?
  
  
  func setType(type:EdmPrimitiveTypeKind?) throws  -> ClientPrimitiveValueBuilderImpl
  //func setType(type:EdmPrimitiveTypeKind ) throws  -> ClientPrimitiveValueBuilder
  
  func setValue(value:Any) -> ClientPrimitiveValueBuilderImpl
  //func setValue(value:Any) -> ClientPrimitiveValueBuilder
  
  
  
  func build() throws -> ClientPrimitiveValue
  
  
 
  func buildBoolean(value:Bool) throws -> ClientPrimitiveValue
  
  func buildInt16(value:Int16) throws -> ClientPrimitiveValue
  
  func buildInt32(value:Int32) throws -> ClientPrimitiveValue
  
  func buildInt64(value:Int64) throws -> ClientPrimitiveValue
  
  func buildSingle(value:Float32) throws -> ClientPrimitiveValue
  
  func buildDouble(value:Float64) throws -> ClientPrimitiveValue
  
  
  func buildString(value:String) throws -> ClientPrimitiveValue
  
  func buildGuid(value:NSUUID) throws -> ClientPrimitiveValue
  
  func buildBinary(value:[UInt8]) throws -> ClientPrimitiveValue
 
  
  func buildDecimal(value:NSDecimalNumber) throws -> ClientPrimitiveValue
  
  func buildDuration(value:NSDecimalNumber) throws -> ClientPrimitiveValue
 
 
}

