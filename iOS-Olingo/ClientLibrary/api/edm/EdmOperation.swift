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
//  EdmOperation.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * A EdmOperation can either be an {@link EdmAction} or an {@link EdmFunction}.
 */
public protocol EdmOperation : EdmType  {  // TODO: EdmAnnotatable {
  
  /**
   * func get parameter for given name
   * @param name name of parameter
   * @return {@link EdmParameter} for this name
   */
  func getParameter(name:String) -> EdmParameter
  
  /**
   * A list of all parameter names. If this is a bound action or function the first parameter name in the list is the
   * binding parameter
   * @return a list of all parameter names
   */
  func getParameterNames() -> [String]
  
  /**
   * func get EdmEntitySet for the given binding parameters EntitySet
   *
   * @param bindingParameterEntitySet EntitySet of binding parameter
   * @return {@link EdmEntitySet} for this binding
   */
  func getReturnedEntitySet(bindingParameterEntitySet:EdmEntitySet ) ->  EdmEntitySet
  
  /**
   * @return {@link EdmReturnType} of this operation
   */
  func getReturnType() -> EdmReturnType
  
  /**
   * For more information on bound operations please refer to the OData V4 specification.
   *
   * @return true if bound
   */
  func isBound() -> Bool
  
  /**
   * @return the fullqualified type name of the binding parameter
   */
  func getBindingParameterTypeFqn() -> FullQualifiedName
  
  /**
   * @return true if binding parameter is of type collection.
   */
  func isBindingParameterTypeCollection() -> Bool
  
  /**
   * @return the entity set path as a String or null if not present
   */
  func getEntitySetPath() -> String
  
}
