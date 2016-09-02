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

// The type Csdl binding target.
// Created by EnergySys on 28/07/2016.
// Copyright © 2016 EnergySys. All rights reserved.

public class CsdlBindingTarget: CsdlAbstractEdmItem, CsdlNamed, CsdlAnnotatable {
  
  // MARK: - Properties
  // The Name.
  public var name: String
  
  // The human readable title.
  public var title: String
  
  // The Type.
  public var type: FullQualifiedName
  
  // The Navigation property bindings.
  public var navigationPropertyBindings = [CsdlNavigationPropertyBinding]()
  
  //var annotations = [CsdlAnnotation]()
  // Mapping for server use cases
  // public var mapping: CsdlMapping
  
  // MARK: - Init
  public init(aName: String, aTitle: String, aType: FullQualifiedName){
    name = aName
    title = aTitle
    type = aType
    super.init()
  }
  
  // MARK: - Methods
  // Get the name
  public func getName() -> String {
    return name
  }
  
  // Sets name.
  public func setName(aName: String) -> CsdlBindingTarget {
    name = aName
    return self
  }
  
  // Gets type.
  public func getType() -> String {
    return type.fqn
  }
  
  // Gets type fQN.
  public func getTypeFQN() -> FullQualifiedName {
    return type
  }
  
  // Sets type.
  public func setType(aType: String) -> CsdlBindingTarget {
    do {
     type = try FullQualifiedName(namespaceAndName: aType)!
    }
    catch {
      log.error("Failed to set type for: " + aType)
    }
    return self
  }
  
  // Sets type.
  public func setType(aType: FullQualifiedName) -> CsdlBindingTarget {
    type = aType
    return self
  }
  
  /**
   * Gets navigation property bindings.
   *
   * @return the navigation property bindings
   */
  /**
  public func getNavigationPropertyBindings() -> [CsdlNavigationPropertyBinding] {
    return navigationPropertyBindings
  }
   */
  
  /**
   * Sets navigation property bindings.
   *
   * @param navigationPropertyBindings the navigation property bindings
   * @return the navigation property bindings
   */
  /**
  public func setNavigationPropertyBindings(someNavigationPropertyBindings: [CsdlNavigationPropertyBinding]) -> CsdlBindingTarget {
    navigationPropertyBindings = someNavigationPropertyBindings
    return self
  }
 */
  
  /**
  public func getAnnotations() -> [CsdlAnnotation] {
    return annotations
  }
 */
  
  /**
   * Sets a list of annotations
   * @param annotations list of annotations
   * @return this instance
   */
  /**
  public func setAnnotations(someAnnotations: [CsdlAnnotation]) -> CsdlBindingTarget {
    this.annotations = someAnnotations
    return self
  }
 */
  
  // Getter for title value.
  public func getTitle() -> String {
    return title
  }
  
  // Sets a human readable title for this instance.
  public func setTitle(aTitle: String) -> CsdlBindingTarget {
    title = aTitle
    return self
  }
  
  /**
  public func getMapping() -> CsdlMapping {
    return mapping
  }
   */
  
  /**
   * Sets the mapping object for this binding target.
   * @param mapping
   * @return this instance
   */
  /**
  public func setMapping(aMapping: CsdlMapping) -> CsdlBindingTarget {
    mapping = aMapping
    return self
  }
   */
}
