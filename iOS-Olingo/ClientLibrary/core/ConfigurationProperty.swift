//
//  ConfigurationProperty.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 04/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

// enum for the default values of teh set of Configuration properties
enum ConfigurationProperty:String {
  case DEFAULT_PUB_FORMAT = "pubFormat"
  case DEFAULT_VALUE_FORMAT = "valueFormat"
  case DEFAULT_BATCH_ACCEPT_FORMAT = "batchAcceptFormat"
  // can not have duplicate values
  //case DEFAULT_MEDIA_FORMAT = "valueFormat"
  case HTTP_CLIENT_FACTORY = "httpClientFactory"
  case HTTP_URI_REQUEST_FACTORY = "httpUriRequestFactory"
  case USE_XHTTP_METHOD = "useHTTPMethod"
  case KEY_AS_SEGMENT = "keyAsSegment"
  case ADDRESS_DERIVED_TYPE = "addressDerivedType"
  case USE_OPERATION_FQN_IN_URL = "useOperationFqnInUrl"
  case GZIP_COMPRESSION = "gzipCompression"
  case CHUNKING = "chunking"
  case CONTINUE_ON_ERROR = "continueOnError"
}