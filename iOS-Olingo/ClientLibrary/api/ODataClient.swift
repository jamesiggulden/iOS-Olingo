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
//  ODataClient.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 23/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Protocol for an OData Client
public protocol ODataClient {
  
  /// an instance of a retrieve request factory (read only)
  var retrieveRequestFactory:RetrieveRequestFactory {get}
  var objectFactory:ClientObjectFactory {get}
  var configuration:Configuration {get}
  var httpSession:NSURLSession {get}
  var binder:ODataBinder {get}
  
  /// build OData headers for Odata Max version and Odata version set to v4.0
  /// - parameters:
  ///   - none
  /// - returns: Odata headers
  /// - throws: No error conditions are expected
  func newVersionHeaders() -> ODataHeadersImpl
   
  /// builds set of defualt Odata preferences
  /// - parameters:
  ///   - none
  /// - returns: Odata preferences
  /// - throws: No error conditions are expected
  func newPreferences() -> ODataPreferences
  
  /// get the deserializer
  /// - parameters:
  ///   - contentType: type of content
  /// - returns: Odat deserializer object
  /// - throws: No error conditions are expected
  func getDeserializer(contentType:ContentType) -> ClientODataDeserializerImpl
  
  
  // var retrieveReqFact:RetrieveRequestFactory {get}
  // func retrieveRequestFactory()-> RetrieveRequestFactory


}