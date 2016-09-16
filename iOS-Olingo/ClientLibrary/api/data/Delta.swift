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
//  Delta.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 07/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


/// A Delta instance contains all added and deleted links and all deleted entities.
public class Delta : EntityCollection {
  
  // MARK: - Stored Properties

  /// list of deleted entities
  public let deletedEntities:[DeletedEntity] = []     //G
  /// list of added links
  public let addedLinks:[DeltaLink] = []  //G
  /// list of deleted links
  public let deletedLinks:[DeltaLink] = []  //G
  
  // MARK: - Computed Properties
  
  // MARK: - Init

  // MARK: - Methods
  
  // TODO: func hashCode() ->Int
//  public func hashCode() ->Int {
//    int result = super.hashCode();
//    result = 31 * result + deletedEntities.hashCode();
//    result = 31 * result + addedLinks.hashCode();
//    result = 31 * result + deletedLinks.hashCode();
//    return result;
//  }
}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:Delta,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is Delta) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? Delta else {
    return false
  }
  if lhs === rhs {
    return true
  }
  
  if lhs.deletedEntities != rhs.deletedEntities {
    return false
  }
  if lhs.addedLinks != rhs.addedLinks {
    return false
  }
  if lhs.deletedLinks != rhs.deletedLinks {
    return false
  }

  return true
}


