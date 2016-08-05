//
//  ODataClientImp.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 23/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Implmentation of an OData Client
public class ODataClientImp: ODataClient {
  
//  let retrieveReqFact:RetrieveRequestFactory = RetrieveRequestFactoryImpl();
//
//  func retrieveRequestFactory() -> RetrieveRequestFactory {
//    
//     return retrieveReqFact;
//  }
  
    /// an instance of a retrieve request factory (read only)
  //TODO: Design notes - use of lazy
  public lazy var retrieveRequestFactory:RetrieveRequestFactory = RetrieveRequestFactoryImpl(client: self)
  
  public let objectFactory:ClientObjectFactory = ClientObjectFactoryImpl()
  public lazy var binder:ODataBinder = ODataBinderImpl(client: self)
  
  public let configuration:Configuration = ConfigurationImpl()
  public let httpSession:NSURLSession
  
  
  public init() {
    httpSession = configuration.httpSessionFactory.create()
    //retrieveRequestFactory = RetrieveRequestFactoryImpl(client: self)
  }
  
   
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
  
  
  public func newPreferences() -> ODataPreferences {
    return ODataPreferences()
  }
  
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

  
}

