/*
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with this work for additional information
  regarding copyright ownership.  The ASF licenses this file
  to you under the Apache License, Version 2.0 (the
  "License"); you may not use this file except in compliance
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
//  ClientCollectionValue.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 13/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * OData collection property value.
 *
 * @param <T> The actual ODataValue interface.
 */
public protocol ClientCollectionValue: ClientValue {
  
  //associatedtype T:ClientValue
  /**
   * Adds a value to the collection.
   *
   * @param value value to be added.
   */
  func add(value:ClientValue) -> ClientCollectionValue
  
  /**
   * Checks if collection is empty.
   *
   * @return 'TRUE' if empty; 'FALSE' otherwise.
   */
  func isEmpty() -> Bool
  
  /**
   * Gets collection size.
   *
   * @return collection size.
   */
  func size() -> Int
  
  /**
   * Converts this instance as POJO collection.
   *
   * @return this instance as POJO collection
   */
  func asSwiftCollection() -> [Any]
}
