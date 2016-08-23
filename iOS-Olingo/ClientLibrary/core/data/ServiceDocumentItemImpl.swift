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
//  ServiceDocumentItemImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 07/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public final class ServiceDocumentItemImpl: ServiceDocumentItem {
  
  // MARK: - Stored Properties

  public var name:String = ""
  public var url:String = ""
  public var title:String = ""
  
  // MARK: - Computed Properties
  
  
  // MARK: - Init


  // MARK: - Methods

  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    final int prime = 31
//    int result = 1
//    result = prime * result + ((name == null) ? 0 : name.hashCode())
//    result = prime * result + ((title == null) ? 0 : title.hashCode())
//    result = prime * result + ((url == null) ? 0 : url.hashCode())
//    return result
//  }
  

  public func toString() -> String {
    return "ServiceDocumentItemImpl{name='\(name)', url='\(url)', title='\(title)'}"
  }

}

extension ServiceDocumentItemImpl:Equatable {}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:ServiceDocumentItemImpl,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is ServiceDocumentItemImpl) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? ServiceDocumentItemImpl else {
    return false
  }
  if lhs === rhs {
    return true
  }
  if lhs.name.isEmpty {
    if !rhs.name.isEmpty {
      return false
    }
  }
  else if lhs.name != rhs.name {
    return false
  }
  if lhs.title.isEmpty {
    if !rhs.title.isEmpty {
      return false
    }
  }
  else if lhs.title != rhs.title {
    return false
  }
  if lhs.url.isEmpty {
    if !rhs.url.isEmpty {
      return false
    }
  }
  else if lhs.url != rhs.url {
    return false
  }
  return true
  
}


