
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
//  EdmNavigationPropertyBinding.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// A navigation property binding which binds entity sets or singletons with each other
public protocol EdmNavigationPropertyBinding {
  
  // MARK: - Protocol Properties
  
  /// A path contains the full qualified name of the type it is referring to as a first segment. If it is a type nested inside another type the path is separated by forward slashes
  var path:String {get}
  /// return the entity set or singleton this binding refers to
  var target: String {get}
  
  // MARK: - Protocol Methods
  
}