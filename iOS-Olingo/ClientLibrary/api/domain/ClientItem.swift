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
//  ClientItem.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 13/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * Abstract representation of OData entities and links.
 */
public class ClientItem {
  
  // MARK: - Stored Properties

  /// OData entity name/type
  public let name:String //G
  /// OData item self link
  public var link:NSURL? //GS
  
  // MARK: - Computed Properties

  // MARK: - Init

  init(name:String) {
    self.name = name
  }
  
  // MARK: - Methods
  
  // TODO: func hashCode() -> Int
    /*
  public func hashCode() -> Int {
  final int prime = 31
  int result = 1
  result = prime * result + ((link == null) ? 0 : link.hashCode())
  result = prime * result + ((name == null) ? 0 : name.hashCode())
  return result
  }
 */
  
  
  public func toString() -> String {
    return "ClientItem [name=\(name), link=\(link)]"
  }
}

extension ClientItem:Equatable {}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:ClientItem,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is ClientItem) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? ClientItem else {
    return false
  }
  if lhs === rhs {
    return true
  }
  
  if lhs.link == nil {
    if rhs.link != nil {
      return false
    }
  } else if lhs.link != rhs.link {
    return false
  }
  if lhs.name != rhs.name {
    return false
  }
  return true
}

