
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
//  AbstractClientPayload.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 13/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// OData entity
public class AbstractClientPayload : ClientItem {
  
  // MARK: - Stored Properties

  /// The context URL describes the content of the payload. It consists of the canonical metadata document URL and a fragment identifying the relevant portion of the metadata document
  public var contextURL:NSURL? //GS
  
  // MARK: - Computed Properties

  // MARK: - Init

  override init (name:String) {
    super.init(name: name)
  }
  
  // MARK: - Methods

  // TODO: func hashCode() -> Int
  /*
  public func hashCode() -> Int {
    final int prime = 31
    int result = super.hashCode()
    result = prime * result + ((contextURL == null) ? 0 : contextURL.hashCode())
    return result
  }
 */
 
  public override func toString() -> String {
    return "AbstractClientPayload [contextURL=\(contextURL)super[\(super.toString())]]"
  }
}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:AbstractClientPayload,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is AbstractClientPayload) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? AbstractClientPayload else {
    return false
  }
  if lhs === rhs {
    return true
  }
  
  if lhs.contextURL == nil {
    if (rhs.contextURL != nil) {
      return false
    }
  }
  else if lhs.contextURL != rhs.contextURL {
    return false
  }
  return true
}

