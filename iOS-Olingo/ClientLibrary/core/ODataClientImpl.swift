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

// Implementation based on Olingo's original java V4 implmentation.  Further details can be found at http://olingo.apache.org

//
//  ODataClientImp.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 23/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Implmentation of an OData Client
public class ODataClientImpl: ODataClient {
  
  // MARK: - Stored Properties

  /// an instance of a retrieve request factory (read only)
  // declared lazy in order to allow instantiation of ODataClientImp to then pass self to RetrieveRequestFactoryImpl
  public lazy var retrieveRequestFactory:RetrieveRequestFactory = RetrieveRequestFactoryImpl(client: self)
  
  public let objectFactory:ClientObjectFactory = ClientObjectFactoryImpl()
  
  // declared lazy in order to allow instantiation of ODataClientImp to then pass self to OdataBinderImpl
  public lazy var binder:ODataBinder = ODataBinderImpl(client: self)
  
  public let configuration:Configuration = ConfigurationImpl()
  public let httpSession:NSURLSession
  
  // MARK: - Computed Properties

  
  // MARK: - Init

  public init() {
    httpSession = configuration.httpSessionFactory.create()
  }
  
  // MARK: - Methods
   
  /// build OData headers for Odata Max version and Odata version set to v4.0
  /// - parameters:
  ///   - none
  /// - returns: Odata headers
  /// - throws: No error conditions are expected
  public func newVersionHeaders() -> ODataHeadersImpl {
    let odataHeaders = ODataHeadersImpl()
    odataHeaders.setHeader(HttpHeader.ODATA_MAX_VERSION.rawValue, value: ODataServiceVersion.V40.rawValue)
    odataHeaders.setHeader(HttpHeader.ODATA_VERSION.rawValue, value: ODataServiceVersion.V40.rawValue)
    return odataHeaders;
  }
  
  /// get the current ODataPreferences
  /// - parameters:
  ///   - none
  /// - returns: Odata preferences
  /// - throws: No error conditions are expected
  public func newPreferences() -> ODataPreferences {
    return ODataPreferences()
  }
  
  /// get a new deserilizer object
  /// - parameters:
  ///   - contentType: content type to obtain coreect deserilizer
  /// - returns: Client deserilaizer instance
  /// - throws: No error conditions are expected
  public func getDeserializer(contentType:ContentType) -> ClientODataDeserializerImpl {
    return ClientODataDeserializerImpl(boolean: false, contentType: contentType)
  }
  

  /// get the reader
  /// - parameters:
  ///   - none
  /// - returns: ODataReader
  /// - throws: No error conditions are expected
  public func getReader() -> ODataReader {
    return ODataReaderImpl()
  }

  /// get a new URI builder
  /// - parameters:
  ///   - serviceRoot: root URL for service
  /// - returns: URI Builder
  /// - throws: No error conditions are expected
  public func newURIBuilder(serviceRoot:String) -> URIBuilder? {
    if serviceRoot.isEmpty{
      return nil
    }
    
    return URIBuilderImpl(configuration: configuration, serviceRoot: serviceRoot)
  }

  
}

