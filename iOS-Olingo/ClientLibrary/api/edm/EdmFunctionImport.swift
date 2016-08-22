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
//  EdmFunctionImport.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// A CSDL FunctionImport element
public protocol EdmFunctionImport : EdmOperationImport {
  
  /// Gets unbound functions
  var unboundFunctions:[EdmFunction] {get}
  
  /// return the Full qualified name for the function as specified in the metadata
  var functionFqn: FullQualifiedName {get}
  
  /// Returns a human readable title or null if not set
  var title: String {get}
  
  /// return true if the function import must be included in the service document
  var isIncludeInServiceDocument: Bool {get}

  /// Gets unbound function with given parameter names
  /// - parameters:
  ///   - parameterNames: parameter names
  /// - returns: unbound function with given parameter names
  /// - throws: No error conditions are expected
  func getUnboundFunction(parameterNames:[String]) -> EdmFunction
  

  
}

