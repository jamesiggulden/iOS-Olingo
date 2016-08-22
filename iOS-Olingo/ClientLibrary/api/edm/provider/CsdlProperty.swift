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
  public var maxLength: Int = 0
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

  /// Sets name
  /// - parameters:
  ///   - name: the name
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setName(name:String) -> CsdlProperty {
    self.name = name
    return self
  }
  
  /// Sets type
  /// - parameters:
  ///   - name: the type
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setType(type:String) -> CsdlProperty {
    self.type = type
    return self
  }
  
  /// Gets type as fQN object
  /// - parameters:
  ///   - none
  /// - returns: the type as fQN object
  /// - throws: No error conditions are expected
  public func getTypeAsFQNObject() throws -> FullQualifiedName?  {
    do {
      return try FullQualifiedName(namespaceAndName: type!)
    }
    
  }
  
  /// Sets type using FQN
  /// - parameters:
  ///   - fqnName: the fqn name
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setType(fqnName:FullQualifiedName) -> CsdlProperty {
    type = fqnName.fqn
    //type = fqnName.getFullQualifiedNameAsString()
    return self
  }
  
  /// Sets collection
  /// - parameters:
  ///   - isCollection: is a collection flag
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setCollection(isCollection:Bool) -> CsdlProperty {
    self.isCollection = isCollection
    return self
  }
  
  /// Sets default value
  /// - parameters:
  ///   - defaultValue: the default value
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setDefaultValue( String defaultValue:String) -> CsdlProperty {
    self.defaultValue = defaultValue
    return self
  }
  
  /// Sets nilable
  /// - parameters:
  ///   - nilable: is nilable flag
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setNilable( Bool nilable:Bool) -> CsdlProperty {
    self.isNilable = nilable
    return self
  }
  
  /// Sets max length
  /// - parameters:
  ///   - maxLength:the max length
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setMaxLength(maxLength:Int) -> CsdlProperty {
    self.maxLength = maxLength
    return self
  }
  
  /// Sets precision
  /// - parameters:
  ///   - precision:the precision
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setPrecision(precision:Int)  -> CsdlProperty {
    self.precision = precision
    return self
  }

  /// Sets scale
  /// - parameters:
  ///   - scale:the max scale
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setScale(scale:Int) -> CsdlProperty {
    self.scale = scale
    return self
  }
  
  /// Sets unicode
  /// - parameters:
  ///   - unicode: is unicode flag
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setUnicode(unicode:Bool) -> CsdlProperty {
    self.isUnicode = unicode
    return self
  }
  
  /// Sets mime type
  /// - parameters:
  ///   - mime type:the mime type
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setMimeType(mimeType:String) -> CsdlProperty {
    self.mimeType = mimeType
    return self
  }
  
  /// Sets srid
  /// - parameters:
  ///   - srid: the srid
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setSrid(srid:SRID) -> CsdlProperty {
    self.srid = srid
    return self
  }
  
  // TODO: Mapping
  /*
   /// Sets mapping
   /// - parameters:
   ///   - mapping:the mapping
   /// - returns: self
   /// - throws: No error conditions are expected
  public func setMapping( CsdlMapping mapping) -> CsdlProperty {
    self.mapping = mapping
    return self
  }
*/
  
  
  //TODO: Annotations
/*
   /// Sets a list of annotations
   /// - parameters:
   ///   - annotations list of annotations
   /// - returns: self
   /// - throws: No error conditions are expected
   public func setAnnotations(annotations: [CsdlAnnotation]) -> CsdlProperty {
    self.annotations = annotations
    return self
  }
 */
  

  
}
