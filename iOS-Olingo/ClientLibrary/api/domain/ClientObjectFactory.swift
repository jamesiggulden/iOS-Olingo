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


//
//  ClientObjectFactory.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 13/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public protocol ClientObjectFactory {
  
  
  func newEntitySet() ->  ClientEntitySet
  
  func newEntitySet(next:NSURL) ->  ClientEntitySet
  
  func newEntity(typeName:FullQualifiedName ) ->  ClientEntity
  
  func newEntity(typeName:FullQualifiedName , link:NSURL) ->  ClientEntity
  
  func newPrimitiveValueBuilder() ->  ClientPrimitiveValueBuilder
  
  func newEnumValue(typeName:String, value:String) ->  ClientEnumValue
  
  func newComplexValue(typeName:String) ->  ClientComplexValue
  
  func newCollectionValue<T:ClientValue>(typeName:String) ->  T
  
  func newPrimitiveProperty(name:String, value:ClientPrimitiveValue ) ->  ClientProperty
  
  func newComplexProperty(name:String,value:ClientComplexValue ) ->  ClientProperty
  
  func newCollectionProperty(name:String, value:ClientCollectionValue) -> ClientProperty
  
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