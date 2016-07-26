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
  
  /**
   * @return namespace of this entity container
   */
  var namespace: String {get}
  
  /**
   * @return full qualified name of this entity container
   */
  var fullQualifiedName: FullQualifiedName {get}
  
  /**
   * Get contained Singleton by name.
   *
   * @param name name of contained Singleton
   * @return {@link EdmSingleton}
   */
  func singleton(name:String) -> EdmSingleton
  
  /**
   * Get contained EntitySet by name.
   *
   * @param name name of contained EntitySet
   * @return {@link EdmEntitySet}
   */
  func entitySet(name:String) -> EdmEntitySet
  
  /**
   * Get contained ActionImport by name.
   *
   * @param name name of contained ActionImport
   * @return {@link EdmActionImport}
   */
  func actionImport(name:String) -> EdmActionImport
  
  /**
   * Get contained FunctionImport by name.
   *
   * @param name name of contained FunctionImport
   * @return {@link EdmFunctionImport}
   */
   func functionImport(name:String) -> EdmFunctionImport
  
  /**
   * This method <b>DOES NOT</b> support lazy loading
   *
   * @return returns all entity sets for this container.
   */
  var entitySets: [EdmEntitySet] {get}
  
  /**
   * This method <b>DOES NOT</b> support lazy loading
   *
   * @return returns all function imports for this container.
   */
  var functionImports: [EdmFunctionImport] {get}
  
  /**
   * This method <b>DOES NOT</b> support lazy loading
   *
   * @return returns all singletons for this container.
   */
  var singletons: [EdmSingleton] {get}
  
  /**
   * This method <b>DOES NOT</b> support lazy loading
   *
   * @return returns all action imports for this container.
   */
  var actionImports: [EdmActionImport] {get}
  
  /**
   * @return the {@link FullQualifiedName} of the parentContainer or null if no parent is specified
   */
  var parentContainerName: FullQualifiedName {get}
}
