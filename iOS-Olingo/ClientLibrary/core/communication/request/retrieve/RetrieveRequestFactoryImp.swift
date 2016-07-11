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
//  RetrieveRequestFactoryImp.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 23/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Implmentation of a factory to create the various types of OData request entities

public class RetrieveRequestFactoryImpl: RetrieveRequestFactory {
  
  // MARK: - Stored Properties

  final let client:ODataClient
  
  
  // MARK: - Computed Properties

  // MARK: - Init

  init(client:ODataClient) {
    self.client = client
  }
  
  
  // MARK: - Methods

  /// Gets a uri request returning a set of one or more sets of OData entities
  /// - parameters:
  ///   - uri: NSURL object containing a URI
  /// - returns: No return value (void) TODO
  /// - throws: No error conditions are expected
  public func entitySetIteratorRequest(uri:NSURL) {
    //TODO
  }
  
  /// Gets a uri request returning a set of one or more OData entities
  /// - parameters:
  ///   - uri: NSURL object containing a URI
  /// - returns: No return value (void) TODO
  /// - throws: No error conditions are expected
  public func entitySetRequest(uri:NSURL) -> ODataEntitySetRequest {
    return ODataEntitySetRequestImpl(odataClient: client, query: uri)
  }
  
  /// Gets a uri request returning a single OData entity
  /// - parameters:
  ///   - uri: NSURL object containing a URI
  /// - returns: No return value (void) TODO
  /// - throws: No error conditions are expected
  public func entityRequest(uri:NSURL) -> ODataEntityRequest {
    return ODataEntityRequestImpl(odataClient: client, query: uri)
  }

}