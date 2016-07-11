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
//  Link.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

 /// Data representation for a link.

public class Link {  //extends Annotatable {
  
  // MARK: - Stored Properties

  public var title:String = "" // GS
  public var rel:String = ""//GS
  public var href:String = "" //GS
  public var type:String = ""  //GS
  public var mediaETag:String = "" //GS
  public var entity:Entity  //GS
  public var entitySet:EntityCollection  //GS
  
  /// If this is a "toOne" relationship this method delivers the binding link or ""(isEmpty) if not set
  public var bindingLink:String = ""
  
  /// If this is a "toMany" relationship this method delivers the binding links or `emptyList` if not set
  public var bindingLinks:[String] = [String]()
  
  // MARK: - Computed Properties
  
  var inlineEntity:Entity {
    get{
      return entity
    }
    set(entity) {
      self.entity = entity
    }
  }
  
  var inlineEntitySet:EntityCollection {
    get{
      return entitySet
    }
    set(entitySet) {
      self.entitySet = entitySet
    }
  }

  
  // MARK: - Init
  
  init() {
    self.entity = Entity()
    self.entitySet = EntityCollection()
  }

  // MARK: - Methods
  

  // TODO: func  equals(o:Object) -> Bool
//  public func equals(o:Object) -> Bool{
//    if (this === o) {
//      return true
//    }
//    if (o == null || getClass() != o.getClass()) {
//      return false
//    }
//    
//    final Link other = (Link) o
//    return getAnnotations().equals(other.getAnnotations())
//      && (title == null ? other.title == null : title.equals(other.title))
//      && (rel == null ? other.rel == null : rel.equals(other.rel))
//      && (href == null ? other.href == null : href.equals(other.href))
//      && (type == null ? other.type == null : type.equals(other.type))
//      && (mediaETag == null ? other.mediaETag == null : mediaETag.equals(other.mediaETag))
//      && (entity == null ? other.entity == null : entity.equals(other.entity))
//      && (entitySet == null ? other.entitySet == null : entitySet.equals(other.entitySet))
//      && (bindingLink == null ? other.bindingLink == null : bindingLink.equals(other.bindingLink))
//      && bindingLinks.equals(other.bindingLinks)
//  }
  
  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    int result = getAnnotations().hashCode()
//    result = 31 * result + (title == null ? 0 : title.hashCode())
//    result = 31 * result + (rel == null ? 0 : rel.hashCode())
//    result = 31 * result + (href == null ? 0 : href.hashCode())
//    result = 31 * result + (type == null ? 0 : type.hashCode())
//    result = 31 * result + (mediaETag == null ? 0 : mediaETag.hashCode())
//    result = 31 * result + (entity == null ? 0 : entity.hashCode())
//    result = 31 * result + (entitySet == null ? 0 : entitySet.hashCode())
//    result = 31 * result + (bindingLink == null ? 0 : bindingLink.hashCode())
//    result = 31 * result + bindingLinks.hashCode()
//    return result
//  }
}
