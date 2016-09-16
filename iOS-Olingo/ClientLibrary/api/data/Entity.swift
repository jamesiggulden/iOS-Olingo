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
//  Entity.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * Data representation for a single entity.
 */
// TODO: Add linked abstract
public class Entity:AbstractODataObject { //:Linked and then AbstractODataObject
  
  // MARK: - Stored Properties
  
  public var eTag:String = ""  // GS
  public var type:String = ""  // GS
  public var readLink:Link = Link()  // GS
  public var editLink:Link? // = Link()  // GS
  public let mediaEditLinks:[Link] = [Link]() //G
  public let operations:[Operation] = [Operation]()  //G
  public var properties:[Property] = [Property]()  //G
  public var mediaContentType:String = "" //GS
  public var mediaContentSource:NSURL? //GS
  public var mediaETag:String = ""  //GS
  
  // MARK: - Computed Properties
  
  public var selfLink:Link? {
    get{
      return readLink
    }
    set(selfLink) {
      readLink = selfLink!
    }
  }
  
  /// Checks if the current entity is a media entity.  Returns 'TRUE' if is a media entity 'FALSE' otherwise
  public var isMediaEntity: Bool {
    if mediaContentSource != nil {
      return true
    }
    else {
      return false
    }
  }

  // MARK: - Init
  
  override init() {
    super.init()
  }

  // MARK: - Methods
   
  /// Add property to this Entity
  /// - parameters:
  ///   - property: property to be added
  /// - returns: this Entity for fluid/flow adding
  /// - throws: No error conditions are expected
  public func addProperty(property:Property) -> Entity {
    properties.append(property)
    return self
  }
   
  /// Gets property with given name
  /// - parameters:
  ///   - name: property name
  ///   - param2: add or remove params from list as required
  /// - returns: property with given name if found, nil otherwise
  /// - throws: No error conditions are expected
  public func getProperty(name:String) -> Property?{
    var result:Property?
    
    for property in properties {
      if (name == property.name) {
        result = property
        break
      }
    }
    return result
  }
  
  // TODO: func hashCode() -> Int
  /*
  public func hashCode() -> Int {
    int result = super.hashCode()
    result = 31 * result + (eTag == null ? 0 : eTag.hashCode())
    result = 31 * result + (type == null ? 0 : type.hashCode())
    result = 31 * result + (readLink == null ? 0 : readLink.hashCode())
    result = 31 * result + (editLink == null ? 0 : editLink.hashCode())
    result = 31 * result + mediaEditLinks.hashCode()
    result = 31 * result + operations.hashCode()
    result = 31 * result + properties.hashCode()
    result = 31 * result + (mediaContentSource == null ? 0 : mediaContentSource.hashCode())
    result = 31 * result + (mediaContentType == null ? 0 : mediaContentType.hashCode())
    result = 31 * result + (mediaETag == null ? 0 : mediaETag.hashCode())
    return result
  }
 */
  
  // TODO: func toString() -> String
  /*
  public func toString() -> String {
    return properties.toString()
  }
 */
}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:Entity,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is Entity) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? Entity else {
    return false
  }
  if lhs === rhs {
    return true
  }
  let lhsSuper = lhs as AbstractODataObject
  let rhsSuper = rhs as AbstractODataObject
  if lhsSuper != rhsSuper {
    return false
  }
  
  if lhs.eTag != rhs.eTag {
    return false
  }
  if lhs.type != rhs.type {
    return false
  }
  if lhs.readLink != rhs.readLink {
    return false
  }
  if lhs.editLink != rhs.editLink {
    return false
  }
  if lhs.mediaEditLinks != rhs.mediaEditLinks {
    return false
  }
  // TODO: equality check
  /*
  if lhs.operations != rhs.operations {
    return false
  }
 */
  if lhs.properties != rhs.properties {
    return false
  }
  if lhs.mediaContentSource != rhs.mediaContentSource {
    return false
  }
  if lhs.mediaContentType != rhs.mediaContentType {
    return false
  }
  if lhs.mediaETag != rhs.mediaETag {
    return false
  }
  
  return true
}

