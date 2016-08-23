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
//  RetrieveRequestFactory.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 23/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//



import Foundation

/// Protocol for a factory to create the various types of OData request entities

public protocol RetrieveRequestFactory {
  
  // MARK: - Protocol Properties
  
  /// Gets a uri request returning a set of one or more sets of OData entities
  /// - parameters:
  ///   - uri: NSURL object containing a URI
  /// - returns: No return value (void) TODO
  /// - throws: No error conditions are expected
  func entitySetIteratorRequest(uri:NSURL)
  
  /// Gets a uri request returning a set of one or more OData entities
  /// - parameters:
  ///   - uri: NSURL object containing a URI
  /// - returns: Odata Entity Request
  /// - throws: No error conditions are expected
  func entitySetRequest(uri:NSURL) -> ODataEntitySetRequest
  
  /// Gets a uri request returning a single Odata entity
  /// - parameters:
  ///   - uri: NSURL object containing a URI
  /// - returns: Odata Entity Request
  /// - throws: No error conditions are expected
  func entityRequest(uri:NSURL) -> ODataEntityRequest
}


