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
//  Configuration.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 01/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * Configuration wrapper.
 */
public protocol Configuration {
  
  /// configured OData format for AtomPub if specified; If this configuration parameter doesn't exist the
  /// JSON_FULL_METADATA format will be used as default  
  var defaultPubFormat: ContentType {get set}
  
  /// configured default **Accept** header value format for a batch request
  var defaultBatchAcceptFormat: ContentType {get set}
  
  /// configured OData value format. 
  /// If this configuration parameter doesn't exist the TEXT format will be used
  /// as default.
  var defaultValueFormat: ContentType {get set}
  
  /// the configured OData media format. 
  /// If this configuration parameter doesn't exist the APPLICATION_OCTET_STREAM
  /// format will be used as default
  var defaultMediaFormat: ContentType {get set}
  
  ///  the configured OData format. This value depends on what is returned from `getDefaultPubFormat()`
  var defaultFormat: ContentType {get}
  
  /// HTTP method to be used.  `PUT`, `MERGE`, `PATCH` or `DELETE`
  var useXHTTPMethod: Bool  {get set}
  
  /// HTTP Gzip compression enabled setting
  var gzipCompression: Bool {get set}
  
  /// chunk HTTP encoding setting
  var useChuncked: Bool {get set}
  
  /// URIs contains entity key between parentheses (standard) or 
  /// instead as additional segment(non-standard)
  /// Example: http://services.odata.org/V4/OData/OData.svc/Products(0) or
  /// http://services.odata.org/V4/OData/OData.svc/Products/0
  var keyAsSegment: Bool {get set}
  
  /// Flag whether query URIs in request should contain fully qualified type name. - OData Intermediate Conformance
  /// Level: MUST support casting to a derived type according to [OData-URL] if derived types are present in the model.
  /// Example: http://host/service/Customers/Model.VipCustomer(102) or http://host/service/Customers/Model.VipCustomer
  var addressingDerivedTypes: Bool {get set}
  
  /// Checks whether operation name in request URI should be fully qualified name, which is required by OData V4 protocol, but some service may still choose to support shorter name.
  /// Example: http://host/service/Customers(2)/NS1.Model.IncreaseSalary VS http://host/service/Customers(2)/IncreaseSalary
  var useUrlOperationFQN: Bool {get set}
  
  /// When processing a set of requests (in batch requests, for example), checks if the execution will be aborted after first error encountered or not.
  var continueOnError: Bool {get set}
  
  
  /// the HttpClient factory to be used for executing requests.
  //var httpClientFactory: HttpClientFactory {get}
  
  var httpSessionFactory: HttpSessionFactoryImpl {get}
  
//  
//  /**
//   * Sets the HttpClient factory to be used for executing requests.
//   *
//   * @param factory implementation of <tt>HttpClientFactory</tt>.
//   * @see HttpClientFactory
//   */
//  func setHttpClientFactory(factory:HttpClientFactory)
//  
//  /**
//   * Gets the HttpUriRequest factory for generating requests to be executed.
//   *
//   * @return provided implementation (if configured via <tt>setHttpUriRequestFactory</tt> or default.
//   */
//   func getHttpUriRequestFactory() -> HttpUriRequestFactory
//  
//  /**
//   * Sets the HttpUriRequest factory generating requests to be executed.
//   *
//   * @param factory implementation of <tt>HttpUriRequestFactory</tt>.
//   * @see HttpUriRequestFactory
//   */
//  func setHttpUriRequestFactory(factory:HttpUriRequestFactory)
//  
  
  /**
   * Retrieves request executor service.
   *
   * @return request executor service.
   */
  // TODO:
  //func getExecutor() -> ExecutorService
  
  /**
   * Sets request executor service.
   *
   * @param executorService new executor services.
   */
  // TODO:
  //func setExecutor(ExecutorService executorService:ExecutorService);
}

