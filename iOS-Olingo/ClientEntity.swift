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
//  ClientEntity.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// OData entity
public protocol ClientEntity { // extends ClientLinked, ClientAnnotatable, ClientInvokeResult {
  
  // MARK: - Protocol Properties
  
  /// the type name of this entity
  var typeName:FullQualifiedName {get}
  
  ///returns self link
  // TODO: When implemented in impl
  //var link: NSURL
  
  /// Entity ID
  var id:NSURL?  {get set}
  
  /// List of properties
  var properties:[ClientProperty] {get set}

  /// OData entity edit link
  var editLink: NSURL?  {get set}
 
  /// ETag
  var eTag:String?  {get set}
  
  /// Media entity flag
  var mediaEntity:Bool  {get set}
  
  /// In case of media entity, media content type
  var mediaContentType:String?  {get set}
  
  /// In case of media entity, media content source
  var mediaContentSource:NSURL?  {get set}
  
  /// Media ETag
  var mediaETag:String?  {get set}
  
  /// TODO: Operations (legacy, functions, actions)
  //var operations:[ClientOperation] {get}
  
  
  // MARK: - Protocol Methods

  /// Searches for property with given name
  /// - parameters:
  ///   - name: property to look for
  /// - returns: property if found with given name, 'nil` otherwise
  /// - throws: No error conditions are expected
  func getProperty(name:String) -> ClientProperty!
  
  /// TRUE if read-only entity
  /// - parameters:
  ///   - none
  /// - returns: TRUE if read-only FALSE otherwise
  /// - throws: No error conditions are expected
  func isReadOnly() -> Bool

  //TODO: Client Operations
  /// Searches for operation with given title
  /// - parameters:
  ///   - title: operation to look for
  /// - returns: operation if found with given title, `nil` otherwise
  /// - throws: No error conditions are expected
  //func getOperation(title:String) -> ClientOperation
  
  //TODO: Links to be added
  
  /// Gets media-edit link with given name, if available, otherwise `nil`
  /// - parameters:
  ///   - name: candidate link name
  /// - returns: media-edit link with given name, if available, otherwise `nil`
  /// - throws: No error conditions are expected
  //func getMediaEditLink(name:String) -> ClientLink
  
  /// Media edit links
  //var mediaEditLinks:[ClientLink] {get}
  

  
}
