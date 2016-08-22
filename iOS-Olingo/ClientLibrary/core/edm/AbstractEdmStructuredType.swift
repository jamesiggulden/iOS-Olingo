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
//  AbstractEdmStructuredType.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class AbstractEdmStructuredType: EdmTypeImpl, EdmStructuredType {
  
  // MARK: - Stored Properties

  public var baseType : EdmStructuredType?
  let baseTypeName: FullQualifiedName?
  
  private final let providerStructuredType: CsdlStructuralType
  
  private let _propertyNames:[String]?
  private let properties: [String: EdmProperty]?
  private let navigationPropertyNames:[String]?
  private let navigationProperties: [String: EdmNavigationProperty]?
  
  // MARK: - Computed Properties
  
  public var propertyNames:[String] {
    var localPropertyNames = [String]()
    guard _propertyNames != nil else {
      checkBaseType()
      if (baseType != nil) {
        
        localPropertyNames += baseType!.propertyNames
      }
      //localPropertyNames + getProperties().keySet()
      localPropertyNames += getProperties().keys
      //propertyNames = Collections.unmodifiableList(localPropertyNames)
      return localPropertyNames
    }
    return localPropertyNames
  }
  
  
  public var isOpenType:Bool {
    return providerStructuredType.isOpenType
  }
  
  
  public var isAbstract: Bool {
    return providerStructuredType.isAbstract
  }


  
  // MARK: - Init

  init(edm:Edm, typeName:FullQualifiedName,kind:EdmTypeKind,structuredType: CsdlStructuralType ) {
    self.baseTypeName = structuredType.baseTypeFQN
    self.providerStructuredType = structuredType
    self._propertyNames = nil
    self.properties = nil
    self.navigationPropertyNames = nil
    self.navigationProperties = nil
    super.init(edm: edm, typeName: typeName, kind: kind, annotatable: structuredType)

  }
  
  // MARK: - Methods

  func buildBaseType(baseTypeName:FullQualifiedName ) -> EdmStructuredType  {
    // only implnented to test vaibility of enforcing the creation of the method in a concrete class.
    // Swift does not provide an abstarct method capability.
    // Alternative it is create a protocol for this abstract class
    fatalError ("Must Implement in subclass")
  }
  
  func checkBaseType(){
    // only implnented to test vaibility of enforcing the creation of the method in a concrete class.
    // Swift does not provide an abstarct method capability.
    // Alternative it is create a protocol for this abstract class
    fatalError ("Must Implement in subclass")
  }
  
  
  // TODO: Navigation
  /*
  public func getNavigationPropertyNames()  -> [String]{
    if guard navigationPropertyNames == navigationPropertyNames else {
      let localNavigatinPropertyNames = [String]
      checkBaseType()
      if (baseType != nil) {
        localNavigatinPropertyNames.addAll(baseType.getNavigationPropertyNames())
      }
      localNavigatinPropertyNames.addAll(getNavigationProperties().keySet())
      navigationPropertyNames = Collections.unmodifiableList(localNavigatinPropertyNames)
    }
    return navigationPropertyNames
  }
  */
  
   
  /// get property with the provided name
  /// - parameters:
  ///   - name: name of property to find and return
  /// - returns: EdmElement if found nil otherwise
  /// - throws: No error conditions are expected
  public func getProperty(name:String) -> EdmElement? {
    let property = getStructuralProperty(name)
    if property != nil {
      // TODO : Navigation
      //property = getNavigationProperty(name)
    }
    return property
  }
  
    /// get structural property with the provided name
  /// - parameters:
  ///   - name: name of property to find and return
  /// - returns: EdmProperty if found nil otherwise
  /// - throws: No error conditions are expected
  public func getStructuralProperty(name:String) -> EdmProperty? {
    var property:EdmProperty?
    checkBaseType()
    if let baseType = baseType {
      property = baseType.getStructuralProperty(name)
    }
    if property != nil {
      property = getProperties()[name]
    }
    return property
  }
  
  // TODO: navigation
  /*
  public func getNavigationProperty(name:String) -> EdmNavigationProperty  {
    var property:EdmNavigationProperty?
    checkBaseType()
    if let baseType = baseType  {
      property = baseType.getNavigationProperty(name)
    }
    if guard property == property else  {
      property = getNavigationProperties().get(name)
    }
    return property
  }
  */
  
   
  /// check compatability with target type
  /// - parameters:
  ///   - targetType: type to check against
  /// - returns: true if types are the same
  /// - throws: EdmException.NilValue
  public func compatibleTo(targetType: EdmType?) throws -> Bool {
    var sourceType: EdmStructuredType?  = self
    guard let targetType = targetType else {
      throw EdmException.NilValue(msg: "Target type must not be nil")
    }
    if sourceType!.name != targetType.name || sourceType!.namespace != targetType.namespace {
      sourceType = sourceType!.baseType
      if (sourceType == nil) {
        return false
      }
    }
    return true
  }
  
   
  /// get properties as a dictionary
  /// - parameters:
  ///   - none
  /// - returns: Dictionary of properties
  /// - throws: No error conditions are expected
  public func getProperties() -> [String: EdmProperty] {
    let localProperties = [String: EdmProperty]()
    guard properties != nil else {
      var localProperties = [String: EdmProperty]()
      let structureTypeProperties = providerStructuredType.properties
      for prop in structureTypeProperties {
        localProperties[prop.name] = EdmPropertyImpl(edm: edm,property: prop) as EdmProperty
      }
      //properties = localPorperties
      return localProperties
    }
    return localProperties
  }
  
  
  // TODO: Navigation
  /*
  public func getNavigationProperties() -> [String: EdmNavigationProperty] {
    var localNavigationProperties = [String: EdmNavigationProperty]()
    guard let navigationProperties = navigationProperties else {
      if let structuredTypeNavigationProperties = providerStructuredType.navigationProperties {
        for (name, value) in structuredTypeNavigationProperties {
          localNavigationProperties[name] = EdmNavigationPropertyImpl(edm, value)
        }
      }
      
      // navigationProperties = localNavigationProperties
    }
    return localNavigationProperties
  }
 */
  
  
  }
