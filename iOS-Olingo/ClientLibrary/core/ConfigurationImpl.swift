//
//  ConfigurationImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 01/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class ConfigurationImpl :Configuration {
  
  // STORED PROPERTIES:
  
  private static let HTTP_CLIENT_FACTORY:String = "httpClientFactory"
  
  // Obsolete
  //private static let HTTP_URI_REQUEST_FACTORY:String = "httpUriRequestFactory"
  
  //public let httpClientFactory:HttpClientFactory = DefaultHttpClientFactory()
  
  public let httpSessionFactory:HttpSessionFactoryImpl = HttpSessionFactoryImpl()
  
  
  // TODO:
  // public let httpUriRequestFactory:HttpUriRequestFactory = DefaultHttpUriRequestFactory()
  
  //TODO:
  //private transient ExecutorService executor = Executors.newFixedThreadPool(10)
  
  private var CONF:[String:AnyObject]=[:]
  //private let Map<String, Object> CONF:String = new HashMap<String, Object>()
  
  
 
  // COMPUTED PROPERTIES:
  
  public var defaultPubFormat:ContentType {
    get {
      return getProperty(String: ConfigurationProperty.DEFAULT_PUB_FORMAT.rawValue, defaultValue: ContentType.JSON_FULL_METADATA!) as! ContentType
    }
    set(contentType){
      setProperty(ConfigurationProperty.DEFAULT_PUB_FORMAT.rawValue, Object: contentType)
    }
  }

  
  public var defaultBatchAcceptFormat: ContentType {
    get {
      return getProperty(String: ConfigurationProperty.DEFAULT_BATCH_ACCEPT_FORMAT.rawValue, defaultValue: ContentType.MULTIPART_MIXED!) as! ContentType
    }
    set(contentType){
      setProperty(ConfigurationProperty.DEFAULT_BATCH_ACCEPT_FORMAT.rawValue, Object: contentType)
    }
  }
  
  public var defaultValueFormat: ContentType {
    get {
      return getProperty(String: ConfigurationProperty.DEFAULT_VALUE_FORMAT.rawValue, defaultValue: ContentType.TEXT_PLAIN!) as! ContentType
    }
    set(contentType){
    setProperty(ConfigurationProperty.DEFAULT_VALUE_FORMAT.rawValue, Object: contentType)
    }
  }
  
  
  public var defaultMediaFormat: ContentType {
    get {
      return getProperty(String: ConfigurationProperty.DEFAULT_VALUE_FORMAT.rawValue, defaultValue: ContentType.APPLICATION_OCTET_STREAM!) as! ContentType
    }
    set(contentType){
      
      // we can not have duplicate values in the enum (DEFAULT_VALUE_FORMAT is reused for media format.
      // IF different value required for media format updated enum with new unique value
      setProperty(ConfigurationProperty.DEFAULT_VALUE_FORMAT.rawValue, Object: contentType)
    }
  }
  
  public var defaultFormat: ContentType {
    get {
      let ct = self.defaultPubFormat
  
      if ct === ContentType.APPLICATION_ATOM_XML {
        return ContentType.APPLICATION_XML!
      }
      else{
        return ct
      }
    }
  
  
  }

  
  public var useXHTTPMethod: Bool {
    get {
      return getProperty(String: ConfigurationProperty.USE_XHTTP_METHOD.rawValue, defaultValue: false) as! Bool
    }
    set(value){
      setProperty(ConfigurationProperty.USE_XHTTP_METHOD.rawValue, Object: value)
    }
  }
  
  public var gzipCompression: Bool {
    get {
      return getProperty(String: ConfigurationProperty.GZIP_COMPRESSION.rawValue, defaultValue: false) as! Bool
    }
    set(value){
      setProperty(ConfigurationProperty.GZIP_COMPRESSION.rawValue, Object: value)
    }
  }
  
  public var useChuncked: Bool {
    get {
      return getProperty(String: ConfigurationProperty.CHUNKING.rawValue, defaultValue: true) as! Bool
    }
    set(value){
      setProperty(ConfigurationProperty.CHUNKING.rawValue, Object: value)
    }
  }
  
  public var keyAsSegment: Bool {
    get {
      return getProperty(String: ConfigurationProperty.KEY_AS_SEGMENT.rawValue, defaultValue: false) as! Bool
    }
    set(value){
      setProperty(ConfigurationProperty.KEY_AS_SEGMENT.rawValue, Object: value)
    }
  }
  
  public var addressingDerivedTypes: Bool {
    get {
      return getProperty(String: ConfigurationProperty.ADDRESS_DERIVED_TYPE.rawValue, defaultValue: true) as! Bool
    }
    set(value){
      setProperty(ConfigurationProperty.ADDRESS_DERIVED_TYPE.rawValue, Object: value)
    }
  }
  
  public var useUrlOperationFQN: Bool {
    get {
      return getProperty(String: ConfigurationProperty.USE_OPERATION_FQN_IN_URL.rawValue, defaultValue: true) as! Bool
    }
    set(value){
      setProperty(ConfigurationProperty.USE_OPERATION_FQN_IN_URL.rawValue, Object: value)
    }
  }
  
  public var continueOnError: Bool {
    get {
      return getProperty(String: ConfigurationProperty.CONTINUE_ON_ERROR.rawValue, defaultValue: false) as! Bool
    }
    set(value){
      setProperty(ConfigurationProperty.CONTINUE_ON_ERROR.rawValue, Object: value)
    }
  }
  
  
  //
  //  }
  //
  //
  //  public func setHttpClientFactory(factory:HttpClientFactory) {
  //    setProperty(HTTP_CLIENT_FACTORY, factory)
  //  }
  
  
  // private static let DEFAULT_PUB_FORMAT:String = "pubFormat"
  // private static let DEFAULT_VALUE_FORMAT:String = "valueFormat"
  // private static let DEFAULT_BATCH_ACCEPT_FORMAT:String = "batchAcceptFormat"
  // private static let DEFAULT_MEDIA_FORMAT:String = "valueFormat"
  // private static let USE_XHTTP_METHOD:String = "useHTTPMethod"
  // private static let KEY_AS_SEGMENT:String = "keyAsSegment"
  // private static let ADDRESS_DERIVED_TYPE:String = "addressDerivedType"
  // private static let USE_OPERATION_FQN_IN_URL:String = "useOperationFqnInUrl"
  // private static let GZIP_COMPRESSION:String = "gzipCompression"
  // private static let CHUNKING:String = "chunking"
  // private static let CONTINUE_ON_ERROR:String = "continueOnError"
  

 // METHODS:
  
  /// Gets given configuration property
  /// - parameters:
  ///   - key: key value of the property to be retrieved
  ///   - defaultValue: default value to be used in case of the given key doesn't exist
  /// - returns: property value if exists default value if does not exist
  /// - throws: No error conditions are expected
  private func getProperty(String key:String, defaultValue:AnyObject) -> AnyObject {
    guard let value = CONF[key] else {
      return defaultValue
    }
    return value
  }
  

  /// Sets new configuration property
  /// - parameters:
  ///   - key: configuration property key
  ///   - value: value configuration property value
  /// - returns: given value
  /// - throws: No error conditions are expected
  private func setProperty(key:String,Object value:AnyObject) -> AnyObject {
    return CONF.updateValue(value,forKey: key)!
  }
  

//  public getHttpUriRequestFactory() -> HttpUriRequestFactory {
//    return (HttpUriRequestFactory) getProperty(HTTP_URI_REQUEST_FACTORY, new DefaultHttpUriRequestFactory())
//  }
//  
//
//  public func setHttpUriRequestFactory(factory:HttpUriRequestFactory) {
//    setProperty(HTTP_URI_REQUEST_FACTORY, factory)
//  }
  
  // TODO:
  
  //  public func  getExecutor() -> ExecutorService {
  //    return executor
  //  }
  //
  //
  //  public func setExecutor (executorService:ExecutorService) {
  //    executor = executorService
  //  }

// OBSOLETE

}