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
//  ClientEntitySetImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 13/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class ClientEntitySetImpl:AbstractClientPayload, ClientEntitySet {
  
  // MARK: - Stored Properties

  /// Link to the next page
  public let next:NSURL?  //G
  /// Number of ODataEntities contained in this entity set
  public var count:Int = 0 //GS
  // TODO: Deltas
  //public var deltaLink:NSURL //GS
  public var entities: [ClientEntity] = []  //GS
  // TODO : Annotations
  //public let annotations: [ClientAnnotation] = [] //G
  
  
  // MARK: - Computed Properties
  
  
  // MARK: - Init

  init() {
    self.next = nil
    super.init(name: "")
  }

  init(next:NSURL) {
    self.next = next
    super.init(name: "")

  }
  
  // MARK: - Methods

  //TODO: func hashCode() -> Int
  /*
  public func hashCode() -> Int {
    final int prime = 31
    int result = super.hashCode()
    result = prime * result + ((count == nil) ? 0 : count.hashCode())
    result = prime * result + ((next == nil) ? 0 : next.hashCode())
    result = prime * result + ((annotations == nil) ? 0 : annotations.hashCode())
    result = prime * result + ((deltaLink == nil) ? 0 : deltaLink.hashCode())
    result = prime * result + ((entities == nil) ? 0 : entities.hashCode())
    return result
  }
 */
  
  public override func toString() -> String {
    return "ClientEntitySetImpl [deltaLink='', entities=\(entities), annotations='', next=\(next), count=\(count)super[\(super.toString())]]"
    // TODO: Delta
    //return "ClientEntitySetImpl [deltaLink=\(deltaLink), entities=\(entities), annotations='', next=\(next), count=\(count)super[\(super.toString())]]"
    //TODO: annotations
    // return "ClientEntitySetImpl [deltaLink=\(deltaLink), entities=\(entities), annotations=\(annotations), next=\(next), count=\(count)super[\(super.toString())]]"
  }
}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:ClientEntitySetImpl,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is ClientEntitySetImpl) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? ClientEntitySetImpl else {
    return false
  }
  if lhs === rhs {
    return true
  }
  
  if lhs.count != rhs.count {
    return false
  }
  if lhs.next == nil {
    if rhs.next != nil {
      return false
    }
  }
  else if lhs.next != rhs.next {
    return false
  }
  if lhs.entities.count !=  rhs.entities.count {
    return false
  }
  else {
    var i = 0
    for entity in lhs.entities {
      if !(entity.isEqualTo(rhs.entities[i])) {
        return false
      }
      i += 1
      
    }
  }
  
  // TODO: Deltas & annotations
  /*
  if lhs.deltaLink != rhs.deltaLink {
    return false
  }
  if lhs.annotations != rhs.annotations {
    return false
  }
 */
  return true
}

