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

// The EdmEntityContainerImpl.
// Created by EnergySys on 28/07/2016.
// Copyright © 2016 EnergySys. All rights reserved.

public class EdmEntityContainerImpl: AbstractEdmNamed, EdmEntityContainer {
  
  // MARK: - Properties
  public var namespace: String?
  public var fullQualifiedName: FullQualifiedName?
  public var entitySets: [EdmEntitySet]?
  public var functionImports: [EdmFunctionImport]?
  public var singletons: [EdmSingleton]?
  public var actionImports: [EdmActionImport]?
  public var parentContainerName: FullQualifiedName?
  
  // MARK: - Init
  init(anEdm: Edm, aName: String) {
    super.init(edm: anEdm, name: aName, annotatable: nil)
  }
  
  init(aNamespace: String, aName: String, anEdm: Edm, anAnnotatable: CsdlAnnotatable, someEntitySets: [EdmEntitySet], someFunctionImports: [EdmFunctionImport], someSingletons: [EdmSingleton], someActionImports: [EdmActionImport], aParentContainerName: FullQualifiedName) {
    namespace = aNamespace
    fullQualifiedName = FullQualifiedName(namespace: aNamespace, name: aName)
    entitySets = someEntitySets
    functionImports = someFunctionImports
    singletons = someSingletons
    actionImports = someActionImports
    parentContainerName = aParentContainerName
    super.init(edm: anEdm, name: aName, annotatable: anAnnotatable)
  }
  
  // MARK: - Methods
  // Get the namespace as String.
  public func getNamespace() -> String {
    return namespace!
  }
  
  // Get the singleton for this class.
  public func singleton(name:String) -> EdmSingleton {
    fatalError("Unsupported Operation")
  }
  
  // Get the entity set with name.
  public func entitySet(name:String) -> EdmEntitySet {
    fatalError("Unsupported Operation")
  }
  
  // Get the action import with name.
  public func functionImport(name:String) -> EdmFunctionImport {
    fatalError("Unsupported Operation")
  }
  
  // Get the action import with name.
  public func actionImport(name:String) -> EdmActionImport {
    fatalError("Unsupported Operation")
  }
  
  // Get the parent entity container name.
  public func getParentContainerName() -> FullQualifiedName {
    return parentContainerName!
  }
  
}
