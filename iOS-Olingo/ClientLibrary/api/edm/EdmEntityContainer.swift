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

//  EdmEntityContainer.swift
//  iOS-Olingo
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.

import Foundation

// A CSDL EntityContainer element.
// EdmEntityContainer hold the information of EntitySets, Singletons, ActionImports and FunctionImports contained
public protocol EdmEntityContainer: EdmNamed{ //TODO: , EdmAnnotatable

  // MARK: - Properties
  // Return namespace of this entity container.
  var namespace: String? {get}
  
  // Return full qualified name of this entity container.
  var fullQualifiedName: FullQualifiedName? {get}
  
  var entitySets: [EdmEntitySet]? {get}
  var functionImports: [EdmFunctionImport]? {get}
  var singletons: [EdmSingleton]? {get}
  var actionImports: [EdmActionImport]? {get}
  var parentContainerName: FullQualifiedName? {get}
  
  // MARK: - Methods
  // Get contained Singleton by name.
  func singleton(name:String) -> EdmSingleton
  
  // Get contained EntitySet by name.
  func entitySet(name:String) -> EdmEntitySet
  
  // Get contained ActionImport by name.
  func actionImport(name:String) -> EdmActionImport
  
  // Get contained FunctionImport by name.
  func functionImport(name:String) -> EdmFunctionImport
  
}
