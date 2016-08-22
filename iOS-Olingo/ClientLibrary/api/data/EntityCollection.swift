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
//  EntityCollection.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


 /// Data representation for a collection of single entities.

public class EntityCollection : AbstractODataObject,IEntityCollection {
  
  // MARK: - Stored Properties

  public var entities:[Entity] = [Entity]() //GS
  public var count:Int = 0  //GS
  public var next: NSURL? //GS
  public var deltaLink: NSURL?  //GS
  
  // MARK: - Computed Properties

  // MARK: - Init
  override init () {
    next = NSURL()
    deltaLink = NSURL()
  }

  // MARK: - Methods
 
  public override func equals(o:AnyObject) -> Bool {
    if (!super.equals(o)) {
      return false
    }
    else {
      return true
      //TODO: Add additional checks
      /*
      let  other = o as! EntityCollection
      return entities == other.entities
        && (count == nil ? other.count == nil : count.equals(other.count))
        && (next == nil ? other.next == nil : next.equals(other.next))
        && (deltaLink == nil ? othe.deltaLink == nil : deltaLink.equals(other.deltaLink))
      */
    }
    
  }
  
  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    int result = super.hashCode()
//    result = 31 * result + entities.hashCode()
//    result = 31 * result + (count == nil ? 0 : count.hashCode())
//    result = 31 * result + (next == nil ? 0 : next.hashCode())
//    result = 31 * result + (deltaLink == nil ? 0 : deltaLink.hashCode())
//    return result
//  }
}
