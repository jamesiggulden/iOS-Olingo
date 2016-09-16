/*
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with this work for additional information
  regarding copyright ownership.  The ASF licenses this file
  to you under the Apache License Version 2.0 (the
  "License") you may not use this file except in compliance
  with the License.  You may obtain a copy of the License at
 
    http://www.apache.org/licenses/LICENSE-2.0
 
  Unless required by applicable law or agreed to in writing
  software distributed under the License is distributed on an
  "AS IS" BASIS WITHOUT WARRANTIES OR CONDITIONS OF ANY
  KIND either express or implied.  See the License for the
  specific language governing permissions and limitations
  under the License.
 */



//
//  ValueType.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Defines the type of a value (see Valuable).
public enum ValueType:Int {
  /// Primitive value
  case PRIMITIVE = 1
  /// Geospatial value
  case GEOSPATIAL = 2
  /// Enum type
  case ENUM = 3
  /// Complex value
  case COMPLEX = 4
  /// Entity value
  case ENTITY = 5
  /// Collection of primitive values
  case COLLECTION_PRIMITIVE = 11
  /// Collection of geospatial values
  case COLLECTION_GEOSPATIAL = 12
  /// Collection of enum values
  case COLLECTION_ENUM = 13
  /// Collection of complex values
  case COLLECTION_COMPLEX = 14
  /// Collection of entities
  case COLLECTION_ENTITY = 15
}

