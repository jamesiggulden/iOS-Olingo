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
//  Link.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

 /// Data representation for a link.

public class Link {  //extends Annotatable {
  
  // MARK: - Stored Properties

  public var title:String = "" // GS
  public var rel:String = ""//GS
  public var href:String = "" //GS
  public var type:String = ""  //GS
  public var mediaETag:String = "" //GS
  public lazy var entity:Entity = Entity()  //GS
  public lazy var entitySet:EntityCollection = EntityCollection() //GS
  /// If this is a "toOne" relationship this method delivers the binding link or ""(isEmpty) if not set
  public var bindingLink:String = ""
  /// If this is a "toMany" relationship this method delivers the binding links or `emptyList` if not set
  public var bindingLinks:[String] = [String]()
  
  // MARK: - Computed Properties
  
  var inlineEntity:Entity {
    get{
      return entity
    }
    set(entity) {
      self.entity = entity
    }
  }
  
  var inlineEntitySet:EntityCollection {
    get{
      return entitySet
    }
    set(entitySet) {
      self.entitySet = entitySet
    }
  }
  
  // MARK: - Init
  

  // MARK: - Methods
  
  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    int result = getAnnotations().hashCode()
//    result = 31 * result + (title == null ? 0 : title.hashCode())
//    result = 31 * result + (rel == null ? 0 : rel.hashCode())
//    result = 31 * result + (href == null ? 0 : href.hashCode())
//    result = 31 * result + (type == null ? 0 : type.hashCode())
//    result = 31 * result + (mediaETag == null ? 0 : mediaETag.hashCode())
//    result = 31 * result + (entity == null ? 0 : entity.hashCode())
//    result = 31 * result + (entitySet == null ? 0 : entitySet.hashCode())
//    result = 31 * result + (bindingLink == null ? 0 : bindingLink.hashCode())
//    result = 31 * result + bindingLinks.hashCode()
//    return result
//  }
  
}

// MARK: - Extension

extension Link:Equatable {}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:Link,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is Link) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? Link else {
    return false
  }
  if lhs === rhs {
    return true
  }
  
  if lhs.title.isEmpty ? lhs.title != rhs.title : !rhs.title.isEmpty {
    return false
  }
  if lhs.rel.isEmpty ? lhs.rel != lhs.rel : !rhs.rel.isEmpty {
    return false
  }
  if lhs.href.isEmpty ? lhs.href != rhs.href : !rhs.href.isEmpty {
    return false
  }
  if lhs.type.isEmpty ? lhs.type != lhs.type : !rhs.type.isEmpty {
    return false
  }
  if lhs.mediaETag.isEmpty ? lhs.mediaETag != rhs.mediaETag : !rhs.mediaETag.isEmpty {
    return false
  }
  // TODO : Entity set and entity objects
  /*
  if lhs.entity.isEmpty ? lhs.entity != lhs.entity : !rhs.entity.isEmpty {
    return false
  }
  if lhs.entitySet.isEmpty ? lhs.entitySet != rhs.entitySet : !rhs.hentitySet.isEmpty {
    return false
  }
 */
  if lhs.bindingLink.isEmpty ? lhs.bindingLink != lhs.bindingLink : !rhs.bindingLink.isEmpty {
    return false
  }
  if lhs.bindingLinks.isEmpty ? lhs.bindingLinks != rhs.bindingLinks : !rhs.bindingLinks.isEmpty {
    return false
  }
  // TO: Annotations
  /*
  if lhs.annotations != rhs.getAnnotations
    return false
  }
 */
  return true

}

