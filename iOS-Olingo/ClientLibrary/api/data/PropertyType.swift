/*
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with this work for additional information
  regarding copyright ownership.  The ASF licenses this file
  to you under the Apache License Version 2.0 (the
  "License"); you may not use this file except in compliance
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
//  PropertyType.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 07/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Enumeration for all OData property types
public enum PropertyType {
  
  /// Primitive (including geospatial).
  case PRIMITIVE
  /// Enum
  case ENUM
  ///  Collection
  case COLLECTION
  /// Complex
  case COMPLEX
  /// Empty type (possibly no type information could be retrieved)
  case EMPTY
}
