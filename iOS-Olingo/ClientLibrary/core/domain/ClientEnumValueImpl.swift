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
//  ClientEnumValueImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 13/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class ClientEnumValueImpl: AbstractClientValue, ClientEnumValue {
  
  // MARK: - Stored Properties

  public var value:String?  // G
  
  // MARK: - Computed Properties
  
  override public var isEnum:Bool {
    get {
      return true
    }
  }
  
  public override var isComplex:Bool {
    get {
      return true
    }
  }
  
  public func asEnum() -> ClientEnumValue? {
    return self
  }
  

  // MARK: - Init

  init(typeName:String, value:String) {
    super.init(typeName: typeName)
    self.value = value
  }
  
  // MARK: - Methods
  
  public override func toString() -> String {
    return "\(super.typeName)'\(value)'"
    
  }
  
  //TODO: func hashCode() -> Int
  /*
  public func hashCode() -> Int {
    final int prime = 31
    int result = super.hashCode()
    result = prime * result + ((value == null) ? 0 : value.hashCode())
    return result
  }
 */
  
  
  public override func equals(obj:AnyObject) -> Bool {
    if (self === obj) {
      return true
    }
    else {
      return false
      //TODO: Add extra checks
      /*
      if (!super.equals(obj)) {
        return false
      }
      if (!(obj instanceof ClientEnumValueImpl)) {
        return false
      }
      ClientEnumValueImpl other = (ClientEnumValueImpl) obj
      if (value == null) {
        if (other.value != null) {
          return false
        }
      } else if (!value.equals(other.value)) {
        return false
      }
      return true
      */
    }
    
  }
}
