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
//  ErrorTypes.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 30/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public enum IllegalArgumentException:ErrorType {
  case NilOrEmptyString
  case ContainsWildCard
  case ContainsWhiteSpace
  case InvalidFormat
  case BeginsWithWhiteSpace
}

public enum ClassInitialisationException: ErrorType {
  case InitialisationFailed
}

public enum HttpError:ErrorType {
  case HttpRequestFailed
  case InvalidHttpResponse
  case ErrorCodeReturned (errorCode:Int)
}

public enum ODataDeserializerException:ErrorType {
  case InvalidFormat
}

public enum EdmPrimitiveTypeException:ErrorType{
  case LiteralNilNotAllowed
  case LiteralHasIllegalContent
  case LiteralCannotBeConvertedToValueType
  case ValueTypeNotSupported
}

public enum EdmException:ErrorType{
  case BaseTypeNotFound (msg:String?)
  case NilValue (msg:String?)
  case TypeNotFound (msg:String?)
  case InvalidType (msg:String?)
  case MalformedType (msg:String?)
}
  
public enum GetODataException:ErrorType{
  case ODataValueFailed
  case ODataPropertyFailed
  case ODataEntityFailed
  case OdataEntitySetFailed
}
  