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


//
//  SRID.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 13/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * A geometry or geography property MAY define a value for the SRID attribute. The value of this attribute identifies
 * which spatial reference system is applied to values of the property on type instances.
 * <br/>
 * The value of the SRID attribute MUST be a non-negative integer or the special value <tt>variable</tt>. If no value is
 * specified, the attribute defaults to 0 for Geometry types or 4326 for Geography types.
 * <br/>
 * Standards Track Work Product Copyright © OASIS Open 2013. All Rights Reserved. 19 November 2013
 * <br>
 * The valid values of the SRID attribute and their meanings are as defined by the
 * European Petroleum Survey Group [EPSG].
 */
public final class SRID { // Serializable {
  
  // MARK: - Stored Properties

  static private let serialVersionUID:Int = 8412685060902464629
  private static let VARIABLE:String = "variable"
  
  public var dimension = Geospatial.Dimension.GEOGRAPHY  //GS
  private let value:Int? = nil
  private let variable:Bool? = nil
  
  // MARK: - Computed Properties
  
  
  
  // MARK: - Init

  
  // MARK: - Methods
  
  
  // TODO: static func valueOf(exp:String) -> SRID 
  /*
  /// Creates a new SRID instance from a given value
  /// - parameters:
  ///   - exp: Either "variable" or a numeric non-negative SRID value
  /// - returns: SRID instance
  /// - throws: No error conditions are expected
  public static func valueOf(exp:String) -> SRID {
    let instance:SRID = SRID()
  
    if VARIABLE.equalsIgnoreCase(exp) {
        instance.variable = Boolean.TRUE
    }
    else {
      instance.value = Integer.valueOf(exp)
      if instance.value < 0 {
        throw new IllegalArgumentException(
          "The value of the SRID attribute MUST be a non-negative integer or the special value 'variable'")
      }
    }
    return instance
  }
 */

  
  private func getValue() -> String {
    return value == nil ? dimension == Geospatial.Dimension.GEOMETRY ? "0" : "4326" : "\(value)"
  }
  

  
  /**
   * Returns true if the value of the instance is not equals to the default (uninitialized).
   * @return true if the value of the instance is not equals to the default (uninitialized)
   */
  public func isNotDefault() -> Bool {
    return value != nil || variable != nil
  }

  public func equals(o:AnyObject) -> Bool {
    if (self === o) {
      return true
    }
    else {
      return false
      //TODO: extra checks
      /*
      if (o == nil || getClass() != o.getClass()) {
        return false
      }
      
      SRID srid = (SRID) o
      
      if (dimension != srid.dimension) {
        return false
      }
      if (value != nil ? !value.equals(srid.value) : srid.value != nil) {
        return false
      }
      return !(variable != nil ? !variable.equals(srid.variable) : srid.variable != nil)
      */
    }
    
  }
  
  // TODO: func hashCode() -> Int
  /*
  public func hashCode() -> Int {
    int result = dimension != nil ? dimension.hashCode() : 0
    result = 31 * result + (value != nil ? value.hashCode() : 0)
    result = 31 * result + (variable != nil ? variable.hashCode() : 0)
    return result
  }
 */
  
  // TODO: func toString() -> String
  /*
  public func toString() -> String {
    return variable != nil && variable! ? VARIABLE : getValue()
  }
 */
}
