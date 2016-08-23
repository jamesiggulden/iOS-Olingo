
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
//  ClientComplexValueImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 12/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class ClientComplexValueImpl: AbstractClientValue, ClientComplexValue {
  // MARK: - Stored Properties
  
  private var fields:[String : ClientProperty] = [:]

  // TODO: Navigation and annotations
  /*
  ///Navigation links (might contain in-line entities or entity sets).
  public let navigationLinks:[ClientLink] = []  //G
  /// Association links
  public let associationLinks:[ClientLink] = [] //G
  /// annotations
  public let annotations:[ClientAnnotation] = [] //G
  */
  
  // MARK: - Computed Properties
  
  override public var isEnum:Bool {
    get {
      return false
    }
  }
  
  override public var asEnum:ClientEnumValue?{
    get {
      return nil
    }
  }
  
  public override var isComplex:Bool {
    get {
      return true
    }
  }
  
  public var size:Int {
    return fields.count
  }


  // MARK: - Init

  init(typeName:String) {
    super.init(typeName: typeName)
  }
  
  // MARK: - Methods

  
 
  /// Builds a dictionary of fields and the swift types asscoiated with each field
  /// - parameters:
  ///   - none
  /// - returns: Dictionary of types
  /// - throws: No error conditions are expected
  public func asNativeTypeMap() -> [String: Any]  {
    var result:[String:Any] = [:]
    for (name, property) in fields {
      if property.hasPrimitiveValue {
        result[name] = property.primitiveValue!.value
      }
      else if property.hasComplexValue {
        result[name] = property.complexValue!.asNativeTypeMap()
      }
      else if property.hasCollectionValue {
        result[name] = property.collectionValue!.asNativeTypeCollection()
      }
      else if property.hasEnumValue {
        result[name] = property.enumValue!.toString()
      }
    }
    return result
  }
  
   
  /// Adds field to the complex type.
  /// - parameters:
  ///   - field: field to be added
  /// - returns: self
  /// - throws: No error conditions are expected
  public func add(field: ClientProperty) -> ClientComplexValue {
    fields[field.name] = field
    return self
  }
   
  /// Gets field
  /// - parameters:
  ///   - name name of the field to be retrieved
  /// - returns: requested field
  /// - throws: No error conditions are expected
  public func get(name:String) -> ClientProperty? {
    return fields[name]
  }
  
  public override func toString() -> String {
    //TODO : Expand to include links and annotations when implmented
    return "ClientComplexValueImpl [navigationLinks='', associationLinks='', annotations='', fields=\(fields) super[\(super.toString())]]"
    //return "ClientComplexValueImpl [navigationLinks=\(navigationLinks), associationLinks=\(associationLinks), annotations=\(annotations), fields=\(fields) super[\(super.toString())]]"
  }
  
  // TODO: func hashCode() -> Int
  /*
   public func hashCode() -> Int {
   final int prime = 31
   int result = super.hashCode()
   result = prime * result + ((annotations == Nil) ? 0 : annotations.hashCode())
   result = prime * result + ((associationLinks == Nil) ? 0 : associationLinks.hashCode())
   result = prime * result + ((fields == Nil) ? 0 : fields.hashCode())
   result = prime * result + ((navigationLinks == Nil) ? 0 : navigationLinks.hashCode())
   return result
   }
   */
  
  // TODO: func addLink( ink: ClientLink) -> Bool
  /*
   public func addLink( ink: ClientLink) -> Bool {
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
   throw  IllegalArgumentException("Complex values cannot have media links!")
   
   default:
   }
   
   return result
   }
   */
  
  // TODO: func removeLink(link:ClientLink )->Bool
  /*
   public func removeLink(link:ClientLink )->Bool {
   return associationLinks.remove(link) || navigationLinks.remove(link)
   }
   */
  // TODO: func getLink(links:[ClientLink], name:String) -> ClientLink
  /*
   private func getLink(links:[ClientLink], name:String) -> ClientLink {
   ClientLink result = Nil
   for (ClientLink link : links) {
   if (name.equals(link.getName())) {
   result = link
   break
   }
   }
   
   return result
   }
   */
  
  //TODO: func getNavigationLink(name:String ) -> ClientLink
  /*
   public func getNavigationLink(name:String ) -> ClientLink {
   return getLink(navigationLinks, name)
   }
   */
  
  // TODO: func getAssociationLink(name:String) -> ClientLink
  /*
   public func getAssociationLink(name:String) -> ClientLink {
   return getLink(associationLinks, name)
   }
   */

}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:ClientComplexValueImpl,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is ClientComplexValueImpl) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? ClientComplexValueImpl else {
    return false
  }
  if lhs === rhs {
    return true
  }
  // TODO: equality check
  /*
  if lhs.fields != rhs.fields {
    return false
  }
  */
  // TODO: Annotations and links
  /*
  if lhs.annotations != rhs.annotations {
    return false
  }
  if lhs.associationLinks != rhs.associationLinks {
    return false
  }

  if lhs.navigationLinks != rhs.navigationLinks {
    return false
  }
  */
  return true

  

}
