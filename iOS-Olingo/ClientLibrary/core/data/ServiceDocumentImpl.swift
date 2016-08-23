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
//  ServiceDocumentImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 07/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public final class ServiceDocumentImpl :ServiceDocument {
  
  // MARK: - Stored Properties

  public var title:String = ""
  
  public var entitySets:[ServiceDocumentItem] = []
  public var functionImports:[ServiceDocumentItem] = []
  public var singletons:[ServiceDocumentItem] = []
  public var relatedServiceDocuments:[ServiceDocumentItem] = []
  
  /// Metadata URI
  public var metadata:String = ""
  
  // MARK: - Computed Properties
  public var baseURI:NSURL {
    get {
      var baseURI:NSURL = NSURL()
      if (metadata.isEmpty) {
        let metadataURI = metadata
        // Split the metadatURI into 2 and take the first part and create a base URI
        baseURI = NSURL.fileURLWithPath(metadataURI.componentsSeparatedByString(METADATA)[0])
      }
      return baseURI
    }
  }
  
  // MARK: - Init

  // MARK: - Methods

  public func getEntitySetByName(name:String) -> ServiceDocumentItem? {
    return getByName(entitySets, name: name)
  }
  
  public func getFunctionImportByName(name:String) -> ServiceDocumentItem? {
    return getByName(functionImports, name: name)
  }
  
  public func getSingletonByName(name:String) -> ServiceDocumentItem? {
    return getByName(singletons, name: name)
  }

  
  private func getByName(elements:[ServiceDocumentItem], name:String) -> ServiceDocumentItem?{
    var result:ServiceDocumentItem?
    for element in elements {
      if name == element.name {
        result = element
      }
    }
    return result
  }
  
  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    int result = title != null ? title.hashCode() : 0
//    result = 31 * result + (entitySets != null ? entitySets.hashCode() : 0)
//    result = 31 * result + (functionImports != null ? functionImports.hashCode() : 0)
//    result = 31 * result + (singletons != null ? singletons.hashCode() : 0)
//    result = 31 * result + (relatedServiceDocuments != null ? relatedServiceDocuments.hashCode() : 0)
//    result = 31 * result + (metadata != null ? metadata.hashCode() : 0)
//    return result
//  }
  
  
  public func toString() -> String {
    let output = "ServiceDocumentImpl{title='\(title)'\\, entitySets=\(entitySets), functionImports=\(functionImports), singletons=\(singletons), relatedServiceDocuments\(relatedServiceDocuments), metadata=\(metadata)\\}"
    return output
  }
}

// MARK: - Extension

extension ServiceDocumentImpl:Equatable {}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:ServiceDocumentImpl,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is ServiceDocumentImpl) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? ServiceDocumentImpl else {
    return false
  }
  if lhs === rhs {
    return true
  }
  
  if lhs.title.isEmpty ? lhs.title != rhs.title : !rhs.title.isEmpty {
    return false
  }
  // TODO: Array checks
  /*
  if (lhs.entitySets != null ? !lhs.entitySets.equals(rhs.entitySets) : rhs.entitySets != null) {
    return false
  }
  if (lhs.functionImports != null ? !lhs.functionImports.equals(rhs.functionImports) : rhs.functionImports != null) {
    return false
  }
  if (lhs.singletons != null ? !lhs.singletons.equals(rhs.singletons) : rhs.singletons != null) {
    return false
  }
  if (lhs.relatedServiceDocuments != null ?
    !relatedServiceDocuments.equals(rhs.lhs.relatedServiceDocuments) : rhs.relatedServiceDocuments != null) {
    return false
  }
  return !(metadata != null ? !lhs.metadata.equals(rhs.metadata) : rhs.metadata != null)
 */
  return true
}



