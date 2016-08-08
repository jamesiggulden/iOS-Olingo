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
  
  
  /// an instance of a retrieve request factory (read only)
  // declared lazy in order to allow instantiation of ODataClientImp to then pass self to RetrieveRequestFactoryImpl
  public lazy var retrieveRequestFactory:RetrieveRequestFactory = RetrieveRequestFactoryImpl(client: self)
  
  public let objectFactory:ClientObjectFactory = ClientObjectFactoryImpl()
  
  // declared lazy in order to allow instantiation of ODataClientImp to then pass self to OdataBinderImpl
  public lazy var binder:ODataBinder = ODataBinderImpl(client: self)
  
  public let configuration:Configuration = ConfigurationImpl()
  public let httpSession:NSURLSession
  
  
  public init() {
    httpSession = configuration.httpSessionFactory.create()
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

