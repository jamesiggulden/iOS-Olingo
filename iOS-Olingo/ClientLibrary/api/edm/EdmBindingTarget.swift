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

//  EdmBindingTarget.swift
//  iOS-Olingo
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.

import Foundation

// Entity Sets or Singletons can be bound to each other using a navigation property binding so an EdmBindingTarget can either be an {@link EdmEntitySet} or an {@link EdmSingleton}
public protocol EdmBindingTarget : EdmNamed, EdmMappable { // TODO: EdmAnnotatable,
  
  // MARK: - Protocol Methods
  
  // Returns a human readable title or null if not set.
  func getTitle() -> String
  
  // Returns the target for a given path.
  func getRelatedBindingTarget(path:String) -> EdmBindingTarget
  
  // return all navigation property bindings.
  func getNavigationPropertyBindings() -> [EdmNavigationPropertyBinding]

  // Returns the entity container this target is contained in.
  func getEntityContainer() -> EdmEntityContainer
  
  // Get the entity type.
  func getEntityType() -> EdmEntityType?
}
