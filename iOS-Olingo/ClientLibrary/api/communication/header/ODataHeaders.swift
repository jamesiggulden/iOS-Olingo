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
//  ODataHeader.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 28/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


 /// ODataHeaders wraps OData request/response headers
public protocol ODataHeaders {
  
  // MARK: - Protocol Properties
  
  // MARK: - Protocol Methods
  
  var headers:[String:String] {get}

  /// Gets the value of the header identified by the given name
  /// Please note that header name is case-insensitive
  /// - parameters:
  ///   - name: name of the header to be retrieved
  /// - returns: header value if exists as optional
  /// - throws: No error conditions are expected
  func getHeader(name:String) -> String!
  
  /// Gets header names
  /// Please note that header name is case-insensitive
  /// - parameters:
  ///   - none
  /// - returns: array of header names
  /// - throws: No error conditions are expected
  func getHeaderNames()-> [String]
  
  /// Add the specified (custom) header (header name is case-insensitive)
  /// - parameters:
  ///   - name: header key
  ///   - value: header value
  /// - returns: the current updated header instance
  /// - throws: No error conditions are expected
  func setHeader(name:String,value:String) -> ODataHeadersImpl
  
  /// Removes the header identified by the given name
  /// Please note that header name is case-insensitive.
  /// - parameters:
  ///   - name: name of the header to be retrieved
  ///   - value: header value
  /// - returns: header name (if found) as optional
  /// - throws: No error conditions are expected
  func removeHeader(name:String) -> String!
  
}

