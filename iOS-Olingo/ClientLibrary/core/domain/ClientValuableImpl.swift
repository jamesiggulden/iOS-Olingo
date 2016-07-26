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
//  ClientValuableImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class ClientValuableImpl : ClientValuable {
  
  // MARK: - Stored Properties


  public let value: ClientValue //G
  
  // MARK: - Computed Properties
  
  
  public var hasNilValue:Bool {
    get {
      //TODO: Can nver be nil Redundent or need to modify?
      //return self.value == nil
      return false
    }
  }
  
  
  
  public var hasPrimitiveValue: Bool {
    get {
      return !hasNilValue && self.value.isPrimitive
    }
  }
  
  public var primitiveValue: ClientPrimitiveValue?  {
    get {
      if hasPrimitiveValue {
        return self.value.asPrimitive
      }
      else {
        return nil
      }
      //return hasPrimitiveValue ? self.value.asPrimitive : nil
    }
  }
  
  
  public var hasCollectionValue: Bool {
    get {
      return !hasNilValue && self.value.isCollection
    }
  }
  
  public var hasComplexValue: Bool {
    return !hasNilValue && self.value.isComplex
  }
  
  // TODO: public var getComplexValue: ClientComplexValue?
  
  public var complexValue: ClientComplexValue? {
    return hasComplexValue ? value.asComplex : nil
  }
  
  
  public var hasEnumValue: Bool {
    return !hasNilValue && value.isEnum()
  }
  
  public var enumValue: ClientEnumValue?{
    return hasEnumValue ? value.asEnum() : nil
  }
  
  public var collectionValue:ClientCollectionValue? {
    get {
      return hasCollectionValue ? value.asCollection : nil
    }
  } 
  

  // MARK: - Init

  init(value:ClientValue) {
    self.value = value
  }
  
  // MARK: - Methods
  
  // TODO: getCollectionValue() -> ClientCollectionValue<ClientValue>
  // replaced with compurted property
  /*
  public func getCollectionValue() -> ClientCollectionValue? {
    return hasCollectionValue ? value.asCollection : nil
  }
 */

 
  
  public func equals(o: AnyObject) -> Bool {
    if (self === o) {
      return true
    }
    else {
      return false
      //TODO: Additional checks for equals
      /*
      if object_getClassName(self) != object_getClassName(o) {
        return false
      }
      
      let that =  o as! ClientValuableImpl
      return !(self.value != nil ? !self.value == that.value : that.value != nil)
        */
    }
    
  }
  
  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    return self.value != nil ? self.value.hashCode() : 0
//  }
  
  
  public func toString() -> String {
    return "ClientValuableImpl{value=\(self.value)}"
  }
}
