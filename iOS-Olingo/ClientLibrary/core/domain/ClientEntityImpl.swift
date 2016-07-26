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
  
  // REDUNDENT
//  public List<ClientOperation> getOperations() {
//    return operations
//  }
  
  
  
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
  
//  public func hashCode() -> Int {
//    final int prime = 31
//    int result = super.hashCode()
//    result = prime * result + ((annotations == null) ? 0 : annotations.hashCode())
//    result = prime * result + ((associationLinks == null) ? 0 : associationLinks.hashCode())
//    result = prime * result + ((eTag == null) ? 0 : eTag.hashCode())
//    result = prime * result + ((editLink == null) ? 0 : editLink.hashCode())
//    result = prime * result + ((id == null) ? 0 : id.hashCode())
//    result = prime * result + ((mediaContentSource == null) ? 0 : mediaContentSource.hashCode())
//    result = prime * result + ((mediaContentType == null) ? 0 : mediaContentType.hashCode())
//    result = prime * result + ((mediaETag == null) ? 0 : mediaETag.hashCode())
//    result = prime * result + ((mediaEditLinks == null) ? 0 : mediaEditLinks.hashCode())
//    result = prime * result + (mediaEntity ? 1231 : 1237)
//    result = prime * result + ((navigationLinks == null) ? 0 : navigationLinks.hashCode())
//    result = prime * result + ((operations == null) ? 0 : operations.hashCode())
//    result = prime * result + ((properties == null) ? 0 : properties.hashCode())
//    result = prime * result + ((typeName == null) ? 0 : typeName.hashCode())
//    return result
//  }
  
  
  public override func equals(obj: AnyObject) -> Bool {
    if (self === obj) {
      return true
    }
    else {
      return false
      
      // TODO: expand out the checks if objects not identical
//      if (!super.equals(obj)) {
//      return false
//      }
//      if (!(obj instanceof ClientEntityImpl)) {
//        return false
//      }
//      ClientEntityImpl other = (ClientEntityImpl) obj
//    if (annotations == null) {
//      if (other.annotations != null) {
//        return false
//      }
//    } else if (!annotations.equals(other.annotations)) {
//      return false
//    }
//    if (associationLinks == null) {
//      if (other.associationLinks != null) {
//        return false
//      }
//    } else if (!associationLinks.equals(other.associationLinks)) {
//      return false
//    }
//    if (eTag == null) {
//      if (other.eTag != null) {
//        return false
//      }
//    } else if (!eTag.equals(other.eTag)) {
//      return false
//    }
//    if (editLink == null) {
//      if (other.editLink != null) {
//        return false
//      }
//    } else if (!editLink.equals(other.editLink)) {
//      return false
//    }
//    if (id == null) {
//      if (other.id != null) {
//        return false
//      }
//    } else if (!id.equals(other.id)) {
//      return false
//    }
//    if (mediaContentSource == null) {
//      if (other.mediaContentSource != null) {
//        return false
//      }
//    } else if (!mediaContentSource.equals(other.mediaContentSource)) {
//      return false
//    }
//    if (mediaContentType == null) {
//      if (other.mediaContentType != null) {
//        return false
//      }
//    } else if (!mediaContentType.equals(other.mediaContentType)) {
//      return false
//    }
//    if (mediaETag == null) {
//      if (other.mediaETag != null) {
//        return false
//      }
//    } else if (!mediaETag.equals(other.mediaETag)) {
//      return false
//    }
//    if (mediaEditLinks == null) {
//      if (other.mediaEditLinks != null) {
//        return false
//      }
//    } else if (!mediaEditLinks.equals(other.mediaEditLinks)) {
//      return false
//    }
//    if (mediaEntity != other.mediaEntity) {
//      return false
//    }
//    if (navigationLinks == null) {
//      if (other.navigationLinks != null) {
//        return false
//      }
//    } else if (!navigationLinks.equals(other.navigationLinks)) {
//      return false
//    }
//    if (operations == null) {
//      if (other.operations != null) {
//        return false
//      }
//    } else if (!operations.equals(other.operations)) {
//      return false
//    }
//    if (properties == null) {
//      if (other.properties != null) {
//        return false
//      }
//    } else if (!properties.equals(other.properties)) {
//      return false
//    }
//    if (typeName == null) {
//      if (other.typeName != null) {
//        return false
//      }
//    } else if (!typeName.equals(other.typeName)) {
//      return false
//    }
//    return true

    }
  }
  
  
  public override func toString() -> String {
    // TODO: Build string when all proerpties availbale return "" for now
    return ""
    //return "ClientEntityImpl [id=\(id), eTag=\(eTag), mediaEntity=\(mediaEntity), mediaContentType=\(mediaContentType), mediaContentSource=\(mediaContentSource), mediaETag=\(mediaETag), editLink=\(editLink), properties=\(properties), annotations=\(annotations), typeName=\(typeName), navigationLinks=\(navigationLinks), associationLinks=\(associationLinks), mediaEditLinks=\(mediaEditLinks), operations=\(operations)super[\(super.toString())]]"
  }
}
