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
//  TypeUtil.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 30/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Type utilities helper class
/// See also AccentType
/// See also Content Type
public final class TypeUtil {
  
  static let MEDIA_TYPE_WILDCARD:String = "*"
  static let PARAMETER_Q:String = "q"
  static let WHITESPACE:String = " "
  static let WHITESPACE_CHAR:Character = " "
  static let PARAMETER_SEPARATOR:String = ";"
  static let PARAMETER_KEY_VALUE_SEPARATOR:String = "="
  static let TYPE_SUBTYPE_SEPARATOR:String = "/"
  static let TYPE_SUBTYPE_WILDCARD:String = "*"
  
  private init() {
    // static helper class 
    // add any value to alway have a init even if empty?
  }

  /// Split string of separated `key=value` pairs and build key value Dictionary
  /// See RFC 7231:
  /// The type, subtype, and parameter name tokens are case-insensitive.
  /// Parameter values might or might not be case-sensitive, depending on
  /// the semantics of the parameter name. The presence or absence of a
  /// parameter might be significant to the processing of a media-type,
  /// depending on its definition within the media type registry.
  /// - parameters:
  ///   - parameters: string of separated `key=value` pairs
  ///   - parameterDictionary: modifiable dictionary of parameters
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  
  static func parseParameters(parameters:String, inout parameterDictionary:[String:String]) throws {
    if parameters.isEmpty {
      return
    }
    let paramSplit = parameters.componentsSeparatedByString(TypeUtil.PARAMETER_SEPARATOR)
    for pair in paramSplit {
      do {
        let keyValue:[String] = try parseParameter(pair)
        parameterDictionary[keyValue[0]] = keyValue[1]
      }
    }
  }


  /// Split string of separated `key=value` pairs and build key value Dictionary
  /// See RFC 7231:
  /// The type, subtype, and parameter name tokens are case-insensitive.
  /// Parameter values might or might not be case-sensitive, depending on
  /// the semantics of the parameter name. The presence or absence of a
  /// parameter might be significant to the processing of a media-type,
  /// depending on its definition within the media type registry.
  /// - parameters:
  ///   - parameters: string of separated `key=value` pairs
  /// - returns: dictionary of parameters
  /// - throws: No error conditions are expected
  static func parseParameters(parameters:String?) throws -> [String:String]? {
    guard let parameters = parameters else {
      return nil
    }
    var paramDictionary:[String:String] = [:]
    let paramSplit = parameters.componentsSeparatedByString(self.PARAMETER_SEPARATOR)
    for pair in paramSplit {
      do {
      let keyValue:[String] = try parseParameter(pair)
        paramDictionary[keyValue[0]] = keyValue[1]
      }
    }
    return paramDictionary
  }

   
  /// Valid input is one `key=value` pair without spaces
  /// See RFC 7231:
  /// The type, subtype, and parameter name tokens are case-insensitive.
  /// Parameter values might or might not be case-sensitive, depending on
  /// the semantics of the parameter name. The presence or absence of a
  /// parameter might be significant to the processing of a media-type,
  /// depending on its definition within the media type registry.
  /// - parameters:
  ///   - parameter: `key=value` pair
  /// - returns: `key` as first array value (as lower case) and `value` as second array value
  /// - throws: Illegal Arguement Exception if parameter is not of the right format
  static func parseParameter(parameter: String?) throws -> [String] {
    
    guard let parameter=parameter else {
      throw IllegalArgumentException.NilOrEmptyString  // throw new IllegalArgumentException("An empty parameter is not allowed.")
    }
    var keyValue = parameter.componentsSeparatedByString(self.PARAMETER_KEY_VALUE_SEPARATOR)
    if (keyValue.count != 2) {
      throw IllegalArgumentException.InvalidFormat //  throw new IllegalArgumentException("Parameter '" + parameter + "' must have exactly one '" + PARAMETER_KEY_VALUE_SEPARATOR + "' that separates the name and the value.")
    }
    do {
      try validateParameterNameAndValue(keyValue[0], parameterValue: keyValue[1])
      keyValue[0] = keyValue[0].lowercaseStringWithLocale(NSLocale(localeIdentifier: "en"))
      return keyValue
    }
    // no specific catch as we will propogate to the calling method
  }
   
  /// Validates that parameter name and parameter value are valid
  /// i.e not nil or empty, no whitespace in name or begins with whitespace for value
  /// - parameters:
  ///   - parametername: string of the parameter key
  ///   - parameterValue : string of the parameter value
  /// - returns: No return value (void)
  /// - throws: Illegal Arguement Exception if parameters is not of the right format
  static func validateParameterNameAndValue(parameterName:String?, parameterValue:String?) throws {

    if parameterName?.isEmpty ?? true {
      throw IllegalArgumentException.NilOrEmptyString
    }
    if parameterValue?.isEmpty ?? true {
      throw IllegalArgumentException.NilOrEmptyString
    }
    if parameterName!.containsString(self.WHITESPACE){
      throw IllegalArgumentException.ContainsWhiteSpace
    }
    let index = parameterValue?.startIndex
    if parameterValue!.substringToIndex(index!) == self.WHITESPACE {
      throw IllegalArgumentException.BeginsWithWhiteSpace
    }
  }
}
