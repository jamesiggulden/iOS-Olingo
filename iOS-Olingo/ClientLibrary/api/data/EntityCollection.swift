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



//
//  EntityCollection.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


 /// Data representation for a collection of single entities.

public class EntityCollection {  // extends AbstractEntityCollection {
  
  // MARK: - Stored Properties


  
  public let entities:[Entity] = [Entity]()
  public var count:Int = 0  //GS
  public var next: NSURL //GS
  public var deltaLink: NSURL  //GS
  
  // MARK: - Computed Properties


  // MARK: - Init
  init () {
    next = NSURL()
    deltaLink = NSURL()
  }

  // MARK: - Methods
  

  

//  public Iterator<Entity> iterator() {
//    return this.entities.iterator()
//  }
  
  // TODO: func equals(o:Object) -> Bool
//  public func equals(o:Object) -> Bool {
//    if (!super.equals(o)) {
//      return false
//    }
//    let  other = o as! EntityCollection
//    return entities.equals(other.entities)
//      && (count == null ? other.count == null : count.equals(other.count))
//      && (next == null ? other.next == null : next.equals(other.next))
//      && (deltaLink == null ? other.deltaLink == null : deltaLink.equals(other.deltaLink))
//  }
  
  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    int result = super.hashCode()
//    result = 31 * result + entities.hashCode()
//    result = 31 * result + (count == null ? 0 : count.hashCode())
//    result = 31 * result + (next == null ? 0 : next.hashCode())
//    result = 31 * result + (deltaLink == null ? 0 : deltaLink.hashCode())
//    return result
//  }
}
