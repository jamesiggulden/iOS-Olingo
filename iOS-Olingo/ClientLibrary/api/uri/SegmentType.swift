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

// Implementation based on Olingo's original java V4 implmentation.  Further details can be found at http://olingo.apache.org

//
//  SegmentType.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 03/08/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// URI Segment types
public enum SegmentType:String {
  
  case ENTITY = "$entity"
  case ENTITYSET
  case SINGLETON
  case KEY
  case KEY_AS_SEGMENT
  case PROPERTY
  case NAVIGATION
  case DERIVED_ENTITY_TYPE
  case VALUE = "$value"
  case COUNT = "$count"
  case BOUND_OPERATION
  case UNBOUND_OPERATION
  case BOUND_ACTION
  case UNBOUND_ACTION
  case METADATA = "$metadata"
  case BATCH = "$batch"
  case LINKS = "$links"
  case REF = "$ref"
  case CROSS_JOIN = "$crossjoin"
  case ALL = "$all"
  /// For query options like $count that need to stay in their own segment, right after service root.
  case ROOT_QUERY_OPTION
  case SERVICEROOT
  
  
}
