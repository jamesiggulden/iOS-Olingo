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
//  ClientObjectFactoryImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 13/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class ClientObjectFactoryImpl : ClientObjectFactory {
  
  // MARK: - Stored Properties


  // MARK: - Computed Properties

  
  // MARK: - Init
  
  
  // MARK: - Methods
   
  /// Create new entity set
  /// - parameters:
  ///   - none:
  /// - returns: ClientEntitySet
  /// - throws: No error conditions are expected
  public func newEntitySet() ->  ClientEntitySet  {
    return ClientEntitySetImpl()
  }
  
  /// Create new entity set
  /// - parameters:
  ///   - next: URL of an entityset
  /// - returns: ClientEntitySet
  /// - throws: No error conditions are expected
  public func newEntitySet(next:NSURL) ->  ClientEntitySet {
    return ClientEntitySetImpl(next: next)
  }
  
  /// Create new entity for specified type name
  /// - parameters:
  ///   - typeName: type name
  /// - returns: ClientEntity
  /// - throws: No error conditions are expected
  public func newEntity(typeName:FullQualifiedName ) ->  ClientEntity  {
    return ClientEntityImpl(typeName: typeName)
  }
  
  /// Create new entity for specified type name with link
  /// - parameters:
  ///   - typeName: type name
  ///   - link: URL link
  /// - returns: ClientEntity
  /// - throws: No error conditions are expected
  public func newEntity(typeName:FullQualifiedName , link:NSURL) ->  ClientEntity {
    let result = ClientEntityImpl(typeName: typeName)
    result.link = link
    return result
  }
  
  /// Create new primitive value builder
  /// - parameters:
  ///   - none:
  /// - returns: ClientPrimitiveValueBuilder
  /// - throws: No error conditions are expected
  public func newPrimitiveValueBuilder() ->  ClientPrimitiveValueBuilder  {
    return ClientPrimitiveValueBuilderImpl()
  }
  
  /// Create new enum value
  /// - parameters:
  ///   - typeName: type name
  ///   - value: value
  /// - returns: ClientEnumValue
  /// - throws: No error conditions are expected
  public func newEnumValue(typeName:String, value:String) ->  ClientEnumValue  {
    return ClientEnumValueImpl(typeName: typeName, value: value)
  }
  
  /// Create new complex value
  /// - parameters:
  ///   - typeName: type name
  /// - returns: ClientComplexValue
  /// - throws: No error conditions are expected
  public func newComplexValue(typeName:String) ->  ClientComplexValue  {
    return ClientComplexValueImpl(typeName: typeName)
  }
  
  /// Create new collection value of type T
  /// - parameters:
  ///   - typeName: type name
  /// - returns: T that conforms to protocol ClientValue
  /// - throws: No error conditions are expected
  public func newCollectionValue<T:ClientValue>(typeName:String) ->  T  {
    return ClientCollectionValueImpl<T>(typeName: typeName) as! T
  }
  
  /// Create new primitive property
  /// - parameters:
  ///   - name: name of property
  ///   - value: value of property
  /// - returns: ClientProperty
  /// - throws: No error conditions are expected
  public func newPrimitiveProperty(name:String, value:ClientPrimitiveValue ) ->  ClientProperty  {
    return ClientPropertyImpl(name: name, value: value)
  }
  
  /// Create new complex property
  /// - parameters:
  ///   - name: name of property
  ///   - value: value of property
  /// - returns: ClientProperty
  /// - throws: No error conditions are expected
  public func newComplexProperty(name:String,value:ClientComplexValue ) ->  ClientProperty {
    return ClientPropertyImpl(name: name, value: value)
  }
  
  /// Create new collection property
  /// - parameters:
  ///   - name: name of property
  ///   - value: value of property
  /// - returns: ClientProperty
  /// - throws: No error conditions are expected
  public func newCollectionProperty(name:String, value:ClientCollectionValue) -> ClientProperty  {
    return ClientPropertyImpl(name: name, value: value)
  }
  
  /// Create new enum property
  /// - parameters:
  ///   - name: name of property
  ///   - value: value of property
  /// - returns: ClientProperty
  /// - throws: No error conditions are expected
  public func newEnumProperty(name:String, value:ClientEnumValue) ->  ClientProperty  {
    return ClientPropertyImpl(name: name, value: value)
  }
  
  // TODO: Singleton
  /*
   public func newSingleton(typeName:FullQualifiedName ) ->  ClientSingleton {
   return ClientEntityImpl(typeName)
   }
   */
  
  // TODO: Links
  /*
   
   public func newEntityNavigationLink(name:String, link:NSURL) ->  ClientLink  {
   return ClientLink.Builder().setURI(link).
   setType(ClientLinkType.ENTITY_NAVIGATION).setTitle(name).build()
   }
   
   
   public func newEntitySetNavigationLink(name:String, link:NSURL) ->  ClientLink  {
   return ClientLink.Builder().setURI(link).
   setType(ClientLinkType.ENTITY_SET_NAVIGATION).setTitle(name).build()
   }
   
   
   public func newAssociationLink(name:String, link:NSURL) ->  ClientLink {
   return ClientLink.Builder().setURI(link).
   setType(ClientLinkType.ASSOCIATION).setTitle(name).build()
   }
   
   
   public func newMediaEditLink(name:String, link:NSURL) ->  ClientLink  {
   return ClientLink.Builder().setURI(link).setType(ClientLinkType.MEDIA_EDIT).setTitle(name).build()
   }
   */
  
  // TODO: Delta
  /*
  public func newDelta() ->  ClientDelta {
    return ClientDeltaImpl()
  }
  
  
  public func newDelta(next:NSURL) -> ClientDelta {
    return ClientDeltaImpl(next)
  }
   */
  
  // TODO: InLine
  /*
   public func newDeepInsertEntitySet(name:String, entitySet:ClientEntitySet) -> ClientInlineEntitySet {
   return ClientInlineEntitySet(nil, ClientLinkType.ENTITY_SET_NAVIGATION, name, entitySet)
   }
   
   
   public func newDeepInsertEntity(name:String:String , final ClientEntity entity) -> ClientInlineEntity {
   return ClientInlineEntity(nil, ClientLinkType.ENTITY_NAVIGATION, name, entity)
   }
   */
}

