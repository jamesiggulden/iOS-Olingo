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
//  EdmMapping.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// EdmMapping holds custom mapping information which can be applied to a CSDL element
public protocol EdmMapping {
  
  // MARK: - Protocol Properties
  
  /// Returns the internal name for this mapped object. This name won`t be used by the Olingo library but can be used by applications to access their database easier.
  var internalName: String {get}
  /// The class which is returned here will be used to during deserialization to replace the default swift class for a primitive type.
  var mappedSwiftClass: AnyClass {get}
  
  // MARK: - Protocol Methods
}
