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

// Implementation based on Olingo's original java V4 implmentation.  Further details can be found at http://olingo.apache.org

 

//
//  AbstractODataResponse.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Abstract representation of an OData response.
 
public class AbstractODataResponse: ODataResponse {
  
  // MARK: - Stored Properties
  

  let odataClient:ODataClient

  
  /// HTTP response.
  public let res:HttpResponseContent
  
  /// Response headers.
  public var headers:[String:String] = [:]
  
  /// Response code.
  public var statusCode:Int = -1
  
  /// Response message.
  public var statusMessage:String = ""
  
  /// Response body/payload.
  var payload:NSData //]InputStream!
  
  /// Initialization check.
  var hasBeenInitialized:Bool = false
  
  //TODO: Batch
  /// Batch info (if to be batched).
  //var batchInfo:ODataBatchController!

  // MARK: - Computed Properties
  
  /// Get the list of header names
  public var headerNames: [String] {
      return Array(headers.keys)
  }
  
  public var eTag:String? {
    let etag = getHeader(HttpHeader.ETAG.rawValue)
    return etag
  }
  
  public var contentType:String? {
    let contentTypes:String? = getHeader(HttpHeader.CONTENT_TYPE.rawValue)
    return contentTypes
  }

  // MARK: - Init
  
  init (odataClient:ODataClient,res:HttpResponseContent) {
  
    self.odataClient = odataClient
    self.res = res

    self.payload = res.data
    self.statusCode = res.response.statusCode
    self.statusMessage = res.response.statusCode.description
    for header in res.response.allHeaderFields {
      self.headers.updateValue(header.1 as! String, forKey: header.0 as! String)
    }
    self.hasBeenInitialized=true
  }
  
  // MARK: - Methods
  
  /// get the value from the requested header
  /// - parameters:
  ///   - name: header name
  /// - returns: header value if found, otherwise `nil`
  /// - throws: No error conditions are expected
  public func getHeader(name:String) -> String?{
    return headers[name]
  }
  

   
  /// init from an HttPresponse
  /// - parameters:
  ///   - res: HttpResponseContent containing the response and the data
  /// - returns: OData response instance
  /// - throws: No error conditions are expected
  public final func initFromHttpResponse(res:HttpResponseContent) -> ODataResponse {
    self.payload = res.data
    for header in res.response.allHeaderFields {
      self.headers.updateValue(header.0 as! String, forKey: header.1 as! String)
    }
    self.statusCode = res.response.statusCode
    self.statusMessage = res.response.statusCode.description
    hasBeenInitialized = true
    return self
  }
  
  // TODO: func initFromBatch(responseLine:[Int:String],headers:[String:[String]],batchLineIterator:ODataBatchLineIterator,boundary:String)
  /*
  /// Init the response from a batch
  /// - parameters:
  ///   - param1: modify name and description as required
  ///   - param2: add or remove params from list as required
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  public func initFromBatch(responseLine:[Int:String],headers:[String:[String]],batchLineIterator:ODataBatchLineIterator,boundary:String) -> ODataResponse {
    
    if (hasBeenInitialized) {
      throw new IllegalStateException("Request already initialized")
    }
    
    self.batchInfo = new ODataBatchController(batchLineIterator, boundary)
    
    self.statusCode = responseLine.getKey()
    self.statusMessage = responseLine.getValue()
    self.headers.putAll(headers)
    
    self.hasBeenInitialized = true
    return this
  }
 */
  
  // TODO: func initFromEnclosedPart(part:InputStream)
  /*
  
  /// Init the response from an input stream
  /// - parameters:
  ///   - part: input stream
  /// - returns: An odata response
  /// - throws: TBC
  public func initFromEnclosedPart(part:InputStream) throws -> ODataResponse {
    do {
      try if (hasBeenInitialized) {
        throw new IllegalStateException("Request already initialized")
      }
      
      let batchLineIterator = ODataBatchLineIteratorImpl(IOUtils.lineIterator(part, Constants.UTF8))
      
      let partResponseLine = ODataBatchUtilities.readResponseLine(batchLineIterator)
      //LOG.debug("Retrieved async item response {}", partResponseLine)
      
      self.statusCode = partResponseLine.getKey()
      self.statusMessage = partResponseLine.getValue()
      
      let partHeaders = ODataBatchUtilities.readHeaders(batchLineIterator)
      //LOG.debug("Retrieved async item headers {}", partHeaders)
      
      self.headers.putAll(partHeaders)
      
      let bos = ByteArrayOutputStream()
      
      while (batchLineIterator.hasNext()) {
        bos.write(batchLineIterator.nextLine().getBytes(Constants.UTF8))
        bos.write(ODataStreamer.CRLF)
      }
      
      do {
        self.payload = try ByteArrayInputStream(bos.toByteArray())
      }
      catch  {
        LOG.error("Error retrieving payload", e)
        throw new IllegalStateException(e)
      }
      
      self.hasBeenInitialized = true
      return this
    }
    catch {
      LOG.error("Error streaming payload response", e)
      throw new IllegalStateException(e)
    }
  }
 */
  
  
  public func close() {
    // this closes the whole session, if we are only trying to close the specific request/response task 
    // then this is already handled so we dont need to do this.
    // Will assume at present this is not required
    
    //odataClient.configuration.httpSessionFactory.close(odataClient.httpSession)
    
//    if (batchInfo != nil) {
//      batchInfo.setValidBatch(false)
//    }
  }
  
  //TODO: func getRawReponse
  public func getRawResponse() -> NSData {
    let raw = NSData()
    return raw
    // TODO: Keep original code to see if we need to utilise with stream data
    /*
    if (HttpStatus.SC_NO_CONTENT == getStatusCode()) {
      throw new NoContentException()
    }
    
    if (payload == null && batchInfo.isValidBatch()) {
      // get input stream till the end of item
      payload = new PipedInputStream()
      
      try {
        final PipedOutputStream os = new PipedOutputStream((PipedInputStream) payload)
        
        new Thread(new Runnable() {
          
          public void run() {
            try {
              ODataBatchUtilities.readBatchPart(batchInfo, os, true)
            } catch (Exception e) {
              LOG.error("Error streaming batch item payload", e)
            } finally {
              IOUtils.closeQuietly(os)
            }
          }
          }).start()
      } catch (IOException e) {
        LOG.error("Error streaming payload response", e)
        throw new IllegalStateException(e)
      }
    }
    
    return payload
      */
  }
}

