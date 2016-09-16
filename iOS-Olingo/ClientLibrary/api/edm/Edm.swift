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
//  Edm.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Entity Data Model (EDM)
/// Interface representing a Entity Data Model as described in the Conceptual Schema Definition.
public protocol Edm {
  
  var theRawXmlData: NSData? { get set }
  
  // MARK: - Protocol Properties
  
  // MARK: - Protocol Methods
  
  /// return all schemas defined for this EDM
  /// - parameters:
  ///   - none:
  /// - returns: Array of EdmSchemas
  /// - throws: No error conditions are expected
  func getSchemas() -> [EdmSchema]
  
  /// Get schema by namespace
  /// - parameters:
  ///   - namespace: namespace
  /// - returns: EdmSchema
  /// - throws: No error conditions are expected
  func getSchema(namespace:String) -> EdmSchema
  
  /// Get main entity container
  /// - parameters:
  ///   - none:
  /// - returns: EdmEntityContainer
  /// - throws: No error conditions are expected
  func getEntityContainer() -> EdmEntityContainer
  
  /// Get entity container by full qualified name
  /// - parameters:
  ///   - name: full qualified name of entity container
  /// - returns: EdmEntityContainer
  /// - throws: No error conditions are expected
  func getEntityContainer(name: FullQualifiedName ) -> EdmEntityContainer
  
  /// Get enum type by full qualified name
  /// - parameters:
  ///   - name: full qualified name of enum type
  /// - returns: EdmEnumType
  /// - throws: No error conditions are expected
  func getEnumType(name:FullQualifiedName ) -> EdmEnumType?
  
  /// Get a type definition by full qualified name
  /// - parameters:
  ///   - name: full qualified name of type definition
  /// - returns: EdmTypeDefinition
  /// - throws: No error conditions are expected
  func getTypeDefinition(name:FullQualifiedName ) -> EdmTypeDefinition?
  
  /// Get entity type by full qualified name
  /// - parameters:
  ///   - name: full qualified name of entity type
  /// - returns: EdmEntityType
  /// - throws: No error conditions are expected
   func getEntityType(name:FullQualifiedName ) -> EdmEntityType?
  
  /// Get complex type by full qualified name
  /// - parameters:
  ///   - name: full qualified name of complex type
  /// - returns: EdmComplexType
  /// - throws: No error conditions are expected
  func getComplexType(name:FullQualifiedName ) -> EdmComplexType?
  
  /// Get unbound Action by full qualified name
  /// - parameters:
  ///   - name: full qualified name of unbound Action
  /// - returns: EdmAction
  /// - throws: No error conditions are expected
  func  getUnboundAction(actionName:FullQualifiedName ) -> EdmAction
  
  /// Get Action by full qualified name and binding parameter type
  /// - parameters:
  ///   - actionName: full qualified name of action
  ///   - BindingParameterTypeName: full qualified name of binding parameter
  ///   - isBindingParameterCollection: flag for is collection
  /// - returns: EdmAction
  /// - throws: No error conditions are expected
  func getBoundAction(actionName:FullQualifiedName , bindingParameterTypeName:FullQualifiedName, isBindingParameterCollection:Bool) -> EdmAction
  
  /// Get function by full qualified name
  /// - parameters:
  ///   - name: full qualified name of function
  /// - returns: Array of EdmFunction
  /// - throws: No error conditions are expected
  func getUnboundFunctions(functionName:FullQualifiedName) -> [EdmFunction]
  
  /// Get function by full qualified name
  /// - parameters:
  ///   - name: full qualified name of function
  ///   - parameterNames: array of parameter names
  /// - returns: EdmFunction
  /// - throws: No error conditions are expected
  func getUnboundFunction(functionName:FullQualifiedName,parameterNames:[String]) -> EdmFunction
  
  /// Get Function by full qualified name and binding parameter type and binding parameter names
  /// - parameters:
  ///   - functionName: full qualified name of function
  ///   - bindingParameterTypeName: full qualified name of binding parameter
  ///   - isBindingParameterCollection: is a collection flag
  ///   - parameterNames: fArray of parameter names
  /// - returns: EdmFunction
  /// - throws: No error conditions are expected
  func getBoundFunction(functionName:FullQualifiedName,bindingParameterTypeName:FullQualifiedName,isBindingParameterCollection:Bool,  parameterNames:[String]) -> EdmFunction
  
  /// Get term by full qualified name
  /// - parameters:
  ///   - termName: full qualified name of term
  /// - returns: EdmTerm
  /// - throws: No error conditions are expected
  func getTerm(termName:FullQualifiedName ) -> EdmTerm
  
  // TODO: Annotations
  /// Get EdmAnnotations by target
  /// - parameters:
  ///   - targetName: full qualified name of EDM annotations target
  ///   - qualifier: qualifier for the target
  /// - returns: EdmAnnotations
  /// - throws: No error conditions are expected
   //func getAnnotationGroup(targetName:FullQualifiedName ,qualifier:String) -> EdmAnnotations
  
}
