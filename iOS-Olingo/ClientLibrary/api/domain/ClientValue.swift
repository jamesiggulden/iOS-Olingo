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
//  ClientValue.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Protocol for an abstract representation of an OData entity property value
public protocol ClientValue {
  
  
  /// Type name
  var typeName:String? {get}
  
  /// Check is a primitive value
  var isPrimitive: Bool {get}
  
  /// Casts to primitive value
  var asPrimitive: ClientPrimitiveValue? {get}
  
  /// Check is a collection value
  var isCollection: Bool {get}
  
  /// Casts to collection value
  var asCollection: ClientCollectionValue? {get}
  //<T extends ClientValue> ClientCollectionValue<T> asCollection()
  
  /// Casts to complex value
  var  asComplex: ClientComplexValue? {get}
  
  /// Check is a complex value
  var isComplex: Bool {get}
  
  /**
   * Check is is an enum value.
   *
   * @return 'TRUE' if enum 'FALSE' otherwise.
   */
  func isEnum() -> Bool
  
  /**
   * Casts to enum value.
   *
   * @return enum value.
   */
  func asEnum() -> ClientEnumValue
  
}

