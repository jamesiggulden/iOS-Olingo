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
//  File.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public protocol ClientPrimitiveValue :ClientValue {
  
  /// Type kind
  var typeKind:EdmPrimitiveTypeKind? {get}
  
  /// Type
  var type:EdmPrimitiveType? {get}
  
  /// Actual value
  var value:Any?  {get}
  
  
  // TODO: as per implmnentation
  /*
  /**
   * Returns the current value casted to the given type.
   *
   * @param <T> cast type
   * @param reference class reference
   * @return the current value as typed java instance
   * @throws EdmPrimitiveTypeException if the object is not assignable to the type T.
   */
  <T> T toCastValue(Class<T> reference) throws EdmPrimitiveTypeException
  
  /**
   * Serialize the current value as String.
   *
   * @return a String representation of this value
   */

  String toString()
 */
  
}
