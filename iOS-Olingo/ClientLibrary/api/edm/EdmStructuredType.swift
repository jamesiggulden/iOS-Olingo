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
//  EdmStructuredType.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// EdmStructuralType is the base for a complex type or an entity type.
/// Complex types and entity types are described in the Conceptual Schema Definition of the OData protocol.
public protocol EdmStructuredType: EdmType {  // TODO: EdmAnnotatable {
  
  // MARK: - Protocol Properties
  
  // Base types are described in the OData protocol specification.
  var baseType: EdmStructuredType? {get}
  
  // Get all simple and complex property names.
  var propertyNames:[String] {get}
  
  // Indicates if the structured type is an open type.
  var isOpenType: Bool {get}
  
  // Indicates if the structured type is abstract.
  var isAbstract: Bool {get}
  
  // The Navigation Properties
  var theNavigationProperties: [EdmNavigationProperty]? { get set }
  
  // MARK: - Protocol Methods
  
  /// Get all navigation property names.
  // TODO:  var navigationPropertyNames:[String] {get}
  //var navigationPropertyNames:[String] {get}
 
  /// get property with the provided name
  /// - parameters:
  ///   - name: name of property to find and return
  /// - returns: property if found nil otherwise
  /// - throws: No error conditions are expected
  func getProperty(name:String) -> EdmElement?
  
  /// get  structural property with the provided name
  /// - parameters:
  ///   - name: name of  structural property to find and return
  /// - returns: Edmproperty if found nil otherwise
  /// - throws: No error conditions are expected
  func getStructuralProperty(name:String) ->  EdmProperty?
  
  // TODO: getNavigationProperty(name:String) -> EdmNavigationProperty?
  /// get navigation property with the provided name
  /// - parameters:
  ///   - name: name of navigation property to find and return
  /// - returns: EDM navigation property if found nil otherwise
  /// - throws: No error conditions are expected
  //func getNavigationProperty(name:String) -> EdmNavigationProperty?
  
  /// Checks if this type is convertible to parameter targetType
  /// - parameters:
  ///   - targetType: target type for which compatibility is checked
  /// - returns: true if this type is compatible to the testType (i.e., this type is a subtype of targetType)
  /// - throws: No error conditions are expected
  func compatibleTo(targetType:EdmType?) throws -> Bool
  
}
