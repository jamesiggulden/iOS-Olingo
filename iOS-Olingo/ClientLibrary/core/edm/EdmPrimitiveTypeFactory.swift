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
  
  // MARK: - Stored Properties

  // MARK: - Computed Properties

  // MARK: - Init

  // MARK: - Methods

  /// Returns an instance for the provided EdmPrimitiveTypeKind in the form of EdmPrimitiveType
  /// - parameters:
  ///   - kind: EdmPrimitiveTypeKind
  /// - returns: EdmPrimitiveType instance
  /// - throws: No error conditions are expected
  public static func getInstance(kind:EdmPrimitiveTypeKind ) throws ->  EdmPrimitiveType  {
    
    //return EdmString.getInstance()
    
    
    switch (kind) {
    case EdmPrimitiveTypeKind.STRING:
      return EdmString.instance
    case EdmPrimitiveTypeKind.INT32:
      return EdmInt32.instance
    case EdmPrimitiveTypeKind.INT64:
      return EdmInt64.instance
    case EdmPrimitiveTypeKind.DECIMAL:
      return EdmDecimal.getInstance()
    case EdmPrimitiveTypeKind.DATETIMEOFFSET:
      return EdmDateTimeOffset.getInstance()
     /*
    case EdmPrimitiveTypeKind.BINARY:
      return EdmBinary.getInstance()
    case EdmPrimitiveTypeKind.BOOLEAN:
      return EdmBoolean.getInstance()
    case EdmPrimitiveTypeKind.BYTE:
      return EdmByte.getInstance()
    case EdmPrimitiveTypeKind.SBYTE:
      return EdmSByte.getInstance()
    case EdmPrimitiveTypeKind.DATE:
      return EdmDate.getInstance()

    case EdmPrimitiveTypeKind.TIMEOFDAY:
      return EdmTimeOfDay.getInstance()
    case EdmPrimitiveTypeKind.DURATION:
      return EdmDuration.getInstance()

    case EdmPrimitiveTypeKind.SINGLE:
      return EdmSingle.getInstance()
    case EdmPrimitiveTypeKind.DOUBLE:
      return EdmDouble.getInstance()
    case EdmPrimitiveTypeKind.GUID:
      return EdmGuid.getInstance()
    case EdmPrimitiveTypeKind.INT16:
      return EdmInt16.getInstance()


    case EdmPrimitiveTypeKind.STREAM:
      return EdmStream.getInstance()
  
    case EdmPrimitiveTypeKind.GEOGRAPHY:
      return EdmGeography.getInstance()
    case EdmPrimitiveTypeKind.GEOGRAPHYPOINT:
      return EdmGeographyPoint.getInstance()
    case EdmPrimitiveTypeKind.GEOGRAPHYLINESTRING:
      return EdmGeographyLineString.getInstance()
    case EdmPrimitiveTypeKind.GEOGRAPHYPOLYGON:
      return EdmGeographyPolygon.getInstance()
    case EdmPrimitiveTypeKind.GEOGRAPHYMULTIPOINT:
      return EdmGeographyMultiPoint.getInstance()
    case EdmPrimitiveTypeKind.GEOGRAPHYMULTILINESTRING:
      return EdmGeographyMultiLineString.getInstance()
    case EdmPrimitiveTypeKind.GEOGRAPHYMULTIPOLYGON:
      return EdmGeographyMultiPolygon.getInstance()
    case EdmPrimitiveTypeKind.GEOGRAPHYCOLLECTION:
      return EdmGeographyCollection.getInstance()
    case EdmPrimitiveTypeKind.GEOMETRY:
      return EdmGeometry.getInstance()
    case EdmPrimitiveTypeKind.GEOMETRYPOINT:
      return EdmGeometryPoint.getInstance()
    case EdmPrimitiveTypeKind.GEOMETRYLINESTRING:
      return EdmGeometryLineString.getInstance()
    case EdmPrimitiveTypeKind.GEOMETRYPOLYGON:
      return EdmGeometryPolygon.getInstance()
    case EdmPrimitiveTypeKind.GEOMETRYMULTIPOINT:
      return EdmGeometryMultiPoint.getInstance()
    case EdmPrimitiveTypeKind.GEOMETRYMULTILINESTRING:
      return EdmGeometryMultiLineString.getInstance()
    case EdmPrimitiveTypeKind.GEOMETRYMULTIPOLYGON:
      return EdmGeometryMultiPolygon.getInstance()
    case EdmPrimitiveTypeKind.GEOMETRYCOLLECTION:
      return EdmGeometryCollection.getInstance()
    */
    default:
      return EdmString.instance
      throw IllegalArgumentException.InvalidFormat //("Wrong type: " + kind)
    }
    
  }
  // TODO:
  /*
  private EdmPrimitiveTypeFactory() {
  // empty constructor for static utility class
  }
  */
  
}
