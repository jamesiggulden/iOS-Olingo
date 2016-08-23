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
//  ClientEntityImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

// Client Entity
public class ClientEntityImpl: AbstractClientPayload, ClientEntity { // implements ClientSingleton {
  
  
  // MARK: - Stored Properties

   /// Entity ID
  public var id:NSURL?  //GS
  /// ETag
  public var eTag:String?  //GS
  /// Media entity flag
  public var mediaEntity:Bool = false  //GS
  /// In case of media entity, media content type
  public var mediaContentType:String?  //GS
  /// In case of media entity, media content source
  public var mediaContentSource:NSURL?  // GS
  /// Media ETag
  public var mediaETag:String?  //GS
  /// Edit link
  public var editLink: NSURL?  // GS
  /// List of properties
  public var properties:[ClientProperty] = []
  /// List of annotations
  public let annotations:[ClientAnnotation] = []
  /// type name
  public let typeName:FullQualifiedName //G

  // TODO: Links and operations
  /*
  /// Navigation links (might contain in-line entities or entity sets)
  public var navigationLinks:[ClientLink] = []  // G
  /// Association links
  public var associationLinks:[ClientLink] = []  //G
  /// Media edit links
  public var mediaEditLinks:[ClientLink] = []  //G
  /// Operations (legacy, functions, actions)
  private let operations:[ClientOperation] = []
  */

  // MARK: - Computed Properties

  
  // MARK: - Init

  init(typeName: FullQualifiedName) {
    self.typeName = typeName
    super.init(name: typeName.toString())
  }
  
  // MARK: - Methods
  
  // TODO: func getOperation(title:String) -> ClientOperation!
  /*
  public func getOperation(title:String) -> ClientOperation! {
    var result:ClientOperation?
    for operation in operations {
      if (title == operation.getTitle()) {
        result = operation
        break
      }
    }
    
    return result
  }
 */
  
  /// get property with the provided name
  /// - parameters:
  ///   - name: name of property to find and return
  /// - returns: ClientProperty if found nil otherwise
  /// - throws: No error conditions are expected
  public func getProperty(name:String) -> ClientProperty! {
    var result:ClientProperty?
    
    if !name.isEmpty {
      for property in properties {
        if name == property.name {
          result = property
          break
        }
      }
    }
    
    return result
  }
  
  //TODO: link methods
/*
  public func addLink(link: ClientLink) -> Bool {
    var result:Bool = false
    
    switch (link.getType()) {
    case ASSOCIATION:
      result = associationLinks.contains(link) ? false : associationLinks.add(link)
      break
      
    case ENTITY_NAVIGATION:
    case ENTITY_SET_NAVIGATION:
      result = navigationLinks.contains(link) ? false : navigationLinks.add(link)
      break
      
    case MEDIA_EDIT:
      result = mediaEditLinks.contains(link) ? false : mediaEditLinks.add(link)
      break
      
    default:
    }
    
    return result
  }
  
  
  public func removeLink(link: final ClientLink ) -> Bool {
    return associationLinks.remove(link) || navigationLinks.remove(link)
  }
  
  private func getLink(links:[ClientLink], name:String) -> ClientLink!{
    var result:ClientLink?
    for link in links {
      if name == link.getName() {
        result = link
        break
      }
    }
    
    return result
  }
  
  
  public func getNavigationLink(name:String) -> ClientLink {
    return getLink(navigationLinks, name)
  }

  public func getAssociationLink(name:String) -> ClientLink {
    return getLink(associationLinks, name)
  }

  public func getMediaEditLink(name:String) -> ClientLink {
    return getLink(mediaEditLinks, name)
  }
  
  public func getLink() -> NSURL {
    return super.getLink() == nil ? getEditLink() : super.getLink()
  }
  */
  
  //TODO: func isReadOnly() -> Bool (currently set to true for all cases)
  
  public func isReadOnly() -> Bool {
    return true
    //return super.getLink() != nil
  }
 

  // TODO: func hashCode() -> Int
  /*
  public func hashCode() -> Int {
    final int prime = 31
    int result = super.hashCode()
    result = prime * result + ((annotations == nil) ? 0 : annotations.hashCode())
    result = prime * result + ((associationLinks == nil) ? 0 : associationLinks.hashCode())
    result = prime * result + ((eTag == nil) ? 0 : eTag.hashCode())
    result = prime * result + ((editLink == nil) ? 0 : editLink.hashCode())
    result = prime * result + ((id == nil) ? 0 : id.hashCode())
    result = prime * result + ((mediaContentSource == nil) ? 0 : mediaContentSource.hashCode())
    result = prime * result + ((mediaContentType == nil) ? 0 : mediaContentType.hashCode())
    result = prime * result + ((mediaETag == nil) ? 0 : mediaETag.hashCode())
    result = prime * result + ((mediaEditLinks == nil) ? 0 : mediaEditLinks.hashCode())
    result = prime * result + (mediaEntity ? 1231 : 1237)
    result = prime * result + ((navigationLinks == nil) ? 0 : navigationLinks.hashCode())
    result = prime * result + ((operations == nil) ? 0 : operations.hashCode())
    result = prime * result + ((properties == nil) ? 0 : properties.hashCode())
    result = prime * result + ((typeName == nil) ? 0 : typeName.hashCode())
    return result
  }
  */
  
  public override func toString() -> String {
    // TODO: Build string when all proerpties availbale return "" for now
    return ""
    //return "ClientEntityImpl [id=\(id), eTag=\(eTag), mediaEntity=\(mediaEntity), mediaContentType=\(mediaContentType), mediaContentSource=\(mediaContentSource), mediaETag=\(mediaETag), editLink=\(editLink), properties=\(properties), annotations=\(annotations), typeName=\(typeName), navigationLinks=\(navigationLinks), associationLinks=\(associationLinks), mediaEditLinks=\(mediaEditLinks), operations=\(operations)super[\(super.toString())]]"
  }
}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:ClientEntityImpl,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is ClientEntityImpl) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? ClientEntityImpl else {
    return false
  }
  if lhs === rhs {
    return true
  }
  if (lhs.eTag == nil) {
    if (rhs.eTag != nil) {
      return false
    }
  } else if lhs.eTag != rhs.eTag {
    return false
  }
  if (lhs.editLink == nil) {
    if (rhs.editLink != nil) {
      return false
    }
  } else if lhs.editLink != rhs.editLink {
    return false
  }
  if (lhs.id == nil) {
    if (rhs.id != nil) {
      return false
    }
  } else if lhs.id != rhs.id {
    return false
  }
  if (lhs.mediaContentSource == nil) {
    if (rhs.mediaContentSource != nil) {
      return false
    }
  } else if lhs.mediaContentSource != rhs.mediaContentSource {
    return false
  }
  if (lhs.mediaContentType == nil) {
    if (rhs.mediaContentType != nil) {
      return false
    }
  } else if lhs.mediaContentType != rhs.mediaContentType {
    return false
  }
  if (lhs.mediaETag == nil) {
    if (rhs.mediaETag != nil) {
      return false
    }
  } else if lhs.mediaETag != rhs.mediaETag {
    return false
  }

  if (lhs.mediaEntity != rhs.mediaEntity) {
    return false
  }
  // TODO: equality check
  /*
  if lhs.properties != rhs.properties {
    return false
  }
  */
  if lhs.typeName != rhs.typeName {
    return false
  }
  
  // TODO: additional links & annotations
  /*
  if lhs.navigationLinks != rhs.navigationLinks {
    return false
  }
  if lhs.operations != rhs.operations {
    return false
  }
  if lhs.annotations != rhs.annotations {
    return false
  }
  if lhs.associationLinks != rhs.associationLinks  {
    return false
  }
  if mediaEditLinks != rhs.mediaEditLinks {
    return false
  }
 */
  
  return true
}






