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
//  ClientValuable.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public protocol ClientValuable {
  
  // MARK: - Protocol Properties
  
  /// client value.
  var value: ClientValue {get}
  /// Checks if has nil value
  var hasNilValue: Bool {get}
  /// Checks if has primitive value
  var hasPrimitiveValue: Bool {get}
  /// Gets primitive value
  var primitiveValue: ClientPrimitiveValue? {get}
  /// Checks if has collection value
  var hasCollectionValue: Bool {get}
  /// Gets collection value
  var collectionValue: ClientCollectionValue? {get}
  /// Checks if has complex value
  var hasComplexValue: Bool {get}
  /// Gets complex value
  var complexValue:ClientComplexValue? {get}
  /// Checks if has enum  value
  var hasEnumValue: Bool {get}
  /// Gets enum value
  var enumValue: ClientEnumValue? {get}
  
  // MARK: - Protocol Methods
  
  func isEqualTo(object:ClientValuable) -> Bool
  
}

extension ClientValuable where Self:Equatable {
  public func isEqualTo(object:ClientValuable) -> Bool {
    if let o = object as? Self {
      return o == self
    }
    return false
  }
}
