
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

//  ODataHeadersImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 28/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


/// implementation class of ODataHeaders
public class ODataHeadersImpl: ODataHeaders {
  
  
  /// OData request/response header key/value pairs
  /// Creating a dictionary to store header values.  The Olingo java impl. uses a treemap which provides
  /// an ordered list.  Swifts dictionary is unordered so use the sort() method on the keys or values
  /// to sort the dictionary
  
  public var headers=[String:String]()
  
  
  
 
  public func setHeader(name:String,value:String ) -> ODataHeadersImpl
  {
    headers[name] = value
    return self
  }
  
 
  public func getHeader(name:String) -> String!
  {
    return headers[name]
  }
  

  public func removeHeader(name:String) -> String!
  {
    return headers.removeValueForKey(name)
  }
  
 
  public func getHeaderNames() -> [String]
  {
    return [String](headers.keys.sort())
  }
}
