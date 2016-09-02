/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import Foundation

//  AbstractEdmBindingTarget.swift
//  Created by EnergySys on 28/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.

public class AbstractEdmBindingTarget: AbstractEdmNamed, EdmBindingTarget {
  
  // MARK: - Stored Properties
  private let theTarget: CsdlBindingTarget
  private let theContainer: EdmEntityContainer
  public var mapping: EdmMapping?
  
  // MARK: - Init
  public init(anEdm: Edm, aContainer: EdmEntityContainer, aTarget: CsdlBindingTarget) {
    theContainer = aContainer
    theTarget = aTarget
    super.init(edm: anEdm, name: aTarget.getName(), annotatable: aTarget)
  }
  
  // MARK: - Methods
  // Returns the target for a given path
  public func getRelatedBindingTarget(path:String) -> EdmBindingTarget {
    fatalError("Unsupported Operation")
  }
  
  // Returns the associated title
  public func getTitle() -> String {
    return theTarget.getTitle()
  }
  
  // Return all navigation property bindings
  public func getNavigationPropertyBindings() -> [EdmNavigationPropertyBinding] {
    fatalError("Unsupported Operation")
  }
  
  // Returns the entity container this target is contained in
  public func getEntityContainer() -> EdmEntityContainer {
    return theContainer
  }
  
  // Get the entity type
  public func getEntityType() -> EdmEntityType? {
    fatalError("Unsupported Operation")
  }
  
}