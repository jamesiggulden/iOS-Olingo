
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
//  ClientLink.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

//TODO: ClientLink
/*

/// OData link.
public class ClientLink { //extends ClientItem implements ClientAnnotatable {
  
  public static class Builder {
    
    private var uri:NSURL
    
    private let type:ClientLinkType
    
    private var title:String
    
    public func setURI(uri:NSURL) -> Builder {
      self.uri = uri
      return self
    }
    
    public func setURI(baseURI:NSURL, href:String) -> Builder {
      uri = getURI(baseURI, href)
      return self
    }
    
    public func setType( type:ClientLinkType) -> Builder {
      self.type = type
      return self
    }
    
    public func setTitle(title:String) -> Builder {
      self.title = title
      return self
    }
    
    public func build() -> ClientLink {
      return ClientLink(uri, type, title)
    }
  }
  

  /// Build URI starting from the given base and href
  ///
  /// If href is absolute or base is null then base will be ignored
  /// - parameters:
  ///   - base: base of the URI
  ///   - href: additional parts of uri
  /// - returns: complete built URL
  /// - throws: No error conditions are expected
    private static func getURI(base:NSURL?, href:String?) throws -> NSURL {
      
      // check if href is not nil
      guard let href = href else {
        throw IllegalArgumentException.NilOrEmptyString  //("Nil link provided")
      }
      // then check it is a valid URL format
      guard var uri = NSURL(string:href) else {
        throw IllegalArgumentException.InvalidFormat
      }
      // check if the URL is  not absolute i.e without a scheme e.g. http
      if !uri.scheme.isEmpty {
        // and if not check if we have a base URL and append the href to the base URL
        if let base = base {
          uri = NSURL(string:href,relativeToURL: base)!
        }
      }
      return uri
  }
  
  /**
   * Link type.
   */
  public let type:ClientLinkType  //G
  
  /**
   * Link rel.
   */
  public let rel:String  //G
  
  /**
   * ETag for media edit links.
   */
  public let mediaETag:String  //G
  
  public let annotations:[ClientAnnotation] = []  //G
  
  /**
   * Constructor.
   *
   * @param uri URI.
   * @param type type.
   * @param title title.
   */
  public ClientLink(final URI uri, final ClientLinkType type, final String title) {
    super(title)
    
    this.type = type
    setLink(uri)
    
    switch (this.type) {
    case ASSOCIATION:
      rel = Constants.NS_ASSOCIATION_LINK_REL + title
      break
      
    case ENTITY_NAVIGATION:
    case ENTITY_SET_NAVIGATION:
      rel = Constants.NS_NAVIGATION_LINK_REL + title
      break
      
    case MEDIA_EDIT:
    default:
      rel = Constants.NS_MEDIA_EDIT_LINK_REL + title
      break
    }
  }
  
  /**
   * Constructor.
   *
   * @param version OData service version.
   * @param baseURI base URI.
   * @param href href.
   * @param type type.
   * @param title title.
   */
  init(baseURI:NSURL, href:String, type:ClientLinkType, title:String) {
    
    self(getURI(baseURI, href), type, title)
  }
  

  // TODO: func asInlineEntity() -> ClientInlineEntity?
  /*
  public func asInlineEntity() -> ClientInlineEntity? {
    return self is ClientInlineEntity ?  self as ClientInlineEntity  : nil
  }
 */
  
  // TODO: func asInlineEntitySet() -> ClientInlineEntitySet?
  /*
  public func asInlineEntitySet() -> ClientInlineEntitySet? {
    return self is ClientInlineEntitySet ? self as ClientInlineEntitySet : nil
  }
 */
  

}
 
 */
