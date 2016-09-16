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
//  ClientObjectFactory.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 13/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public protocol ClientObjectFactory {
  
  // MARK: - Protocol Properties
  
  // MARK: - Protocol Methods
  
  /// Create new entity set
  /// - parameters:
  ///   - none:
  /// - returns: ClientEntitySet
  /// - throws: No error conditions are expected
  func newEntitySet() ->  ClientEntitySet
  
  /// Create new entity set
  /// - parameters:
  ///   - next: URL of an entityset
  /// - returns: ClientEntitySet
  /// - throws: No error conditions are expected
  func newEntitySet(next:NSURL) ->  ClientEntitySet
  
  /// Create new entity for specified type name
  /// - parameters:
  ///   - typeName: type name
  /// - returns: ClientEntity
  /// - throws: No error conditions are expected
  func newEntity(typeName:FullQualifiedName ) ->  ClientEntity
  
  /// Create new entity for specified type name with link
  /// - parameters:
  ///   - typeName: type name
  ///   - link: URL link
  /// - returns: ClientEntity
  /// - throws: No error conditions are expected
  func newEntity(typeName:FullQualifiedName , link:NSURL) ->  ClientEntity
  
  /// Create new primitive value builder
  /// - parameters:
  ///   - none:
  /// - returns: ClientPrimitiveValueBuilder
  /// - throws: No error conditions are expected
  func newPrimitiveValueBuilder() ->  ClientPrimitiveValueBuilder
  
  /// Create new enum value
  /// - parameters:
  ///   - typeName: type name
  ///   - value: value
  /// - returns: ClientEnumValue
  /// - throws: No error conditions are expected
  func newEnumValue(typeName:String, value:String) ->  ClientEnumValue
  
  
  /// Create new complex value
  /// - parameters:
  ///   - typeName: type name
  /// - returns: ClientComplexValue
  /// - throws: No error conditions are expected
  func newComplexValue(typeName:String) ->  ClientComplexValue
  
  /// Create new collection value of type T
  /// - parameters:
  ///   - typeName: type name
  /// - returns: T that conforms to protocol ClientValue
  /// - throws: No error conditions are expected
  func newCollectionValue<T:ClientValue>(typeName:String) ->  T
  
  /// Create new primitive property
  /// - parameters:
  ///   - name: name of property
  ///   - value: value of property
  /// - returns: ClientProperty
  /// - throws: No error conditions are expected
  func newPrimitiveProperty(name:String, value:ClientPrimitiveValue ) ->  ClientProperty
  
  /// Create new complex property
  /// - parameters:
  ///   - name: name of property
  ///   - value: value of property
  /// - returns: ClientProperty
  /// - throws: No error conditions are expected
  func newComplexProperty(name:String,value:ClientComplexValue ) ->  ClientProperty
  
  /// Create new collection property
  /// - parameters:
  ///   - name: name of property
  ///   - value: value of property
  /// - returns: ClientProperty
  /// - throws: No error conditions are expected
  func newCollectionProperty(name:String, value:ClientCollectionValue) -> ClientProperty
  
  /// Create new enum property
  /// - parameters:
  ///   - name: name of property
  ///   - value: value of property
  /// - returns: ClientProperty
  /// - throws: No error conditions are expected
  func newEnumProperty(name:String, value:ClientEnumValue) ->  ClientProperty
  
  
  // TODO: Singleton
  /*
   func newSingleton(typeName:FullQualifiedName ) ->  ClientSingleton
   */
  
  // TODO: Links
  /*
   func newEntityNavigationLink(name:String, link:NSURL) ->  ClientLink
   func newEntitySetNavigationLink(name:String, link:NSURL) ->  ClientLink
   func newAssociationLink(name:String, link:NSURL) ->  ClientLink
   func newMediaEditLink(name:String, link:NSURL) ->  ClientLink
   */
  
  // TODO: Delta
  /*
   func newDelta() ->  ClientDelta
   func newDelta(next:NSURL) -> ClientDelta
   */
  
  // TODO: InLine
  /*
   func newDeepInsertEntitySet(name:String, entitySet:ClientEntitySet) -> ClientInlineEntitySet
   func newDeepInsertEntity(name:String:String , final ClientEntity entity) -> ClientInlineEntity
   */
}