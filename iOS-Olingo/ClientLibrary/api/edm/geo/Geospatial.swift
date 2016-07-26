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
//  Geospatial.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 13/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Base class for all geospatial info
public  class Geospatial {  // Abstract Class
  
  // MARK: - Stored Properties

  /// Dimension of the geospatial type
  public enum Dimension {
    /// Geometry type
    case GEOMETRY
    /// Geography type
    case GEOGRAPHY
  }
  
  /// Type of the geospatial type
  public enum Type {
     /// The OGIS geometry type number for points.
    case POINT
     /// The OGIS geometry type number for lines.
    case LINESTRING
     /// The OGIS geometry type number for polygons.
    case POLYGON
     /// The OGIS geometry type number for aggregate points.
    case MULTIPOINT
     /// The OGIS geometry type number for aggregate lines.
    case MULTILINESTRING
     /// The OGIS geometry type number for aggregate polygons.
    case MULTIPOLYGON
     /// The OGIS geometry type number for feature collections.
    case GEOSPATIALCOLLECTION
  }
  
  public let dimension:Dimension //G
  
  public let type:Type?  //G
  
   /// nil value means it is expected to vary per instance.
  public let srid:SRID?  //G
  
  // MARK: - Computed Properties

  
  // MARK: - Init
   
  init(dimension:Dimension, type:Type, srid:SRID?) {
    self.dimension = dimension
    self.type = type
    self.srid = srid == nil ? SRID() : srid
    self.srid!.dimension = dimension
  }
  
  
  // MARK: - Methods
  
   /// Returns the {@link EdmPrimitiveTypeKind}
   /// @return EDM primitive type kind
   
  public func getEdmPrimitiveTypeKind() -> EdmPrimitiveTypeKind {
    fatalError("Must Implement")
  }
}

