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
//  EdmPropertyImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 15/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class EdmPropertyImpl:AbstractEdmNamed,  EdmProperty {
  
  // MARK: - Stored Properties

  private final let property:CsdlProperty
  private var typeInfo:EdmTypeInfo?
  private var propertyType:EdmType?
  
  // MARK: - Computed Properties
  
  public var isCollection:Bool {
    get {
      return property.isCollection
    }
  }
  
  // TODO: mapping
  /*
  public var getMapping:EdmMapping {
    get {
      return property.mapping
    }
  }
 */
  
  
  public var mimeType:String? {
    get {
      return property.mimeType
    }
  }
  
  public var isNilable:Bool {
    get {
      return property.isNilable
    }
  }
  
  public var maxLength:Int {
    get {
      return property.maxLength
    }
  }
  
  public var precision:Int {
    get {
      return property.precision
    }
  }
  
  
  public var scale:Int {
    get {
      return property.scale
    }
  }
  
  
  public var srid:SRID? {
    get {
      return property.srid
    }
  }
  
  
  public var unicode:Bool {
    get {
      return property.isUnicode
    }
  }
  
  
  public var defaultValue:String? {
    get {
      return property.defaultValue
    }
  }

  public var isPrimitive:Bool {
    if (typeInfo == nil) {
      do {
        try buildTypeInfo()
      }
      catch {
        log.error("")
      }
    }
    return typeInfo!.isPrimitiveType
  }

  public var type: EdmType? {
    if (propertyType == nil) {
      if (typeInfo == nil) {
        do {
          try buildTypeInfo()
        }
        catch {
          log.error("buildTypeInfo failed")
        }
      }
      propertyType = typeInfo!.type
      if (propertyType == nil) {
        log.error("Cannot find type with name: \(typeInfo!.fullQualifiedName)")
      }
    }
    
    return propertyType
  }


  // MARK: - Init

  init(edm:Edm, property:CsdlProperty ) {
    self.property = property
    super.init(edm: edm, name: property.name, annotatable: property)
  }
  
  
  // MARK: - Methods
   
  /// Build a new EDM type info instance
  /// - parameters:
  ///   - none
  /// - returns: No return value (void)
  /// - throws: EdmException.TypeNotFound
  private func buildTypeInfo() throws {
    if (property.type == nil) {
      log.error("Property \(property.name) must have a full qualified type.")
      throw EdmException.TypeNotFound(msg: "Property \(property.name) must have a full qualified type.")
    }

    typeInfo = EdmTypeInfo.Builder().setEdm(edm).setTypeExpression(property.type!).build()
  }
  
}

