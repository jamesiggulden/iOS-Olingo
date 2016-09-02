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

// The EdmEntitySetImpl.
// Created by EnergySys on 28/07/2016.
// Copyright © 2016 EnergySys. All rights reserved.

public class EdmEntitySetImpl: AbstractEdmBindingTarget, EdmEntitySet {
  
  // MARK: - Properties
  public var entitySet: CsdlEntitySet
  public var isIncludeInServiceDocument: Bool
  
  // MARK: - Init
  public init (anEdm: Edm, aContainer: EdmEntityContainer, anEntitySet: CsdlEntitySet) {
    entitySet = anEntitySet
    isIncludeInServiceDocument = false
    super.init(anEdm: anEdm, aContainer: aContainer, aTarget: anEntitySet)
  }
  
  // MARK: - Methods
  // Returns the entity type for this entity set.
  public override func getEntityType() -> EdmEntityType? {
    return edm.getEntityType(entitySet.type)
  }
  
  // Returns the navigation property bindings - can be empty.
  public override func getNavigationPropertyBindings() -> [EdmNavigationPropertyBinding] {
    var myNavPropertyBindings = [EdmNavigationPropertyBinding]()
    for myCsdlNavPropBinding in entitySet.navigationPropertyBindings {
      let myNavPropBinding = EdmNavigationPropertyBindingImpl(aPath: myCsdlNavPropBinding.thePath, aTarget: myCsdlNavPropBinding.theTarget)
      myNavPropertyBindings.append(myNavPropBinding)
    }
    return myNavPropertyBindings
  }
  
}
