
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
  // TODO: can't have duplicate values
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