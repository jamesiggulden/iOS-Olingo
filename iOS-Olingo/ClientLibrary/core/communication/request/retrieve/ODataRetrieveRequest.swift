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
//  AbstractODataRetrieveRequest.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


// MARK: - Protocol

/// This is an abstract representation of an OData retrieve query request returning one or more result item.
public protocol ODataRetrieveRequest {
  // MARK: - Protocol Properties

  // MARK: - Protocol Methods

  func execute() -> ODataRetrieveResponse!
}

// MARK: - Extension

public extension ODataRetrieveRequest {
  

  
  /// This kind of request doesn't have any payload: null will be returned
  /// - parameters:
  ///   - none
  /// - returns: nil
  /// - throws: No error conditions are expected
 func getPayload() -> NSData! {
    return nil
  }
  
}


  // TODO: This should be obsolete when using protocol + extension, leave as is at present with intention to remove
// orgiginal java code:


//public abstract class obsAbstractODataRetrieveRequest<T>
//extends AbstractODataBasicRequest<ODataRetrieveResponse<T>>
//implements ODataRetrieveRequest<T> {
//  
//  /**
//   * Private constructor.
//   *
//   * @param odataClient client instance getting this request
//   * @param query query to be executed.
//   */
//  public AbstractODataRetrieveRequest(final ODataClient odataClient, final URI query) {
//    super(odataClient, HttpMethod.GET, query);
//  }
//  

  
  
  

