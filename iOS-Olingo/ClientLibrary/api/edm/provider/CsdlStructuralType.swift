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

// Implementation based on Olingo's original java V4 implmentation.  Further details can be found at http://olingo.apache.org

//
//  File.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// The type Csdl structural type.

// TODO: class CsdlStructuralType
public class CsdlStructuralType : CsdlAbstractEdmItem, CsdlAnnotatable { // TODO : ext  imps CsdlNamed,
  
  // MARK: - Stored Properties
  
  //TODO: Navigation
  /// The Navigation properties
  //public var navigationProperties:[CsdlNavigationProperty] = [] //G
  

  /// The Base type
  let  baseType:FullQualifiedName? = nil  //G
  /// The Properties
  public var properties: [CsdlProperty] = []  //G
  /// The Is abstract
  public var isAbstract:Bool = false //GS
  /// The Is open type
  public var isOpenType:Bool = false
  ///The Name
  public var name:String = ""
  
  //TODO: Annotations
  /// The Annotations
  //private var annotations:[CsdlAnnotation] = [CsdlAnnotation]
  
  
  // MARK: - Computed Properties
  
  /// Gets base type fQN
  public var  baseTypeFQN:FullQualifiedName? {
    get {
      return baseType
    }
  }
  
  // MARK: - Init
 
  
  // MARK: - Methods
  
  /// get property with the provided name
  /// - parameters:
  ///   - name: name of property to find and return
  /// - returns: property if found nil otherwise
  /// - throws: No error conditions are expected
  public func getProperty(name:String) -> CsdlProperty? {
    return getOneByName(name, items: properties)
  }
  
  /// Sets properties
  /// - parameters:
  ///   - properties: the properties
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setProperties(properties:[CsdlProperty]) -> CsdlStructuralType {
    self.properties = properties
    return self
  }
  
  /// Sets abstract
  /// - parameters:
  ///   - isAbstract: the is abstract
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setAbstract(isAbstract:Bool) -> CsdlStructuralType {
    self.isAbstract = isAbstract
    return self
  }
  
  /// Sets open type
  /// - parameters:
  ///   - isOpenType: the is open type
  /// - returns: self
  /// - throws: No error conditions are expected
  public func setOpenType(isOpenType:Bool) -> CsdlStructuralType {
    self.isOpenType = isOpenType
    return self
  }
  
  
  // TODO: Navigation
  /*
  /**
   * Gets navigation property.
   *
   * @param name the name
   * @return the navigation property
   */
  public func getNavigationProperty(name:String) -> CsdlNavigationProperty {
    return getOneByName(name, navigationProperties)
  }
  
  /**
   * Sets navigation properties.
   *
   * @param navigationProperties the navigation properties
   * @return the navigation properties
   */
  public func setNavigationProperties( navigationProperties:[CsdlNavigationProperty]) -> CsdlStructuralType {
    self.navigationProperties = navigationProperties
    return self
  }
 */
  
  // TODO: Remaining CSDL functionality
  /*
   
   /**
   * Gets base type.
   *
   * @return the base type
   */
   public String getBaseType() {
   if (baseType != null) {
   return baseType.getFullQualifiedNameAsString();
   }
   return null;
   }
  
  @Override
  public String getName() {
    return name;
  }
  
  /**
   * Sets name.
   *
   * @param name the name
   * @return the name
   */
  public CsdlStructuralType setName(final String name) {
    this.name = name;
    return this;
  }
  
  /**
   * Gets base type fQN.
   *
   * @return the base type fQN
   */
  public FullQualifiedName getBaseTypeFQN() {
    return baseType;
  }
  
  /**
   * Sets base type.
   *
   * @param baseType the base type
   * @return the base type
   */
  public CsdlStructuralType setBaseType(final String baseType) {
    this.baseType = new FullQualifiedName(baseType);
    return this;
  }
  
  /**
   * Sets base type.
   *
   * @param baseType the base type
   * @return the base type
   */
  public CsdlStructuralType setBaseType(final FullQualifiedName baseType) {
    this.baseType = baseType;
    return this;
  }
  
  /**
   * Gets navigation properties.
   *
   * @return the navigation properties
   */
  public List<CsdlNavigationProperty> getNavigationProperties() {
    return navigationProperties;
  }
  
  /**
   * Gets navigation property.
   *
   * @param name the name
   * @return the navigation property
   */
  public CsdlNavigationProperty getNavigationProperty(final String name) {
    return getOneByName(name, navigationProperties);
  }
  
  /**
   * Sets navigation properties.
   *
   * @param navigationProperties the navigation properties
   * @return the navigation properties
   */
  public CsdlStructuralType setNavigationProperties(final List<CsdlNavigationProperty> navigationProperties) {
    this.navigationProperties = navigationProperties;
    return this;
  }
  
  @Override
  public List<CsdlAnnotation> getAnnotations() {
    return annotations;
  }
  
  /**
   * Sets a list of annotations
   * @param annotations list of annotations
   * @return this instance
   */
  public CsdlStructuralType setAnnotations(final List<CsdlAnnotation> annotations) {
    this.annotations = annotations;
    return this;
  }
 */
}
