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

public class ODataEntityRequestImpl:AbstractODataRequest,ODataRetrieveRequest,ODataBasicRequest,ODataEntityRequest { //extends AbstractODataRetrieveRequest<E> implements ODataEntityRequest<E> {

  
  // MARK: - Stored Properties

  
  // MARK: - Computed Properties
  
  
  // MARK: - Init

  init (odataClient:ODataClient, query:NSURL) {
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
  public func execute() -> ODataEntityRetrieveResponse? {
    
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
  
  /// Response class about an ODataEntityRequest.
  public class ODataEntityResponse: AbstractODataResponse, ODataEntityRetrieveResponse {
    
    // MARK: - Stored Properties

    private var entity:ClientEntity?
    // make this type specific at present
    //private var entity:AnyObject? // ??? is this a gerneic type?
    
    // MARK: - Computed Properties

    // MARK: - Init

    override init (odataClient:ODataClient,res: HttpResponseContent) {
    // MARK:  REDUNDANT:? init (odataClient:ODataClient, httpClient:HttpClient,res: HttpResponseContent) {
      super.init(odataClient: odataClient,res: res)
      // MARK: REDUNDANT:? super.init(odataClient: odataClient, httpclient: httpClient, res: res)
    }
    
    // MARK: - Methods
 
    /// Get the body of the returned response
    /// - parameters:
    ///   - none
    /// - returns: Entity
    /// - throws: No error conditions are expected
    public func getBody() throws -> ClientEntity? {
      if entity == nil {
        do {
          
          log.debug("Parse Client entity")
          let contentType = ContentType.parse(self.contentType)!
          log.debug("To entity")
          let  oDataDeserializer = odataClient.getDeserializer(contentType)
          guard let resource:ResWrap<Entity> = try oDataDeserializer.toEntity(payload) else {
            throw GetODataException.ODataEntityFailed
          }
          log.debug("Bind entity")
          entity = try odataClient.binder.getODataEntity(resource) as ClientEntity
        } catch  {
          throw GetODataException.ODataEntityFailed
        }
        defer {
          self.close()
        }
      }
      return entity
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
