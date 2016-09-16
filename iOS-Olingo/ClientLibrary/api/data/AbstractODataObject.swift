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
//  AbstractODataObject.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 13/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Abstract OData object with basic values (`id`, `baseURI`, `title`)
public class AbstractODataObject  { // extends Annotatable {
  
  public var baseURI:NSURL?  //GS
  public var id:NSURL?  //GS
  public var title:String?  //G
  

  /// Sets property with given key to given value.
  /// - parameters:
  ///   - key: key of property
  ///   - value: new value for property
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  public func setCommonProperty(key:String,value:String) {
    if "id" == key {
      id = NSURL(string: value)
    }
    else if "title" == key {
      title = value
    }
  }
  
  
  //TODO: func hashCode()-> Int
  /*
  public func hashCode()-> Int {
    int result = getAnnotations().hashCode()
    result = 31 * result + (baseURI == nil ? 0 : baseURI.hashCode())
    result = 31 * result + (id == nil ? 0 : id.hashCode())
    result = 31 * result + (title == nil ? 0 : title.hashCode())
    return result
  }
 */
}

extension AbstractODataObject:Equatable {}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:AbstractODataObject,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is AbstractODataObject) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? AbstractODataObject else {
    return false
  }
  if lhs === rhs {
    return true
  }
  if lhs.baseURI != rhs.baseURI {
    return false
  }
  if lhs.id != rhs.id {
    return false
  }
  if lhs.title != rhs.title {
    return false
  }
  return true
}


