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
  
  case BINARY = "Binary"
  case BOOLEAN = "Boolean"
  case BYTE = "Byte"
  case SBYTE = "SByte"
  case DATE = "Date"
  case DATETIMEOFFSET = "DateTimeOffset"
  case TIMEOFDAY = "TimeOfDay"
  case DURATION = "Duration"
  case DECIMAL = "Decimal"
  case SINGLE = "Single"
  case DOUBLE = "Double"
  case GUID = "Guid"
  case INT16 = "Int16"
  case INT32 = "Int32"
  case INT64 = "Int64"
  case STRING = "String"
  case STREAM = "Stream"
  case GEOGRAPHY = "Geography"
  case GEOGRAPHYPOINT = "GeographyPoint"
  case GEOGRAPHYLINESTRING = "GeographyLineString"
  case GEOGRAPHYPOLYGON = "GeographyPolygon"
  case GEOGRAPHYMULTIPOINT = "GeographyMultiPoint"
  case GEOGRAPHYMULTILINESTRING = "GeographyMultiLineString"
  case GEOGRAPHYMULTIPOLYGON = "GeographyMultiPolygon"
  case GEOGRAPHYCOLLECTION = "GeographyCollection"
  case GEOMETRY = "Geometry"
  case GEOMETRYPOINT = "GeometryPoint"
  case GEOMETRYLINESTRING = "GeometryLineString"
  case GEOMETRYPOLYGON = "GeometryPolygon"
  case GEOMETRYMULTIPOINT = "GeometryMultiPoint"
  case GEOMETRYMULTILINESTRING = "GeometryMultiLineString"
  case GEOMETRYMULTIPOLYGON = "GeometryMultiPolygon"
  case GEOMETRYCOLLECTION = "GeometryCollection"


  // MARK: - Methods

  /// Returns the FullQualifiedName for this type kind
  /// - parameters:
  ///   - none:
  /// - returns: FullQualifiedName
  /// - throws: No error conditions are expected
  public func  getFullQualifiedName() -> FullQualifiedName {

    return FullQualifiedName(namespace: EDM_NAMESPACE, name: self.rawValue)

  }

  
// TODO: public func toString() -> String
  
  /// Returns string representation of enum value
  /// - parameters:
  ///   - none:
  /// - returns: String of enum value
  /// - throws: No error conditions are expected
   public func toString() -> String{
    return self.rawValue
  }
 
 
  /// Gets the EdmPrimitiveTypeKind from a full-qualified type name.
  /// - parameters:
  ///   - fqn: full-qualified type name
  /// - returns: EdmPrimitiveTypeKind object
  /// - throws: No error conditions are expected
  public func valueOfFQN(fqn:FullQualifiedName) throws -> EdmPrimitiveTypeKind? {
    if EDM_NAMESPACE == fqn.namespace {
      return EdmPrimitiveTypeKind(rawValue:fqn.name)
    }
    else {
      throw IllegalArgumentException.InvalidFormat  //IllegalArgumentException(fqn + " does not look like an EDM primitive type.")
    }
  }


  /// Gets the EdmPrimitiveTypeKind from a full type expression (like `Edm.Int32`)
  /// - parameters:
  ///   - fqn: String containing a full-qualified type name
  /// - returns: EdmPrimitiveTypeKind object
  /// - throws: No error conditions are expected
  public static func valueOfFQN(fqn:String) throws ->  EdmPrimitiveTypeKind? {

    if (!fqn.startsWith(EDM_NAMESPACE + ".")) {
      throw IllegalArgumentException.InvalidFormat
    }
    
    let fqnSubString = fqn.substringFromIndex(fqn.startIndex.advancedBy(4))
    return EdmPrimitiveTypeKind(rawValue:fqnSubString)
  }
  
  
  /// Checks if is a geospatial type
  /// - parameters:
  ///   - none:
  /// - returns: `true` if is geospatial type; `false` otherwise
  /// - throws: No error conditions are expected
  public func isGeospatial() -> Bool {
    return rawValue.startsWith("Geo")
  }
 
  
}

