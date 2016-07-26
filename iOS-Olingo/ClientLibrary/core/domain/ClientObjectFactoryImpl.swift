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
  
  public func newEntitySet() ->  ClientEntitySet  {
    return ClientEntitySetImpl()
  }
  
  
  public func newEntitySet(next:NSURL) ->  ClientEntitySet {
    return ClientEntitySetImpl(next: next)
  }
  
  
  public func newEntity(typeName:FullQualifiedName ) ->  ClientEntity  {
    return ClientEntityImpl(typeName: typeName)
  }
  
  
  public func newEntity(typeName:FullQualifiedName , link:NSURL) ->  ClientEntity {
    let result = ClientEntityImpl(typeName: typeName)
    result.link = link
    return result
  }
  
  
  public func newPrimitiveValueBuilder() ->  ClientPrimitiveValueBuilder  {
    return ClientPrimitiveValueBuilderImpl()
  }
  
  
  public func newEnumValue(typeName:String, value:String) ->  ClientEnumValue  {
    return ClientEnumValueImpl(typeName: typeName, value: value)
  }
  
  
  public func newComplexValue(typeName:String) ->  ClientComplexValue  {
    return ClientComplexValueImpl(typeName: typeName)
  }
  

  public func newCollectionValue<T:ClientValue>(typeName:String) ->  T  {
    return ClientCollectionValueImpl<T>(typeName: typeName) as! T
  }
  
  
  public func newPrimitiveProperty(name:String, value:ClientPrimitiveValue ) ->  ClientProperty  {
    return ClientPropertyImpl(name: name, value: value)
  }
  
  
  public func newComplexProperty(name:String,value:ClientComplexValue ) ->  ClientProperty {
    return ClientPropertyImpl(name: name, value: value)
  }
  
  
  public func newCollectionProperty(name:String, value:ClientCollectionValue) -> ClientProperty  {
    return ClientPropertyImpl(name: name, value: value)
  }
  
  
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

