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
//  AbstractODataBasicRequest.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation



// MARK: - Protocol
public protocol ODataBasicRequest {

  // MARK: - Protocol Properties
  
  // MARK: - Protocol Methods
  
  // TODO: getpayload
  /// Gets payload as an InputStream
  //func  getPayload() -> InputStream
  
}

// MARK: - Extension

public extension ODataBasicRequest {
  
  /// Execute request asynchronously
  /// - parameters:
  ///   - none:
  /// - returns: TBC
  /// - throws: No error conditions are expected
  public func asyncExecute<T>() -> T? {
    // TODO: Implement async functionality
    /*
    return odataClient.getConfiguration().getExecutor().submit(new Callable<T>() {
      
      public T call() throws Exception {
        return execute()
      }
    })
    */
    return nil
  }
  
  
  // TODO: batch functionality [func batch(req:ODataBatchRequest)]
  /*
  
  /// Serializes the full request into the given batch request
  /// - parameters:
  ///   - req: destination batch request
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  
  public func batch(req:ODataBatchRequest) {
    batch(req, nil)
  }
 */
  
  // TODO: batch functionality [func batch(req: ODataBatchRequest,contentId:String)]
  /*
  /// Serializes the full request into the given batch request.
  ///
  /// This method have to be used to serialize a changeset item with the specified contentId.
  /// - parameters:
  ///   - req: destination batch request
  ///   - contentId: contentId of the changeset item
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  
  public func batch(req: ODataBatchRequest,contentId:String ) throws {
    do {
      try req.rawAppend(toByteArray());
      if !contentId.isEmpty {
        try req.rawAppend((ODataBatchConstants.CHANGESET_CONTENT_ID_NAME + ": " + contentId).getBytes());
        try req.rawAppend(ODataStreamer.CRLF);
      }
      try req.rawAppend(ODataStreamer.CRLF);
  
      if let payload = getPayload() {
        req.rawAppend(IOUtils.toByteArray(getPayload()));
      }
    }
  }
 */

  
}













