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
//  Edm.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * Entity Data Model (EDM)
 * <br/>
 * Interface representing a Entity Data Model as described in the Conceptual Schema Definition.
 */
public protocol Edm {
  
  var theRawXmlData: NSData? { get set }
  
  /**
   * This method <b>DOES NOT</b> support lazy loading. All schemas are loaded completely!
   *
   * @return all schemas defined for this EDM
   */
  func getSchemas() -> [EdmSchema]
  
  /**
   * Get schema by namespace.
   *
   * @param namespace must not be null
   * @return {@link EdmSchema}
   */
  func getSchema(namespace:String) -> EdmSchema
  
  /**
   * Get main entity container.
   * <br/>
   * See {@link EdmEntityContainer} for more information.
   *
   * @return {@link EdmEntityContainer}
   */
   func getEntityContainer() -> EdmEntityContainer
  
  /**
   * Get entity container by full qualified name.
   * <br/>
   * See {@link EdmEntityContainer} for more information.
   *
   * @param name full qualified name of entity container
   * @return {@link EdmEntityContainer}
   */
   func getEntityContainer(name: FullQualifiedName ) -> EdmEntityContainer
  
  /**
   * Get enum type by full qualified name.
   * <br/>
   * See {@link EdmEnumType} for more information
   *
   * @param name full qualified name of enum type
   * @return {@link EdmEnumType}
   */
   func getEnumType(name:FullQualifiedName ) -> EdmEnumType?
  
  /**
   * Get a type definition by full qualified name.
   * <br/>
   * See {@link EdmTypeDefinition} for more information
   *
   * @param name full qualified name of type definition
   * @return {@link EdmTypeDefinition}
   */
   func getTypeDefinition(name:FullQualifiedName ) -> EdmTypeDefinition?
  
  /**
   * Get entity type by full qualified name.
   * <br/>
   * See {@link EdmEntityType} for more information.
   *
   * @param name full qualified name of entity type
   * @return {@link EdmEntityType}
   */
   func getEntityType(name:FullQualifiedName ) -> EdmEntityType?
  
  /**
   * Get complex type by full qualified name..
   * <br/>
   * See {@link EdmComplexType} for more information.
   *
   * @param name full qualified name of complex type
   * @return {@link EdmComplexType}
   */
  func getComplexType(name:FullQualifiedName ) -> EdmComplexType?
  
  /**
   * Get unbound Action by full qualified name.
   *
   * @param actionName must not be null
   * @return {@link EdmAction}
   */
  func  getUnboundAction(actionName:FullQualifiedName ) -> EdmAction
  
  /**
   * Get Action by full qualified name and binding parameter type.
   *
   * @param actionName must not be null
   * @param bindingParameterTypeName must not be null
   * @param isBindingParameterCollection may be null
   * @return {@link EdmAction}
   */
  func getBoundAction(actionName:FullQualifiedName , bindingParameterTypeName:FullQualifiedName, isBindingParameterCollection:Bool) -> EdmAction
  
  /**
   * Get Function by full qualified name.
   *
   * @param functionName must not be null
   * @return {@link EdmFunction}
   */
  func getUnboundFunctions(functionName:FullQualifiedName) -> [EdmFunction]
  
  /**
   * Get Function by full qualified name.
   *
   * @param functionName must not be null
   * @param parameterNames may be null: in this case it is considered as empty
   * @return {@link EdmFunction}
   */
  func getUnboundFunction(functionName:FullQualifiedName,parameterNames:[String]) -> EdmFunction
  
  /**
   * Get Function by full qualified name and binding parameter type and binding parameter names.
   *
   * @param functionName must not be null
   * @param bindingParameterTypeName must not be null
   * @param isBindingParameterCollection may be null
   * @param parameterNames may be null: in this case it is considered as empty
   * @return {@link EdmFunction}
   */
  func getBoundFunction(functionName:FullQualifiedName,bindingParameterTypeName:FullQualifiedName,isBindingParameterCollection:Bool,  parameterNames:[String]) -> EdmFunction
  
  /**
   * Get Term full by qualified name.
   *
   * @param termName must not be null
   * @return {@link EdmTerm}
   */
  func getTerm(termName:FullQualifiedName ) -> EdmTerm
  
  /**
   * Get {@link EdmAnnotations} by target.
   *
   * @param targetName <tt>edm:Annotations</tt> target
   * @param qualifier for the target. Can be <code>NULL</code>
   * @return {@link EdmAnnotations}
   */
  // TODO: Annotations
   //func getAnnotationGroup(targetName:FullQualifiedName ,qualifier:String) -> EdmAnnotations
  
}
