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
//  ServiceDocument.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 07/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

// MARK: - Protocol

/// REST resource for an `ODataServiceDocument`
public protocol ServiceDocument {
  
  // MARK: - Protocol Properties
  
  var title:String {get}
  var baseURI:NSURL {get}
  /// top level entity sets.
  var entitySets:[ServiceDocumentItem] {get}
  /// top level function imports
  var functionImports:[ServiceDocumentItem] {get}
  /// top level singletons
  var singletons:[ServiceDocumentItem] {get}
  /// related service documents
  var relatedServiceDocuments:[ServiceDocumentItem] {get}
  
  // MARK: - Protocol Methods

  /// Gets top level entity set with given name
  /// - parameters:
  ///   - name: entity set name
  /// - returns: entity set with given name if found, otherwise nil
  /// - throws: No error conditions are expected
  func getEntitySetByName(name:String) -> ServiceDocumentItem?
  
  /// Gets top level function import set with given name
  /// - parameters:
  ///   - name: function import name
  /// - returns: function import with given name if found, otherwise nil
  /// - throws: No error conditions are expected
  func getFunctionImportByName(name:String) -> ServiceDocumentItem?
  

  /// Gets top level singleton with given name
  /// - parameters:
  ///   - name: singleton name
  /// - returns: singleton with given name if found, otherwise nil
  /// - throws: No error conditions are expected
  func  getSingletonByName(name:String) -> ServiceDocumentItem?
  
  func toString() -> String

}
