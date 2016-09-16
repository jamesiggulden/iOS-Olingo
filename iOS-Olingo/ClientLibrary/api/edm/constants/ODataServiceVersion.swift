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
//  File.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 28/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

// import java.util.regex.Matcher;
// import java.util.regex.Pattern;


 /// This class is a container for the supported ODataServiceVersions.

public enum ODataServiceVersion: String {
  

  /// OData Version 1.0
  case V10 = "1.0"
  /// OData Version 2.0
  case V20 = "2.0"
  /// OData Version 3.0
  case V30 = "3.0"
  /// OData Version 4.0
  case V40 = "4.0"
  
  // TODO: Implmenent when required
  /*
  private static final Pattern DATASERVICEVERSIONPATTERN = Pattern.compile("(\\p{Digit}+\\.\\p{Digit}+)(:?;.*)?");
   
  /// Validates format and range of a data service version string
  /// - parameters:
  ///   - version: version string
  /// - returns: <code>true</code> for a valid version
  /// - throws: Illegal argument exception
  
  public static func validateDataServiceVersion(version:String) -> Bool {
    let matcher = DATASERVICEVERSIONPATTERN.matcher(version)
    if (matcher.matches()) {
        let possibleDataServiceVersion = matcher.group(1)
        return V10.toString().equals(possibleDataServiceVersion)
            || V20.toString().equals(possibleDataServiceVersion)
            || V30.toString().equals(possibleDataServiceVersion)
            || V40.toString().equals(possibleDataServiceVersion)
    } else {
      throw new IllegalArgumentException(version)
    }
  }
  

  /// Check if <code>firstValue</code> is bigger then  <code>secondValue</code>
  /// - parameters:
  ///   - firstvalue: first value to be compared  
  ///   - secondvalue: second value to be compared
  /// - returns: <code>true</code> if firstValue is bigger than secondValue
  /// - throws: Illegal argument exception
  
  public static func isBiggerThan(firstValue: String , secondValue: String ) -> Bool{
    if (!validateDataServiceVersion(secondValue) || !validateDataServiceVersion(firstValue)) {
      throw new IllegalArgumentException("Illegal arguments: \(secondValue) and  \(firstValue)")
    }
  
    let me = Double.parseDouble(extractDataServiceVersionString(firstValue))
    let other = Double.parseDouble(extractDataServiceVersionString(secondValue))
  
    return me > other
  }
  
   
  /// Extract data service version and return it
  /// - parameters:
  ///   - rawDataServiceVersion: raw data service version from which the service version gets extracted
  /// - returns: the extracted data service version
  /// - throws: No error conditions are expected
  
  private static func extractDataServiceVersionString(rawDataServiceVersion:String) -> String? {
    if (rawDataServiceVersion != nil) {
      let pattern = rawDataServiceVersion.split(";")
      return pattern[0];
    }
    return nil;
  }
  
  private let version:String
  
   
 
  init (version:String) {
    self.version = version
  }
  
  public func toString() -> String {
    return version;
  }
 */
}

