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
  
  // MARK: - Protocol Properties
  
  // MARK: - Protocol Methods
  
  /// get parameter for given name
  /// - parameters:
  ///   - name: name of parameter
  /// - returns: EdmParameter for this name
  /// - throws: No error conditions are expected
  func getParameter(name:String) -> EdmParameter
  
  /// Get the list of all parameter names. If this is a bound action or function the first parameter name in the list is the binding parameter
  /// - parameters:
  ///   - none:
  /// - returns: list of all parameter names
  /// - throws: No error conditions are expected
  func getParameterNames() -> [String]
  
  /// get EdmEntitySet for the given binding parameters EntitySet
  /// - parameters:
  ///   - bindingParameterEntitySet: EntitySet of binding parameter
  /// - returns: EEdmEntitySet for this binding
  /// - throws: No error conditions are expected
  func getReturnedEntitySet(bindingParameterEntitySet:EdmEntitySet ) ->  EdmEntitySet
  
  /// get EdmReturnType of this operation
  /// - parameters:
  ///   - none:
  /// - returns: EdmReturnType of this operation
  /// - throws: No error conditions are expected
  func getReturnType() -> EdmReturnType
  
  /// return true if bound. For more information on bound operations please refer to the OData V4 specification.
  /// - parameters:
  ///   - none:
  /// - returns: true if bound
  /// - throws: No error conditions are expected
  func isBound() -> Bool
  
  /// get the fullqualified type name of the binding parameter
  /// - parameters:
  ///   - none:
  /// - returns: the fullqualified type name of the binding parameter
  /// - throws: No error conditions are expected
  func getBindingParameterTypeFqn() -> FullQualifiedName

  /// check if binding parameter is of type collection
  /// - parameters:
  ///   - none:
  /// - returns: true if binding parameter is of type collection
  /// - throws: No error conditions are expected
  func isBindingParameterTypeCollection() -> Bool
  
  /// get the entity set path as a String or null if not present
  /// - parameters:
  ///   - none:
  /// - returns: the entity set path as a String or null if not present
  /// - throws: No error conditions are expected
  func getEntitySetPath() -> String
  
}
