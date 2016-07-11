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
//  EdmPrimitiveTypeKind.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 07/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


/// Enumeration of all primitive type kinds.
public enum EdmPrimitiveTypeKind : String {
  
  case Binary = "Binary"
  case Boolean = "Boolean"
  case Byte = "Byte"
  case SByte = "SByte"
  case Date = "Date"
  case DateTimeOffset = "DateTimeOffset"
  case TimeOfDay = "TimeOfDay"
  case Duration = "Duration"
  case Decimal = "Decimal"
  case Single = "Single"
  case Double = "Double"
  case Guid = "Guid"
  case Int16 = "Int16"
  case Int32 = "Int32"
  case Int64 = "Int64"
  case String = "String"
  case Stream = "Stream"
  case Geography = "Geography"
  case GeographyPoint = "GeographyPoint"
  case GeographyLineString = "GeographyLineString"
  case GeographyPolygon = "GeographyPolygon"
  case GeographyMultiPoint = "GeographyMultiPoint"
  case GeographyMultiLineString = "GeographyMultiLineString"
  case GeographyMultiPolygon = "GeographyMultiPolygon"
  case GeographyCollection = "GeographyCollection"
  case Geometry = "Geometry"
  case GeometryPoint = "GeometryPoint"
  case GeometryLineString = "GeometryLineString"
  case GeometryPolygon = "GeometryPolygon"
  case GeometryMultiPoint = "GeometryMultiPoint"
  case GeometryMultiLineString = "GeometryMultiLineString"
  case GeometryMultiPolygon = "GeometryMultiPolygon"
  case GeometryCollection = "GeometryCollection"
  
  
  //TODO: Methods
  /*
  
  /// Checks if is a geospatial type
  /// - parameters:
  ///   - none:
  /// - returns: `true` if is geospatial type; `false` otherwise
  /// - throws: No error conditions are expected
  public func isGeospatial() -> Bool {
    return rawValue.containsString("Geo")
      // name().startsWith("Geo");
  }
  
   
  /// Returns the FullQualifiedName for this type kin
  /// - parameters:
  ///   - none:
  /// - returns: FullQualifiedName
  /// - throws: No error conditions are expected
  public func  getFullQualifiedName() -> FullQualifiedName {
    return FullQualifiedName(EdmPrimitiveType.EDM_NAMESPACE, toString())
  }
  
  /**
   * Gets the {@link EdmPrimitiveTypeKind} from a full-qualified type name.
   * @param fqn full-qualified type name
   * @return {@link EdmPrimitiveTypeKind} object
   */
  public static func valueOfFQN(fqn:FullQualifiedName) throws -> EdmPrimitiveTypeKind {
    if (EdmPrimitiveType.EDM_NAMESPACE.equals(fqn.getNamespace())) {
      return valueOf(fqn.getName())
    }
    else {
      throw IllegalArgumentException.InvalidFormat  //IllegalArgumentException(fqn + " does not look like an EDM primitive type.")
    }
  }
  
  /**
   * Gets the {@link EdmPrimitiveTypeKind} from a full type expression (like <code>Edm.Int32</code>).
   * @param fqn String containing a full-qualified type name
   * @return {@link EdmPrimitiveTypeKind} object
   */
  public static func valueOfFQN(fqn:String) throws ->  EdmPrimitiveTypeKind {
    if (!fqn.startsWith(EdmPrimitiveType.EDM_NAMESPACE + ".")) {
        throw IllegalArgumentException.InvalidFormat
    }
  
    return valueOf(fqn.substring(4))
  }
 */
  
}
