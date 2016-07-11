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
//  Request.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 28/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Protocol with extension that provides common functionality for all types of requests
public protocol Request{
  
//  /// If using an EDM enabled client, checks that the cached service root matches the request URI
//  /// - parameters:
//  ///   - odataClient: an oDataClient object
//  ///   - request: an HTTP URI request TODO
//  /// - returns: No return value (void)
//  /// - throws: Illegal argument exception if the URI and service root stored in the client object do not match
//  func checkRequest(odataClient:ODataClient) //,request: HttpUriRequest)
//  
// 
//  /// Check response and status code 400 was returned if not throw error
//  /// - parameters:
//  ///   - odatClient : an oDataClient object
//  ///   - response: HTTP response
//  ///   - accept: string
//  /// - returns: No return value (void)
//  /// - throws: Odata runtime exception
//  func checkResponse(odataClient:ODataClient) //, response: HttpResponse,accept: String)
  
}


extension Request{
  
  /// If using an EDM enabled client, checks that the cached service root matches the request URI
  /// - parameters:
  ///   - odataClient: an oDataClient object
  ///   - request: an HTTP URI request TODO
  /// - returns: No return value (void)
  /// - throws: Illegal argument exception if the URI and service root stored in the client object do not match
  func checkRequest(odataClient:ODataClient) //,request: HttpUriRequest)
  {
    // TODO:
    
    /*
    // If using and Edm enabled client, checks that the cached service root matches the request URI
    if (odataClient instanceof EdmEnabledODataClient
      && !request.getURI().toASCIIString().startsWith(
        ((EdmEnabledODataClient) odataClient).getServiceRoot())) {
      
      throw new IllegalArgumentException(
        String.format("The current request URI %s does not match the configured service root %s",
          request.getURI().toASCIIString(),
          ((EdmEnabledODataClient) odataClient).getServiceRoot()));
    }
 */
  }
  
  
  /// Check response and status code 400 was returned if not throw error
  /// - parameters:
  ///   - odatClient : an oDataClient object
  ///   - response: HTTP response
  ///   - accept: string
  /// - returns: No return value (void)
  /// - throws: Odata runtime exception
  func checkResponse(odataClient:ODataClient, response: NSURLResponse!) throws //, accept: String) throws
  {
    
    // cast to NSHTTPURLResponse so we can access status code
    guard let httpResponse = response as? NSHTTPURLResponse else {
      throw HttpError.InvalidHttpResponse
    }
    if httpResponse.statusCode >= 400 {
      throw HttpError.ErrorCodeReturned(errorCode: httpResponse.statusCode)
      
      // TODO:
      // need to expand on error handling and get retunred header messages
      //      try {
      //        final ODataRuntimeException exception = ODataErrorResponseChecker.checkResponse(odataClient,response.getStatusLine(),response.getEntity() == null ? null : response.getEntity().getContent(),accept);
      //        if (exception != null) {
      //          throw exception;
      //        }
      //      } catch (IOException e) {
      //        throw new ODataRuntimeException(
      //          "Received '" + response.getStatusLine() + "' but could not extract error body", e);
      //        }
      //      }

    }
  }
}