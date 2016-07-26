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
//  ComplexValue.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Represents the value of a complex property
public class ComplexValue { //TODO: extends Linked {
  
  // MARK: - Stored Properties
 
  public let value:[Property] = []  //G

  // MARK: - Computed Properties

  
  // MARK: - Init

  
  // MARK: - Methods

  public func equals( o:AnyObject) -> Bool {
    return true
    // TODO: Add checks
    //return super.equals(o) && value.equals(((ComplexValue) o).value)
  }
  
  // TODO: func hashCode() -> Int 
  /*
  public func hashCode() -> Int {
    int result = super.hashCode()
    result = 31 * result + value.hashCode()
    return result
  }
  */
  
  public func toString() -> String {
    return "\(value)"
  }
}
