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
//  ContextURL.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 18/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


 /// High-level representation of a context URL, built from the string value returned by a service provides access to the various components of the context URL, defined in the [protocol specification](http://docs.oasis-open.org/odata/odata/v4.0/os/part1-protocol/odata-v4.0-os-part1-protocol.html#_Toc372793655)

public struct ContextURL {
  
  
  // MARK: - Stored Properties


  public var serviceRoot:NSURL?  //G
  
  public var entitySetOrSingletonOrType:String?  //G
  
  public var isCollection:Bool  = false //G
  
  public var derivedEntity: String?  //G
  
  public var selectList: String?  //G
  
  public var navOrPropertyPath: String?  //G
  
  public var keyPath: String?  //G
  
  public var suffix:Suffix?  //G
  
  public var odataPath: String?  //G
  
  
  // MARK: - Computed Properties

  /// Is context result a entity
  public var isEntity:Bool {
    return suffix == Suffix.ENTITY
  }
  
  
  /// Is context result a reference
  public var isReference:Bool {
    return suffix == Suffix.REFERENCE
  }
  
  
  /// Is context result a delta result
  public var isDelta:Bool {
    return suffix == Suffix.DELTA
  }
  
  
  /// Is context result a delta deleted entity
  public var isDeltaDeletedEntity:Bool {
    return suffix == Suffix.DELTA_DELETED_ENTITY
  }
  
  
  /// Is context result a delta link
  public var isDeltaLink:Bool {
    return suffix == Suffix.DELTA_LINK
  }
  
  
  /// Is context result a delta deleted link
  public var isDeltaDeletedLink:Bool {
    return suffix == Suffix.DELTA_DELETED_LINK
  }

  // MARK: - Init
  /*
  init () {
  
  }
*/
  
  // MARK: - Methods
  
  
   /// Start building a ContextURL instance.
   /// @return builder for building a ContextURL instance
   
  public static func with() -> Builder {
    return Builder()
  }
  
  
   /// Builder for a ContextURL instance.
   
  public struct Builder {
    
    private var contextURL = ContextURL()
    
    
     /// Set the OData path.
     /// @param oDataPath the OData path
     /// @return Builder
     
    public mutating func oDataPath(String oDataPath:String) -> Builder  {
      contextURL.odataPath = oDataPath
      return self
    }
    
    
     /// Set the service root.
     /// @param serviceRoot the service root
     /// @return Builder
     
    public mutating func serviceRoot(serviceRoot:NSURL) -> Builder {
      contextURL.serviceRoot = serviceRoot
      return self
    }
    
    
     /// Set the edm entity set.
     /// @param entitySet the edm entity set
     /// @return Builder
     
    public mutating func entitySet(entitySet:EdmEntitySet ) -> Builder {
      contextURL.entitySetOrSingletonOrType = entitySet.name
      return self
    }
    
    
     /// Set the key path.
     /// @param keyPath the key path
     /// @return Builder
     
    public mutating func keyPath(keyPath:String) -> Builder {
      contextURL.keyPath = keyPath
      return self
    }
    
    
     /// Set the entity set / singleton / type name.
     /// @param entitySetOrSingletonOrType the entity set / singleton / type name
     /// @return Builder
     
    public mutating func entitySetOrSingletonOrType(entitySetOrSingletonOrType:String) -> Builder {
      contextURL.entitySetOrSingletonOrType = entitySetOrSingletonOrType
      return self
    }
    
    
     /// Set the edm entity type.
     /// @param type the edm entity type
     /// @return Builder
     
    public mutating func type(type:EdmType) -> Builder {
      contextURL.entitySetOrSingletonOrType = type.fullQualifiedName.toString()
      return self
    }
    
    
     /// Define the result as a collection.
     /// @return Builder
     
    public mutating func asCollection() -> Builder {
      contextURL.isCollection = true
      return self
    }
    
    
     /// Set the derived edm entity type.
     /// @param derivedType the derived edm entity type
     /// @return Builder
     
    public mutating func derived(derivedType:EdmEntityType ) -> Builder {
      // TODO: derived
      // contextURL.derivedEntity = derivedType.fullQualifiedName.fullQualifiedNameAsString()
      return self
    }
    
    
     /// Set the derived entity name.
     /// @param derivedEntity the derived entity name
     /// @return Builder
     
    public mutating func derivedEntity(derivedEntity:String) -> Builder {
      contextURL.derivedEntity = derivedEntity
      return self
    }
    
    
     /// Set the navigation or property path.
     /// @param navOrPropertyPath the navigation or property path
     /// @return Builder
     
    public mutating func navOrPropertyPath(navOrPropertyPath:String) -> Builder {
      contextURL.navOrPropertyPath = navOrPropertyPath
      return self
    }
    
    
     /// Set the select list.
     /// @param selectList the select list
     /// @return Builder
     
    public mutating func selectList(selectList:String) -> Builder {
      contextURL.selectList = selectList
      return self
    }
    
    
     /// Set the suffix.
     /// @param suffix the suffix
     /// @return Builder
     
    public mutating func suffix(suffix:Suffix) -> Builder {
      contextURL.suffix = suffix
      return self
    }
    
    
     /// Create the ContextURL instance based on set values.
     /// @return the according ContextURL
     
    public func build() -> ContextURL {
      return contextURL
    }
  }
  
  /// Suffix of the OData Context URL
  
  public enum Suffix:String {
    
    /// Suffix for Entities
    
    case ENTITY = "$entity"
    
    /// Suffix for References
    
    case REFERENCE = "$ref"
    
    /// Suffix for deltas (changes)
    
    case DELTA = "$delta"
    
    /// Suffix for deleted entities in deltas
    
    case DELTA_DELETED_ENTITY = "$deletedEntity"
    
    /// New links in deltas
    
    case DELTA_LINK = "$link"
    
    /// Deleted links in deltas
    
    case DELTA_DELETED_LINK = "$deletedLink"
    
    /*
    private final String representation
    
    Suffix(final String representation) {
    this.representation = representation
    }
    
    
    /// Returns OData representation of the suffix
    ///
    /// @return Representation of the suffix
    
    public String getRepresentation() {
    return representation
    }
 */
  }

}
