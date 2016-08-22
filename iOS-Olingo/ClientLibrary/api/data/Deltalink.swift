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
//  Deltalink.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 07/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

 /// A delta link.
public class DeltaLink { //: Annotatable {
  
  // MARK: - Stored Properties

  public var source:NSURL = NSURL() //GS
  public var relationship:String = "" //GS
  public var target:NSURL = NSURL() //GS
  
  // MARK: - Computed Properties


  // MARK: - Init
  
  
  // MARK: - Methods

  // TODO: func equals(final Object o) -> Bool
//  public func equals(final Object o) -> Bool {
//    if (this == o) {
//      return true
//    }
//    if (o == null || getClass() != o.getClass()) {
//      return false
//    }
//    
//    final DeltaLink other = (DeltaLink) o
//    return getAnnotations().equals(other.getAnnotations())
//      && (source == null ? other.source == null : source.equals(other.source))
//      && (relationship == null ? other.relationship == null : relationship.equals(other.relationship))
//      && (target == null ? other.target == null : target.equals(other.target))
//  }
  
  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    int result = getAnnotations().hashCode()
//    result = 31 * result + (source == null ? 0 : source.hashCode())
//    result = 31 * result + (relationship == null ? 0 : relationship.hashCode())
//    result = 31 * result + (target == null ? 0 : target.hashCode())
//    return result
//  }
}
