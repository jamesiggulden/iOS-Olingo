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
//  CsdlProperty.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 15/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * The type Csdl property.
 */
public class CsdlProperty: CsdlAbstractEdmItem , CsdlNamed, CsdlAnnotatable {
  
  // MARK: - Stored Properties

  public var name:String = ""  //G
  
  public var type:String?
  
  public var isCollection:Bool = false

  public var mimeType:String?

  // TODO: mappings
  //public var mapping:CsdlMapping

  // Facets
  public var defaultValue:String?
  
  public var isNilable:Bool = true
  
  public var maxLength: Int?

  public var precision: Int = 0
  
  public var scale: Int = 0
  
  public var isUnicode:Bool = true
  
  public var srid:SRID?

  // TODO: Annotations
  //public var  annotations:[CsdlAnnotation] = []
  
  // MARK: - Computed Properties

  
  // MARK: - Init

  override init() {
    super.init()
  }
  // MARK: - Methods

  /**
   * Sets name.
   *
   * @param name the name
   * @return the name
   */
  public func setName(String name:String) -> CsdlProperty {
    self.name = name
    return self
  }
  
  
  /**
   * Sets type.
   *
   * @param type the type
   * @return the type
   */
  public func setType(type:String) -> CsdlProperty {
    self.type = type
    return self
  }
  
  /**
   * Gets type as fQN object.
   *
   * @return the type as fQN object
   */
  public func getTypeAsFQNObject() throws -> FullQualifiedName?  {
    do {
      return try FullQualifiedName(namespaceAndName: type!)
    }
    
  }
  
  /**
   * Sets type.
   *
   * @param fqnName the fqn name
   * @return the type
   */
  public func setType(fqnName:FullQualifiedName) -> CsdlProperty {
    type = fqnName.fqn
    //type = fqnName.getFullQualifiedNameAsString()
    return self
  }
  

  
  /**
   * Sets collection.
   *
   * @param isCollection the is collection
   * @return the collection
   */
  public func setCollection(isCollection:Bool) -> CsdlProperty {
    self.isCollection = isCollection
    return self
  }
  
  
  /**
   * Sets default value.
   *
   * @param defaultValue the default value
   * @return the default value
   */
  public func setDefaultValue( String defaultValue:String) -> CsdlProperty {
    self.defaultValue = defaultValue
    return self
  }
  
  
  
  /**
   * Sets nilable.
   *
   * @param nilable the nilable
   * @return the nilable
   */
  public func setNilable( Bool nilable:Bool) -> CsdlProperty {
    self.isNilable = nilable
    return self
  }
  
  
  /**
   * Sets max length.
   *
   * @param maxLength the max length
   * @return the max length
   */
  public func setMaxLength(maxLength:Int) -> CsdlProperty {
    self.maxLength = maxLength
    return self
  }
  
  
  /**
   * Sets precision.
   *
   * @param precision the precision
   * @return the precision
   */
  public func setPrecision(precision:Int)  -> CsdlProperty {
    self.precision = precision
    return self
  }
  
  
  /**
   * Sets scale.
   *
   * @param scale the scale
   * @return the scale
   */
  public func setScale(scale:Int) -> CsdlProperty {
    self.scale = scale
    return self
  }
  

  
  /**
   * Sets unicode.
   *
   * @param unicode the unicode
   * @return the unicode
   */
  public func setUnicode(unicode:Bool) -> CsdlProperty {
    self.isUnicode = unicode
    return self
  }
  
  
  /**
   * Sets mime type.
   *
   * @param mimeType the mime type
   * @return the mime type
   */
  public func setMimeType(mimeType:String) -> CsdlProperty {
    self.mimeType = mimeType
    return self
  }
  
  // TODO: Mapping
/*
  /**
   * Sets mapping.
   *
   * @param mapping the mapping
   * @return the mapping
   */
  public func setMapping( CsdlMapping mapping) -> CsdlProperty {
    self.mapping = mapping
    return self
  }
*/
  
  
  //TODO: Annotations
/*
  /**
   * Sets a list of annotations
   * @param annotations list of annotations
   * @return self instance
   */
public func setAnnotations(annotations: [CsdlAnnotation]) -> CsdlProperty {
    self.annotations = annotations
    return self
  }
 */
  
  /**
   * Sets srid.
   *
   * @param srid the srid
   * @return the srid
   */
  public func setSrid(srid:SRID) -> CsdlProperty {
    self.srid = srid
    return self
  }
  
  }
