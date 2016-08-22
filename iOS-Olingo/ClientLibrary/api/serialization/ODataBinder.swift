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
//  ODataBinder.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public protocol ODataBinder {
  

  /// Gets an `EntitySet` from the given OData entity set
  /// - parameters:
  ///   - entitySet: OData entity set
  /// - returns: Entity collection object
  /// - throws: No error conditions are expected
  func getEntitySet(entitySet:ClientEntitySet) -> EntityCollection
  
  
  /// Gets an `Entity` from the given OData entity
  /// - parameters:
  ///   - entity: OData entity set
  /// - returns: Entity  object
  /// - throws: No error conditions are expected
  func getEntity(entity:ClientEntity ) -> Entity
  

  /// Gets an `link` from the given OData link
  /// - parameters:
  ///   - link: OData link
  /// - returns: Link object
  /// - throws: No error conditions are expected
  
  //TODO: Include when impl function available
  //func getLink(link:ClientLink ) -> Link
  

  /// Gets an `property` from the given OData property
  /// - parameters:
  ///   - property: OData proerpty
  /// - returns: Property object
  /// - throws: No error conditions are expected
  
  //TODO: Include when impl function available
  //func getProperty(property:ClientProperty ) -> Property
  

  /// Adds the given property to the given entity (current Olingo implementation
  /// - parameters:
  ///   - entity: OData entity
  ///   - property: OData property
  /// - returns: `True` if added, false otherwise
  /// - throws: No error conditions are expected
  func addProperty(inout entity:ClientEntity , property:ClientProperty ) -> Bool
  
  /// Add a property to the client entity (alternative)
  /// This modifies the entity parameter
  /// - parameters:
  ///   - entity: **non modifiable** client entity
  ///   - property: client property to be added
  /// - returns: updated client entity
  /// - throws: No error conditions are expected
  func addProperty(entity:ClientEntity , property:ClientProperty ) -> ClientEntity
  
  /// Add an entity to the client entity set (this is the current Olingo implmentation)
  /// This modifies the entityset parameter
  /// - parameters:
  ///   - entityset: **modifiable** client entityset
  ///   - entity: client entity to be added
  /// - returns: true
  /// - throws: No error conditions are expected
  func add(inout entitySet:ClientEntitySet, entity:ClientEntity ) -> Bool
  
  /// Add an entity to the client entityset (alternative)
  /// This returns an updated entityset
  /// - parameters:
  ///   - entityset: **non modifiable** client entityset
  ///   - entity: client entity to be added
  /// - returns: updated client entityset
  /// - throws: No error conditions are expected
  func add(entitySet:ClientEntitySet, entity:ClientEntity ) -> ClientEntitySet
  
  /// Gets `ODataServiceDocument` from the given service document resource
  /// - parameters:
  ///   - resource: service document resource
  /// - returns: `ODataServiceDocument` object
  /// - throws: No error conditions are expected
  
  //TODO: Include when impl function available
  // func getODataServiceDocument(resource:ServiceDocument ) -> ClientServiceDocument
  

  /// Gets `ODataEntitySet` from the given entityset resource
  /// - parameters:
  ///   - resource: entity set resource
  /// - returns: `ClientEntitySet` object
  /// - throws: No error conditions are expected
  func getODataEntitySet( resource:ResWrap<EntityCollection>) -> ClientEntitySet
  

  /// Gets `ODataEntity` from the given entity resource
  /// - parameters:
  ///   - resource: entity resource
  /// - returns: `ClientEntity` object
  /// - throws: No error conditions are expected
  func getODataEntity(resource:ResWrap<Entity> ) throws -> ClientEntity
  

  /// Gets `ODataProperty` from the given property resource
  /// - parameters:
  ///   - resource: property resource
  /// - returns: `ODataProperty` object
  /// - throws: No error conditions are expected
  
  //TODO: Include when impl function available
  // func getODataProperty( resource:ResWrap<Property>) -> ClientProperty
  
  /// Gets `ODataDelta` from the given delta resource
  /// - parameters:
  ///   - resource: delta resource
  /// - returns: `ODataDelta` object
  /// - throws: No error conditions are expected
  
  //TODO: Include when impl function available
  // func getODataDelta(resource:ResWrap<Delta> ) -> ClientDelta
}
