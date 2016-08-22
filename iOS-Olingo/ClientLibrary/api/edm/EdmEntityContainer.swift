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
//  EdmEntityContainer.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

 /// A CSDL EntityContainer element.
 ///
 /// EdmEntityContainer hold the information of EntitySets, Singletons, ActionImports and FunctionImports contained
public protocol EdmEntityContainer: EdmNamed{ //TODO: , EdmAnnotatable
  
  /// namespace of this entity container
  var namespace: String {get}
  
  /// full qualified name of this entity container
  var fullQualifiedName: FullQualifiedName {get}

  /// returns all entity sets for this container.
  var entitySets: [EdmEntitySet] {get}
  
  /// returns all function imports for this container.
  var functionImports: [EdmFunctionImport] {get}
  
  /// returns all singletons for this container.
  var singletons: [EdmSingleton] {get}
  
  /// returns all action imports for this container.
  var actionImports: [EdmActionImport] {get}
  
  ///return the FullQualifiedName of the parentContainer or null if no parent is specified
  var parentContainerName: FullQualifiedName {get}
 
  /// Get contained Singleton by name
  /// - parameters:
  ///   - name: name of contained Singleton
  /// - returns: EdmSingleton
  /// - throws: No error conditions are expected
  func singleton(name:String) -> EdmSingleton
  
  /// Get contained EntitySet by name
  /// - parameters:
  ///   - name: name of contained EntitySet
  /// - returns: EdmEntitySet
  /// - throws: No error conditions are expected
  func entitySet(name:String) -> EdmEntitySet
  
  /// Get contained ActionImport by name
  /// - parameters:
  ///   - name: name of contained ActionImport
  /// - returns: EdmActionImport
  /// - throws: No error conditions are expected
  func actionImport(name:String) -> EdmActionImport
  
  /// Get contained FunctionImport by name
  /// - parameters:
  ///   - name: name of contained FunctionImport
  /// - returns: EdmFunctionImport
  /// - throws: No error conditions are expected
   func functionImport(name:String) -> EdmFunctionImport
  
 
}
