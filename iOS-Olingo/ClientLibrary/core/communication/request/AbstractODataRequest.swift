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
//  AbstractODataRequest.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 28/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


public class AbstractODataRequest: Request {
  
// MARK: - Stored Properties
  
  /// odata Client instance
  var odataClient: ODataClient
  
  /// OData request header
  private var odataHeaders: ODataHeadersImpl // read only  // need to see if we can use protocol rather than the specific instance
  
  /// Target URI
  var uri:NSURL {
    didSet{
      // TODO:
      //httpClient = getHttpClient(method, uri: uri)
      //request = odataClient.configuration.getHttpUriRequestFactory().create(self.method, self.uri)
    }
  }
  
  /// OData request method
  //var method: HttpMethod  //read only
  var httpMethod: String
  
  /// HTTP client
  //var httpClient: HttpClient
  
  var httpSession: NSURLSession!
  
  /// HTTP request
  var request: HttpUriRequest!
  
  public var httpResponseContent:HttpResponseContent!
  
// MARK: - Computed Properties
  
  var headerNames: [String] {
    return odataHeaders.getHeaderNames()
  }
  
  var header: ODataHeadersImpl {
    return odataHeaders
  }
  
// MARK: - Methods
  
   init (odataClient: ODataClient, method: HttpMethod,uri:NSURL) {
    //super();
    
    self.odataClient = odataClient
    self.httpMethod = method.rawValue
    
    // initialize default headers
    self.odataHeaders = odataClient.newVersionHeaders()
    
    // target uri
    self.uri = uri
  
    // current httpsession
    self.httpSession = odataClient.httpSession

    // TODO: getURIRequest (Obsolete?)
    // self.request = odataClient.configuration.getHttpUriRequestFactory().create(self.method, uri);
  }
  
  //public abstract ContentType getDefaultFormat();
  public func getDefaultFormat() -> ContentType {
    // only implnented to test viability of enforcing the creation of the method in a concrete class.
    // Swift does not provide an abstarct method capability.
    // Alternative it is create a protocol for this abstract class
    fatalError("Must override")
  }
  
  public func setFormat(contentType:ContentType!) {
    if let contentType = contentType {
      let formatString = contentType.toContentTypeString()
      setAccept(formatString)
      setContentType(formatString)
    }
  }
  
  
  public func getHeader(name:String) -> String {
    return odataHeaders.getHeader(name)
  }
  
  
  public func setAccept(value:String) -> AbstractODataRequest {
    odataHeaders.setHeader(HttpHeader.ACCEPT.rawValue, value: value)
    return self
  }
  
  
  public func setIfMatch(value: String) -> AbstractODataRequest {
    odataHeaders.setHeader(HttpHeader.IF_MATCH.rawValue, value: value)
    return self
  }
  
 
  public func setIfNoneMatch(value: String) -> AbstractODataRequest {
    odataHeaders.setHeader(HttpHeader.IF_NONE_MATCH.rawValue, value: value)
    return self
  }
  

  public func setPrefer(value:String) -> AbstractODataRequest {
    odataHeaders.setHeader(HttpHeader.PREFER.rawValue, value: value)
    return self
  }
  
  public func setXHTTPMethod(value: String) -> AbstractODataRequest {
    odataHeaders.setHeader(HttpHeader.X_HTTP_METHOD.rawValue, value: value)
    return self
  }

  public func setContentType(value: String) -> AbstractODataRequest {
    odataHeaders.setHeader(HttpHeader.CONTENT_TYPE.rawValue, value: value)
    return self
  }
  
 
  public func addCustomHeader(name: String,value: String) -> AbstractODataRequest {
    odataHeaders.setHeader(name, value: value)
    return self
  }
  

  public func getAccept() -> String {
    let acceptHead:String? = odataHeaders.getHeader(HttpHeader.ACCEPT.rawValue)
    if let acceptHead = acceptHead{
      return acceptHead
    }
    else{
      return getDefaultFormat().toContentTypeString()
    }
  }
  
  public func getIfMatch() -> String {
    return odataHeaders.getHeader(HttpHeader.IF_MATCH.rawValue)
  }
  
  
  public func getIfNoneMatch() -> String  {
    return odataHeaders.getHeader(HttpHeader.IF_NONE_MATCH.rawValue)
  }
  
  
  public func getPrefer() -> String {
    return odataHeaders.getHeader(HttpHeader.PREFER.rawValue)
  }
  
 
  public func getContentType()-> String  {
    let contentTypeHead:String? = odataHeaders.getHeader(HttpHeader.CONTENT_TYPE.rawValue)
    
    if let contentTypeHead = contentTypeHead{
      return contentTypeHead
    }
    else{
      return getDefaultFormat().toContentTypeString()
    }

  }
  
   
  /// Build the HTTP request, execute it and get response
  /// - parameters:
  ///   - none
  /// - returns: HTTP response struct
  /// - throws: HTTP error exception if error returned or if HTTP status code >= 200
  func doExecute() throws -> HttpResponseContent {
    
    //TODO:  Enable check request once we pass in the request object
    // Always called but only required for EDM enabled clients so just stubbed for now
     // checkRequest(odataClient, request)
    
    if odataHeaders.getHeader(HttpHeader.CONTENT_TYPE.rawValue)?.isEmpty ?? true {
      setContentType(getContentType())
    }
    
    if odataHeaders.getHeader(HttpHeader.ACCEPT.rawValue)?.isEmpty ?? true {
      setAccept(getAccept())
    }
    
    // Add header for KeyAsSegment management
    if odataClient.configuration.keyAsSegment {
      addCustomHeader("DataServiceUrlConventions", value: odataClient.newPreferences().keyAsSegment)
    }
    
    // build the request
    let request = NSMutableURLRequest(URL: uri)
    request.HTTPMethod = self.httpMethod
    request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
    request.HTTPBody = "".dataUsingEncoding(NSUTF8StringEncoding)

    // Add all available headers to the request
    for (name,value) in odataHeaders.headers {
      request.addValue(value, forHTTPHeaderField: name)
    }
    
    if log.logMode == Log.LogMode.DEBUG {
      if let headers = request.allHTTPHeaderFields{
        for (key,value) in headers {
          log.debug("HTTP header being sent: Key: \(key) Value: \(value)")
        }
      }
      else{
        log.debug("HTTP header being sent: None")
        
      }
    }

    // build the closure to submit the request and handle response
    httpSession.sendSynchronousRequest(request) {
      (let data, let response, let error) in
      
      guard let _:NSData = data, let _:NSURLResponse = response where error == nil else {
        log.error("Error occured in httpSession.sendSynchronousRequest")
        return
      }
      let dataString = NSString(data:data!,encoding: NSUTF8StringEncoding)
      let httpResponse = response as? NSHTTPURLResponse
      
      log.debug(String(dataString))
      log.debug(String(httpResponse!.statusCode))
      
      if log.logMode == Log.LogMode.DEBUG {
        if let dataDictionary = self.parseHttpData(data) {
          var i = 1
          for item in dataDictionary {
            log.debug("data key \(i): \(item.0) ")
            i += 1
          }
          i=1
          for item in dataDictionary {
            log.debug("data \(i): \(item.0) : \(item.1) ")
            i += 1
          }
        }
        else {
          log.debug ("No data returned")
        }
      }
      self.httpResponseContent = HttpResponseContent(data: data!,response: httpResponse!)
    }
    if self.httpResponseContent == nil {
      log.warn("No response returned")
      throw HttpError.HttpRequestFailed
    }
    log.debug("Status Code: \(self.httpResponseContent.response.statusCode)")
    return httpResponseContent
  }
  
  /// parse response JSON NSData into a dictionary of customer objects
  /// - parameters:
  ///   - data: JSON data
  /// - returns: dictionary of key value pairs of JSON data
  /// - throws: No errors expected
  public func parseHttpData(data: NSData?) -> [String:AnyObject]! {
    do {
      if let data = data, response = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(rawValue:0)) as? [String: AnyObject] {
        
        // Get the results array
        if let array: AnyObject = response["value"]
        {
          
          for entitySetDictonary in array as! [AnyObject]
          {
            if let entitySetDictonary = entitySetDictonary as? [String: AnyObject]{
              return entitySetDictonary
            }
            else
            {
              log.error("Not a dictionary")
              return nil
            }
          }
        } else {
          log.warn("Value key not found in dictionary")
        }
      } else {
        log.error("JSON Error")

      }
    } catch let error as NSError {
      log.error("Error parsing results: \(error.localizedDescription)")
    }
    return nil
    }
  }
  
  // TODO:  func toByteArray()
  // public func toByteArray() -> [UInt8] {  // translated java Byte to UInt8 ?
  //    let baos = ByteArrayOutputStream()
  //    try {
  //      let requestBuilder = StringBuilder()
  //      requestBuilder.append(getMethod().toString()).append(' ').append(uri.toString()).append(' ').append("HTTP/1.1");
  //
  //      baos.write(requestBuilder.toString().getBytes());
  //
  //      baos.write(ODataStreamer.CRLF);
  //
  //      // Set Content-Type and Accept headers with default values, if not yet set
  //      if (StringUtils.isBlank(odataHeaders.getHeader(HttpHeader.CONTENT_TYPE))) {
  //        setContentType(getContentType());
  //      }
  //      if (StringUtils.isBlank(odataHeaders.getHeader(HttpHeader.ACCEPT))) {
  //        setAccept(getAccept());
  //      }
  //
  //      for (String name : getHeaderNames()) {
  //        final String value = getHeader(name);
  //
  //        if (StringUtils.isNotBlank(value)) {
  //          baos.write((name + ": " + value).getBytes());
  //          baos.write(ODataStreamer.CRLF);
  //        }
  //      }
  //
  //      return baos.toByteArray();
  //    } catch (IOException e) {
  //      throw new IllegalStateException(e);
  //    } finally {
  //      IOUtils.closeQuietly(baos);
  //    }
  // }
  
  // TODO: func rawExecute()
  
  //  public func rawExecute() -> InputStream {
  //    try {
  //      final HttpEntity httpEntity = doExecute().getEntity();
  //      return httpEntity == null ? null : httpEntity.getContent();
  //    } catch (IOException e) {
  //      throw new HttpClientException(e);
  //    } catch (RuntimeException e) {
  //      self.request.abort();
  //      throw new HttpClientException(e);
  //    }
  //  }

  
  // TODO: func getResponseTemplate()
//  /**
//   * Gets an empty response that can be initialized by a stream.
//   * This method has to be used to build response items about a batch request.
//   *
//   * @param <V> ODataResponse type.
//   * @return empty OData response instance.
//   */
//  @SuppressWarnings("unchecked")
//  public <V extends ODataResponse> V getResponseTemplate() {
//    for (Class<?> clazz : this.getClass().getDeclaredClasses()) {
//      if (ODataResponse.class.isAssignableFrom(clazz)) {
//        try {
//          final Constructor<?> constructor = clazz.getDeclaredConstructor(
//            this.getClass(), ODataClient.class, HttpClient.class, HttpResponse.class);
//          constructor.setAccessible(true);
//          return (V) constructor.newInstance(this, odataClient, httpClient, null);
//        } catch (Exception e) {
//          LOG.error("Error retrieving response class template instance", e);
//        }
//      }
//    }
//    
//    throw new IllegalStateException("No response class template has been found");
//  }
  
//  TODO: func getHttpClient
//  private func getHttpClient(method:HttpMethod, uri:NSURL) -> HttpClient {
//
//    //var client:HttpClient = odataClient.configuration.httpClientFactory.create(method, URI: uri);
//    if (odataClient.configuration.gzipCompression) {
//
//      //let client = DecompressingHttpClient(client);
//    }
//  return client;
//  }
  

