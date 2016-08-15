/*
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with this work for additional information
  regarding copyright ownership.  The ASF licenses this file
  to you under the Apache License, Version 2.0 (the
  "License") you may not use this file except in compliance
  with the License.  You may obtain a copy of the License at
 
    http -> //www.apache.org/licenses/LICENSE-2.0
 
  Unless required by applicable law or agreed to in writing,
  software distributed under the License is distributed on an
  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  KIND, either express or implied.  See the License for the
  specific language governing permissions and limitations
  under the License.
 */
 


//
//  File.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


 /// A csdl schema element
 
public protocol EdmSchema { // TODO ->  extends EdmAnnotatable {
  
  
   /// get the namespace for this schema
   
  func getNamespace() -> String
  
  
   /// get the alias for this schema. May be null.
   
  func getAlias() -> String
  
  
   /// get all enum types for this schema
   
  func getEnumTypes() -> [EdmEnumType]
  
  
   /// get all entity types for this schema
   
  func getEntityTypes() -> [EdmEntityType]
  
  
   /// get all complex types for this schema
   
  func getComplexTypes() -> [EdmComplexType]
  
  
   /// get all actions for this schema
   
  func getActions() -> [EdmAction]
  
  
   /// get all functions for this schema
   
  func getFunctions() -> [EdmFunction]
  
  
   /// get all {@link EdmTypeDefinition} for this schema.
   
  func getTypeDefinitions() -> [EdmTypeDefinition]
  
  
   /// get all {@link EdmTerm} for this schema.
   
  func getTerms() -> [EdmTerm]
  
  
   /// get all {@link EdmAnnotations} for this schema.
  // TODO: Annotations
  //func getAnnotationGroups() -> [EdmAnnotations]
  
  
   /// get the entity container for this schema. May be null.
   
  func getEntityContainer() -> EdmEntityContainer
  
  /// Get the navigation properties for this schema
  /// - parameters:
  ///   - none
  /// - returns: Dict of key: entity type name and value: list of navigation properties
  /// - throws: No error conditions are expected
  func getNavigationProperties() -> [String: [EdmNavigationProperty]]
  
}

