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
//  EdmTypeInfo.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 15/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class EdmTypeInfo {
  
  public class Builder {
    
    private var typeExpression:String = ""
    private var defaultNamespace:String = ""
    private var edm:Edm?

    public init () {
      
    }
    
    init(typeExpression:String,defaultNamespace:String = "",edm:Edm) {
      self.typeExpression = typeExpression
      self.defaultNamespace = defaultNamespace
      self.edm = edm
    }
    
    // Redundent? as replaced with an init
    
    public func setTypeExpression(typeExpression:String) -> Builder {
      self.typeExpression = typeExpression
      return self
    }
    
    public func setDefaultNamespace(defaultNamespace:String) -> Builder {
      self.defaultNamespace = defaultNamespace
      return self
    }
    
    public func setEdm(edm:Edm) -> Builder {
      self.edm = edm
      return self
    }
 
    
    
    public func build() -> EdmTypeInfo? {
      //if let edm = edm {
        do {
          if typeExpression.containsString(".") && !defaultNamespace.isEmpty {
            return try EdmTypeInfo(edm: edm,typeExpression: defaultNamespace + "." + typeExpression)
          }
          else {
            return try EdmTypeInfo(edm: edm,typeExpression: typeExpression)
          }
        }
        catch {
          //TODO: Check if error needs to be caught and handled
          // do something
        }
        
     // }
     // else
      
      
      //return EdmTypeInfo(edm: edm,typeExpression: typeExpression.containsString(".") && !defaultNamespace.isEmpty ?defaultNamespace + "." + typeExpression : typeExpression)
      return nil
    }
  }
  
  // MARK: - Stored Properties

  public let isCollection:Bool
  public final let fullQualifiedName: FullQualifiedName
  public var primitiveTypeKind: EdmPrimitiveTypeKind?  //G
  public var typeDefinition: EdmTypeDefinition?  //G
  public var enumType: EdmEnumType? //G
  public var complexType: EdmComplexType?
  public var entityType: EdmEntityType?
  
  
  // MARK: - Computed Properties
  
  public var isPrimitiveType:Bool {
    return primitiveTypeKind != nil
  }
  
  public var isTypeDefinition:Bool {
    return typeDefinition != nil
  }
  
  public var isEnumType:Bool {
    return enumType != nil
  }
  
  public var isComplexType:Bool {
    return complexType != nil
  }
  
  public var isEntityType:Bool {
    return entityType != nil
  }
  
  public var type: EdmType? {
    if isPrimitiveType {
      do {
        return try EdmPrimitiveTypeFactory.getInstance(primitiveTypeKind!)
      }
      catch {
        return nil
      }
    }
    else if isTypeDefinition {
      return typeDefinition
    }
    else if isEnumType {
      return enumType
    }
    else if isComplexType {
      return complexType
    }
    else if isEntityType {
      return entityType
    }
    else {
      return nil
    }
  }



  // MARK: - Init

  init? (edm:Edm?, typeExpression:String) throws {
    var baseType:String = ""
    // check to see if "Collection(.....)" exists in expression where .... is any content
    // if it exists then get the substring between ( & )
    
    if typeExpression.containsString("Collection(") {
      if typeExpression.containsString(")") {
        
        baseType = typeExpression.substringBetweenStrings("Collection", end: ")")!
        isCollection = true
      }
      else {
        log.error("Instance not created: Malformed type: \(typeExpression)")
        return nil
      }
    }
    else {
      baseType = typeExpression
      isCollection = false
    }
    // redundent replaced with above
//    var collIdx = typeExpression.rangeOfString("Collection(")
//    let collEndIdx = typeExpression.rangeOfString(")", options: .BackwardsSearch)?.startIndex
//    
//    if (collIdx == nil) {
//      baseType = typeExpression
//      collection = false
//    }
//    else {
//      if (collEndIdx == nil) {
//        throw EdmException.MalformedType(msg: "Malformed type: \(typeExpression)")
//        
//      }
//      collection = true
//      
//      collIdx!.startIndex = (collIdx?.startIndex.advancedBy(11))!
//      collIdx!.endIndex = collEndIdx!
//      baseType = typeExpression.substringWithRange(collIdx!)
//    }
    
    baseType = baseType.stringByReplacingOccurrencesOfString("#", withString: "")
    
    var typeName:String = ""
    var namespace:String = ""
    
    let lastDotIdx = baseType.rangeOfString(".", options: .BackwardsSearch)?.startIndex
    
    if let lastDotIdx = lastDotIdx {
      namespace = baseType.substringToIndex(lastDotIdx)
      typeName = baseType.substringFromIndex(lastDotIdx.advancedBy(1))
    }
    else {
      namespace = EDM_NAMESPACE
      typeName = baseType
    }
    
    if typeName.isEmpty {
      //throw new IllegalArgumentException("nil or empty type name in " + typeExpression)
      log.error("nil or empty type name in \(typeExpression)")
      return nil
    }
    
    fullQualifiedName = FullQualifiedName(namespace: namespace, name: typeName)
    primitiveTypeKind = EdmPrimitiveTypeKind(rawValue: fullQualifiedName.name)
    // if (primitiveType == nil && edm != nil) {
    if let edm = edm {
      if primitiveTypeKind == nil {
        typeDefinition = edm.getTypeDefinition(fullQualifiedName)
        if (typeDefinition == nil) {
          enumType = edm.getEnumType(fullQualifiedName)
          if (enumType == nil) {
            complexType = edm.getComplexType(fullQualifiedName)
            if (complexType == nil) {
              entityType = edm.getEntityType(fullQualifiedName)
            }
          }
        }
      }
    }
  }
  
  
  // MARK: - Methods
   
  /// Build string of the full qualified name  and wrap with Collection( ..  ) if the type is a collection
  /// - parameters:
  ///   - none
  /// - returns: string of teh full qualified name with collection wrapping if a collection
  /// - throws: No error conditions are expected
  public func internalToString() -> String {
    
    var deserialize:String = ""
    
    if isCollection {
      deserialize = "Collection("
    }
    deserialize += fullQualifiedName.toString()
    if isCollection {
      deserialize += ")"
    }
    return deserialize
  }
  
  /// Build string of the full qualified name  and wrap with Collection( ..  ) if the type is a collection
  /// - parameters:
  ///   - none
  /// - returns: string of the full qualified name with collection wrapping if a collection and add # if required
  /// - throws: No error conditions are expected
  public func externalToString() -> String {
    var serialize:String = ""
  
    if isCollection {
      serialize = "#Collection("

    }
  
    if isPrimitiveType {
      serialize += fullQualifiedName.name
    }
    else {
      serialize += fullQualifiedName.toString()
    }
  
    if isCollection {
      serialize += ")"
    }
  
    if !isPrimitiveType && !isCollection {
      
      serialize = "#" + serialize
      //serialize.insert(0, '#')
    }
  
    return serialize
  }
  
  
}
