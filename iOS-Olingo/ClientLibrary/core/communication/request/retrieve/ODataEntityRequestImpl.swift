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
//  ODataEntityRequestImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


 /// This class implements an OData retrieve query request returning a single entity.
 /// Currently inherits from AbstractODataRequest with protocoal+extensions for 
 /// AbstractODataRetrieveRequest,AbstractODataBasicRequest

public class ODataEntityRequestImpl:AbstractODataRequest,ODataRetrieveRequest,ODataBasicRequest { //extends AbstractODataRetrieveRequest<E> implements ODataEntityRequest<E> {
  
  
  // MARK: - Stored Properties

  
  // MARK: - Computed Properties
  
  
  // MARK: - Init

  init (odataClient:ODataClient, query:NSURL) {
    super.init(odataClient: odataClient,method: HttpMethod.GET,uri: query)
  }
  
  
  // MARK: - Methods

  public override func getDefaultFormat() -> ContentType {
    return odataClient.configuration.defaultPubFormat
  }
  
  public func execute() -> ODataRetrieveResponse! {
    
    do {
      let result = try doExecute()
      let response = ODataEntityResponse(odataClient: odataClient,res: result)
      // MARK: REDUNDANT:?
      //let httpClient = HttpClient()
      //let response = ODataEntityResponse(odataClient: odataClient, httpClient: httpClient, res: result)
      return response
      //return ODataEntityResponse(odataClient, httpClient, doExecute())
    }
    catch {
      // need to do something with a thrown error
    }
    return nil
    
  }
  
  /**
   * Response class about an ODataEntityRequest.
   */
  public class ODataEntityResponse: AbstractODataResponse, ODataRetrieveResponse {
    
    private var entity:AnyObject? // ??? is this a gerneic type?
    
    
    override init (odataClient:ODataClient,res: HttpResponseContent) {
    // MARK:  REDUNDANT:? init (odataClient:ODataClient, httpClient:HttpClient,res: HttpResponseContent) {
      
      super.init(odataClient: odataClient,res: res)
      // MARK: REDUNDANT:? super.init(odataClient: odataClient, httpclient: httpClient, res: res)
      
    }
    
    public func getBody() {
      
    }
    
    //TODO: Come back to this once we are happy we are getting something through to here

//    public func getBody<E>() -> E {
//      if (entity == nil) {
//        do {
//          let resource = try odataClient.getDeserializer(ContentType.parse(getContentType())).toEntity(getRawResponse())
//          entity = odataClient.getBinder().getODataEntity(resource)
//        }
//        catch (ODataDeserializerException.InvalidFormat) {
//          //throw new IllegalArgumentException(e)
//        }
//        defer {
//          self.close()
//        }
//      }
//    return entity
//    }
  }
  
  
}
