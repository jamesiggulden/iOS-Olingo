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
//  Linked.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 13/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class Linked: AbstractODataObject {
  
  // MARK: - Stored Properties
  
  public let associationLinks:[Link] = []  //G
  public let navigationLinks:[Link] = []  //G
  public let bindingLinks:[Link] = [] //G
  
  // MARK: - Computed Properties

  
  // MARK: - Init
  
  
  // MARK: - Methods
 
  /// Get link by title
  /// - parameters:
  ///   - name: link title
  ///   - links: list of link objects
  /// - returns: link with specified title, or nil if not found
  /// - throws: No error conditions are expected
  func getOneByTitle(name:String, links:[Link]) ->  Link?{
    var result:Link?
    
    for link in links {
      if name == link.title {
        result = link
      }
    }
    return result
  }

  /// Gets association link with given name, if available, otherwise `nil`
  /// - parameters:
  ///   - name: link title
  /// - returns: link with specified title, or nil if not found
  /// - throws: No error conditions are expected
  public func getAssociationLink(name:String) -> Link? {
    return getOneByTitle(name, links: associationLinks)
  }
  
  /// Gets navigation link with given name, if available, otherwise `nil`
  /// - parameters:
  ///   - name: link title
  /// - returns: link with specified title, or nil if not found
  /// - throws: No error conditions are expected
  public func getNavigationLink(name:String) -> Link? {
    return getOneByTitle(name, links: navigationLinks)
  }

  /// Gets binding link with given name, if available, otherwise `nil`
  /// - parameters:
  ///   - name: link title
  /// - returns: link with specified title, or nil if not found
  /// - throws: No error conditions are expected
  public func getNavigationBinding(name:String) -> Link? {
    return getOneByTitle(name, links: bindingLinks)
  }
  
  
  // TODO: func hashCode() -> Int
  /*
  public func hashCode() -> Int {
    int result = super.hashCode()
    result = 31 * result + associationLinks.hashCode()
    result = 31 * result + navigationLinks.hashCode()
    result = 31 * result + bindingLinks.hashCode()
    return result
  }
 */
}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:Linked,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is Linked) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? Linked else {
    return false
  }
  if lhs === rhs {
    return true
  }
  
  if lhs.associationLinks != rhs.associationLinks {
    return false
  }
  if lhs.navigationLinks != rhs.navigationLinks {
    return false
  }
  if lhs.bindingLinks != rhs.bindingLinks {
    return false
  }
  let lhsSuper = lhs as AbstractODataObject
  let rhsSuper = rhs as AbstractODataObject
  
  if lhsSuper != rhsSuper {
    return false
  }
  
  return true
}

