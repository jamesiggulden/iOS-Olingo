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
//  Entity.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * Data representation for a single entity.
 */
// TODO: Add linked abstract
public class Entity:AbstractODataObject { //:Linked and then AbstractODataObject
  
  // MARK: - Stored Properties
  
  public var eTag:String = ""  // GS
  
  public var type:String = ""  // GS
  
  public var readLink:Link = Link()  // GS
  
  public var editLink:Link? // = Link()  // GS
  
  public let mediaEditLinks:[Link] = [Link]() //G
  
  public let operations:[Operation] = [Operation]()  //G
  
  public var properties:[Property] = [Property]()  //G
  
  public var mediaContentType:String = "" //GS
  
  public var mediaContentSource:NSURL? //GS

  public var mediaETag:String = ""  //GS
  
  // MARK: - Computed Properties
  
  public var selfLink:Link? {
    get{
      return readLink
    }
    set(selfLink) {
      readLink = selfLink!
    }
  }

  // MARK: - Init
  
  override init() {
    super.init()
  }

  // MARK: - Methods
   
  /// Add property to this Entity
  /// - parameters:
  ///   - property: property to be added
  /// - returns: this Entity for fluid/flow adding
  /// - throws: No error conditions are expected
  public func addProperty(property:Property) -> Entity {
    
    properties.append(property)
    return self
  }
   
  /// Gets property with given name
  /// - parameters:
  ///   - name: property name
  ///   - param2: add or remove params from list as required
  /// - returns: property with given name if found, nil otherwise
  /// - throws: No error conditions are expected
  
  public func getProperty(name:String) -> Property?{
    var result:Property?
    
    for property in properties {
      if (name == property.name) {
        result = property
        break
      }
    }
    return result
  }

  /**
   * Checks if the current entity is a media entity.
   *
   * @return 'TRUE' if is a media entity 'FALSE' otherwise.
   */
  public func isMediaEntity() -> Bool {
    
    if mediaContentSource != nil {
      return true
    }
    else {
      return false
    }
    // return mediaContentSource! = nil
  }
  
  // TODO: func equals(o:AnyObject) -> Bool
  public override func equals(o:AnyObject) -> Bool {
      return true
//    return super.equals(o)
//      && (eTag == null ? ((Entity) o).eTag == null : eTag.equals(((Entity) o).eTag))
//      && (type == null ? ((Entity) o).type == null : type.equals(((Entity) o).type))
//      && (readLink == null ? ((Entity) o).readLink == null : readLink.equals(((Entity) o).readLink))
//      && (editLink == null ? ((Entity) o).editLink == null : editLink.equals(((Entity) o).editLink))
//      && mediaEditLinks.equals(((Entity) o).mediaEditLinks)
//      && operations.equals(((Entity) o).operations)
//      && properties.equals(((Entity) o).properties)
//      && (mediaContentSource == null ?
//        ((Entity) o).mediaContentSource == null :
//        mediaContentSource.equals(((Entity) o).mediaContentSource))
//      && (mediaContentType == null ?
//        ((Entity) o).mediaContentType == null :
//        mediaContentType.equals(((Entity) o).mediaContentType))
//      && (mediaETag == null ? ((Entity) o).mediaETag == null : mediaETag.equals(((Entity) o).mediaETag))
  }
  
  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    int result = super.hashCode()
//    result = 31 * result + (eTag == null ? 0 : eTag.hashCode())
//    result = 31 * result + (type == null ? 0 : type.hashCode())
//    result = 31 * result + (readLink == null ? 0 : readLink.hashCode())
//    result = 31 * result + (editLink == null ? 0 : editLink.hashCode())
//    result = 31 * result + mediaEditLinks.hashCode()
//    result = 31 * result + operations.hashCode()
//    result = 31 * result + properties.hashCode()
//    result = 31 * result + (mediaContentSource == null ? 0 : mediaContentSource.hashCode())
//    result = 31 * result + (mediaContentType == null ? 0 : mediaContentType.hashCode())
//    result = 31 * result + (mediaETag == null ? 0 : mediaETag.hashCode())
//    return result
//  }
  
  // TODO: func toString() -> String
//  public func toString() -> String {
//    return properties.toString()
//  }
}
