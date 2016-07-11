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
//  ODataResponse.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


// MARK: - Protocol

/// Abstract representation of an OData response.
public protocol ODataResponse {
  
// MARK: - Protocol Properties

  /// Gets header names.
  var headerNames:[String] {get}
  
  /// Gets 'ETag' header value.
  var eTag:String {get}
  
  /// Gets the content type
  var contentType:String {get}
  
  /// Gets status code.
  var statusCode:Int {get}
  
  /// Gets status message.
  var statusMessage:String {get}
  
  
  /// HTTP response.
  var res:HttpResponseContent {get}
  
  /// Response headers.
  var headers:[String:String] {get}
  
  
  
// MARK: - Protocol Methods

/// Gets header value of the given header.
/// @param name header to be retrieved.
/// @return response header value.
   
  func getHeader(name:String) -> String!
  
  /// Gets response body as NSData (replaces java InputStream)
  func getRawResponse() -> NSData  // InputStream
  
  /// Close the underlying message entity input stream (if available and open) as well as releases any other resources associated with the response.
  ///
  /// This operation is idempotent, i.e. it can be invoked multiple times with the same effect which also means that calling the close() method on an already closed message instance is legal and has no further effect.
  ///
  /// The close() method should be invoked on all instances that contain an un-consumed entity input stream to ensure the resources associated with the instance are properly cleaned-up and prevent potential memory leaks. This is typical for client-side scenarios where application layer code processes only the response headers and ignores the response entity.
  /// - parameters:
  ///   - none
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  func close()
  
  func initFromHttpResponse(res:HttpResponseContent) -> ODataResponse
}