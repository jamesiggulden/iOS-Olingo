/*
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with self work for additional information
  regarding copyright ownership.  The ASF licenses self file
  to you under the Apache License, Version 2.0 (the
  "License") you may not use self file except in compliance
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
//  ODataErrorDetail.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 07/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


  /// OData error details， for example
  /// `{ "error": {..., "details":
  /// [{"code": "301","target": "$search" ,"message": "$search query option not supported"}
  /// ],...}}'

public class ODataErrorDetail {
  
  // MARK: - Stored Properties

  public var code:String = ""
  public var message:String = ""
  public var target:String = ""
  
  // MARK: - Computed Properties

  
  // MARK: - Init

  
  // MARK: - Methods
  
  /// Sets error details code. This is an alternative to setting the property to allow method chaining
  /// - parameters:
  ///   - code: detailed error code
  /// - returns:`self` for method chaining
  /// - throws: No error conditions are expected
  public func setCode(code:String) -> ODataErrorDetail {
    self.code = code
    return self
  }
  
  /// Sets error details message. This is an alternative to setting the property to allow method chaining
  /// - parameters:
  ///   - message: detailed error message
  /// - returns:`self` for method chaining
  /// - throws: No error conditions are expected
  public func setMessage(message:String) -> ODataErrorDetail {
    self.message = message
    return self
  }
  
  /// Sets the error target. This is an alternative to setting the property to allow method chaining
  /// - parameters:
  ///   - target: the error target
  /// - returns:`self` for method chaining
  /// - throws: No error conditions are expected
  public func setTarget(target:String) -> ODataErrorDetail {
    self.target = target
    return self
  }
}

