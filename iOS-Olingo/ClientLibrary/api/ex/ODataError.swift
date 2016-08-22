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
//  ODataError.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 07/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


public class ODataError {
  
  // MARK: - Stored Properties

  /// The value for the code name/value pair is a language-independent string. 
  /// Its value is a service-defined error code.
  /// This code serves as a sub-status for the HTTP error code specified in the response. MAY be nil
  public var code: String = ""  //GS
  
  /// The value for the message name/value pair MUST be a human-readable,
  /// language-dependent representation of the error.  MUST not be nil
  public var message: String = ""  //GS
  
  /// The value for the target name/value pair is the target of the particular error 
  /// (for example, the name of the property in error). MAY be null.
  public var target:String = ""  //GS
  
  public var details:[ODataErrorDetail] = []
  
  /// server defined key-value pairs for debug environment only
  public var innerError:[String:String] = [:]
  
  // MARK: - Computed Properties
  
  
  // MARK: - Init
  
  
  // MARK: - Methods
  
  /// The value for the code name/value pair is a language-independent string. Its value is a service-defined error code. This code serves as a sub-status for the HTTP error code specified in the response. MAY be nil. This is an alternative to setting the property to allow method chaining
  /// - parameters:
  ///   - code: the service defined error code for this error
  /// - returns: `self` for method chaining
  /// - throws: No error conditions are expected
  public func setCode(code:String) -> ODataError {
    self.code = code
    return self
  }

  /// The value for the message name/value pair MUST be a human-readable, language-dependent representation of the error.  This is an alternative to setting the property to allow method chaining
  /// MUST not be nil
  /// - parameters:
  ///   - message: message for this error
  /// - returns: `self` for method chaining
  /// - throws: No error conditions are expected
  public func setMessage(message:String) -> ODataError {
    self.message = message
    return self
  }
  
  
  /// The value for the target name/value pair is the target of the particular error (for example, the name of the property in error). This is an alternative to setting the property to allow method chaining
  /// MAY be null.
  /// - parameters:
  ///   - target: target to which this error is related to
  /// - returns:`self` for method chaining
  /// - throws: No error conditions are expected
  public func setTarget(target:String) -> ODataError {
    self.target = target
    return self
  }

  
  /// Sets error details. This is an alternative to setting the property to allow method chaining
  /// - parameters:
  ///   - details: list of error details
  /// - returns:`self` for method chaining
  /// - throws: No error conditions are expected
  public func setDetails(details:[ODataErrorDetail]) -> ODataError {
    self.details = details
    return self
  }
  

  /// Sets server defined key-value pairs for debug environment only
  /// - parameters:
  ///   - innerError: dictionary of key value pairs
  /// - returns:`self` for method chaining
  /// - throws: No error conditions are expected
  public func setInnerError(innerError:[String:String]) -> ODataError {
    self.innerError = innerError
    return self
  }
}
