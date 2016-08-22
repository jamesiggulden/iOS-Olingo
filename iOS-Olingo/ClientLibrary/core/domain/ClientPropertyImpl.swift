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
//  ClientPropertyImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public final class ClientPropertyImpl : ClientValuableImpl, ClientProperty {
  
  // MARK: - Stored Properties

  public let annotations:[ClientAnnotation] = []  //G
  public let name:String  //G
  
  // MARK: - Computed Properties

  // MARK: - Init

  init (name:String, value:ClientValue) {
    self.name = name
    super.init(value: value)

  }
  
 // MARK: - Methods

  /// Checks if has null value
  /// - parameters:
  ///   - none
  /// - returns: 'TRUE' if has null value 'FALSE' otherwise
  /// - throws: No error conditions are expected
  public func hasNilValue() -> Bool {
    return true
    // TODO:
    //return value == nil || value.isPrimitive() && value.asPrimitive().toValue() == nil
  }
  

  public override func equals(obj : AnyObject) -> Bool {
    if (self === obj) {
      return true
    }
    else {
      return false
      // TODO: Expand on checks if objects are not identical
//      if (obj == null || !(obj instanceof ClientPropertyImpl)) {
//        return false
//      }
//      final ClientPropertyImpl other = (ClientPropertyImpl) obj
//      return annotations.equals(other.annotations)
//        && (name == null ? other.name == null : name.equals(other.name))
//        && (value == null ? other.value == null : value.equals(other.value))
//
    }
      }
  
  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    final int prime = 31
//    int result = 1
//    result = prime * result + ((annotations == null) ? 0 : annotations.hashCode())
//    result = prime * result + ((name == null) ? 0 : name.hashCode())
//    result = prime * result + ((value == null) ? 0 : value.hashCode())
//    return result
//  }
   
  /// Return proerties as a string
  /// - parameters:
  ///   - none
  /// - returns: Properties as String with format of ClientPropertyImpl{nameA = value of nameA,nameB = value of nameB, etc}
  /// - throws: No error conditions are expected
  public override func toString() -> String {
    return "ClientPropertyImpl{name=\(name), value=\(value), annotations=\(annotations)}"
  }
}

