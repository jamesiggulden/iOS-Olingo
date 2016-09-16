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

// Implementation based on Olingo's original java V4 implmentation.  Further details can be found at http://olingo.apache.org

//
//  ODataEntitySetIteratorRequestImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 20/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

//TODO: 
/*
/// This class implements an OData EntitySet query request
public class ODataEntitySetIteratorRequestImpl<ES:ClientEntitySet, E:ClientEntity> :AbstractODataRequest,ODataRetrieveRequest,ODataBasicRequest {
 // implements ODataEntitySetIteratorRequest<ES, E> {
//public class ODataEntitySetIteratorRequestImpl<ES extends ClientEntitySet, E extends ClientEntity> extends AbstractODataRetrieveRequest<ClientEntitySetIterator<ES, E>> implements ODataEntitySetIteratorRequest<ES, E> {
  
  private  var entitySetIterator:ClientEntitySetIterator<ES, E>  = nil
 
  // MARK: - Stored Properties

  
  // MARK: - Computed Properties
  

  // MARK: - Init

  public init(odataClient:ODataClient,query:NSURL) {
    super.init(odataClient: odataClient,method: HttpMethod.GET, uri: query)
  }
  
  // MARK: - Methods

  
  /// get the default format defined for the OData client
  /// - parameters:
  ///   - none
  /// - returns: default format as content type object
  /// - throws: No error conditions are expected
  public override func getDefaultFormat() -> ContentType {
  return odataClient.configuration.defaultPubFormat
  }
  
  
  /// Execute a synchronise request, wait, receive and return the received response
  /// - parameters:
  ///   - none
  /// - returns: response
  /// - throws: No error conditions are expected
  public func execute() -> ODataRetrieveResponse<ClientEntitySetIterator<ES, E>> {
    do {
      let result = try doExecute()
      let response = ODataEntitySetIteratorResponseImpl(odataClient: odataClient,res: result)
      return response

    }
    catch {
      // need to do something with a thrown error
    }

  }
  
  /**
   * Response class about an ODataEntitySetIteratorRequest.
   */
   class ODataEntitySetIteratorResponseImpl: AbstractODataRetrieveResponse {
    
    init(odataClient: ODataClient,res: HttpResponseContent ) {
      
      super.init(odataClient: odataClient, res: res)
    }
    
    
    public func getBody() -> ClientEntitySetIterator<ES, E> {
      if (entitySetIterator == nil) {
        entitySetIterator = ClientEntitySetIterator<ES, E>(odataClient, self.getRawResponse(), ContentType.parse(self.contentType))
      }
      return entitySetIterator
    }
  }
}
 */

