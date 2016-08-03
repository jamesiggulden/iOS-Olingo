//
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


//  ODataEntitySetRequestImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 11/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


/**
 * This class implements an OData EntitySet query request.
 *
 * @param <ES> concrete ODataEntitySet implementation
 */

public class ODataEntitySetRequestImpl: AbstractODataRequest,ODataRetrieveRequest,ODataBasicRequest, ODataEntitySetRequest{

// public class ODataEntitySetRequestImpl<ES extends ClientEntitySet> extends AbstractODataRetrieveRequest<ES> implements ODataEntitySetRequest<ES> {
  
  // MARK: - Stored Properties

  public lazy var entitySet: ClientEntitySet? = nil
  //private ES entitySet = nil
  
  // MARK: - Computed Properties

  
  // MARK: - Init

  init(odataClient:ODataClient, query:NSURL) {
    super.init(odataClient: odataClient,method: HttpMethod.GET,uri: query)
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
  public func execute() -> ODataEntitySetRetrieveResponse? {
    //public func execute() -> ODataRetrieveResponse! {
    
    do {
      let result = try doExecute()
      let response = ODataEntitySetResponse(odataClient: odataClient,res: result)
      return response
      //return ODataEntityResponse(odataClient, httpClient, doExecute())
    }
    catch {
      // need to do something with a thrown error
    }
    return nil
    
  }
  
  
  /// Response class about an ODataEntitySetRequest
  public class ODataEntitySetResponse : AbstractODataResponse, ODataEntitySetRetrieveResponse  {
    //public class ODataEntitySetResponse : AbstractODataResponse, ODataRetrieveResponse {

    // MARK: - Stored Properties
    
    private var entitySet:ClientEntitySet?
    
    // MARK: - Computed Properties

    // MARK: - Init

    private override init(odataClient: ODataClient,res: HttpResponseContent ) {
      
      super.init(odataClient: odataClient, res: res)
    }
    
    // MARK: - Methods

    /// Get the body of the returned response
    /// - parameters:
    ///   - none
    /// - returns: Entity
    /// - throws: No error conditions are expected
    public func getBody() throws -> ClientEntitySet? {
      
      if entitySet == nil {
        do {
          
          log.debug("Parse Client entity Set")
          let contentType = ContentType.parse(self.contentType)!
          log.debug("To entity set")
          let  oDataDeserializer = odataClient.getDeserializer(contentType)
          let resource:ResWrap<EntityCollection> = try oDataDeserializer.toEntitySet(payload)!
          log.debug("Bind entity Set")
          entitySet = odataClient.binder.getODataEntitySet(resource) as ClientEntitySet
        } catch  {
          throw IllegalArgumentException.InvalidFormat
        }
        defer {
          self.close()
        }
      }
      return entitySet
    }
  }
}
