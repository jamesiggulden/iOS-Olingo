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
//  EdmPrimitiveTypeFactory.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 19/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public final class EdmPrimitiveTypeFactory {
  
  /// Returns an instance for the provided EdmPrimitiveTypeKind in the form of {@link EdmPrimitiveType}.
  /// - parameters:
  ///   - kind: EdmPrimitiveTypeKind
  /// - returns: EdmPrimitiveType instance
  /// - throws: No error conditions are expected
  public static func getInstance(kind:EdmPrimitiveTypeKind ) throws ->  EdmPrimitiveType  {
    
    return EdmString.getInstance()
    
    /*
    switch (kind) {
    case EdmPrimitiveTypeKind.Binary:
      return EdmBinary.getInstance()
    case EdmPrimitiveTypeKind.Boolean:
      return EdmBoolean.getInstance()
    case EdmPrimitiveTypeKind.Byte:
      return EdmByte.getInstance()
    case EdmPrimitiveTypeKind.SByte:
      return EdmSByte.getInstance()
    case EdmPrimitiveTypeKind.Date:
      return EdmDate.getInstance()
    case EdmPrimitiveTypeKind.DateTimeOffset:
      return EdmDateTimeOffset.getInstance()
    case EdmPrimitiveTypeKind.TimeOfDay:
      return EdmTimeOfDay.getInstance()
    case EdmPrimitiveTypeKind.Duration:
      return EdmDuration.getInstance()
    case EdmPrimitiveTypeKind.Decimal:
      return EdmDecimal.getInstance()
    case EdmPrimitiveTypeKind.Single:
      return EdmSingle.getInstance()
    case EdmPrimitiveTypeKind.Double:
      return EdmDouble.getInstance()
    case EdmPrimitiveTypeKind.Guid:
      return EdmGuid.getInstance()
    case EdmPrimitiveTypeKind.Int16:
      return EdmInt16.getInstance()
    case EdmPrimitiveTypeKind.Int32:
      return EdmInt32.getInstance()
    case EdmPrimitiveTypeKind.Int64:
      return EdmInt64.getInstance()
    case EdmPrimitiveTypeKind.String:
      return EdmString.getInstance()
    case EdmPrimitiveTypeKind.Stream:
      return EdmStream.getInstance()
  
    case EdmPrimitiveTypeKind.Geography:
      return EdmGeography.getInstance()
    case EdmPrimitiveTypeKind.GeographyPoint:
      return EdmGeographyPoint.getInstance()
    case EdmPrimitiveTypeKind.GeographyLineString:
      return EdmGeographyLineString.getInstance()
    case EdmPrimitiveTypeKind.GeographyPolygon:
      return EdmGeographyPolygon.getInstance()
    case EdmPrimitiveTypeKind.GeographyMultiPoint:
      return EdmGeographyMultiPoint.getInstance()
    case EdmPrimitiveTypeKind.GeographyMultiLineString:
      return EdmGeographyMultiLineString.getInstance()
    case EdmPrimitiveTypeKind.GeographyMultiPolygon:
      return EdmGeographyMultiPolygon.getInstance()
    case EdmPrimitiveTypeKind.GeographyCollection:
      return EdmGeographyCollection.getInstance()
    case EdmPrimitiveTypeKind.Geometry:
      return EdmGeometry.getInstance()
    case EdmPrimitiveTypeKind.GeometryPoint:
      return EdmGeometryPoint.getInstance()
    case EdmPrimitiveTypeKind.GeometryLineString:
      return EdmGeometryLineString.getInstance()
    case EdmPrimitiveTypeKind.GeometryPolygon:
      return EdmGeometryPolygon.getInstance()
    case EdmPrimitiveTypeKind.GeometryMultiPoint:
      return EdmGeometryMultiPoint.getInstance()
    case EdmPrimitiveTypeKind.GeometryMultiLineString:
      return EdmGeometryMultiLineString.getInstance()
    case EdmPrimitiveTypeKind.GeometryMultiPolygon:
      return EdmGeometryMultiPolygon.getInstance()
    case EdmPrimitiveTypeKind.GeometryCollection:
      return EdmGeometryCollection.getInstance()
  
    default:
      throw IllegalArgumentException.InvalidFormat //("Wrong type: " + kind)
    }
     */
  }
  // TODO:
  /*
  private EdmPrimitiveTypeFactory() {
  // empty constructor for static utility class
  }
  */
  
}
