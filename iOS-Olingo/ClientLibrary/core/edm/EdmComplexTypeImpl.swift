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

//  EdmComplexTypeImpl.swift
//  iOS-Olingo
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.

import Foundation

public class EdmComplexTypeImpl: AbstractEdmStructuredType, EdmComplexType {
  
  // MARK: - Init
  public init (edm:Edm, name:FullQualifiedName ,complexType: CsdlComplexType ) {
    super.init(edm: edm, typeName: name, kind: EdmTypeKind.COMPLEX, structuredType: complexType)
  }
  
  // MARK: - Methods
  
  /// build base type
  /// - parameters:
  ///   - baseTypeName: FullQualifiedName?
  /// - returns: EdmStructuredType
  /// - throws: No error conditions are expected
  func buildBaseType(baseTypeName: FullQualifiedName?)  -> EdmStructuredType? {
    var myBaseType: EdmComplexType?
    if (baseTypeName != nil) {
      myBaseType = edm.getComplexType(baseTypeName!)
      if (myBaseType == nil) {
        log.error("No base type found for: " + baseTypeName!.toString())
      }
    }
    return myBaseType
  }
   
  /// get base type
  /// - parameters:
  ///   - none
  /// - returns: base type
  /// - throws: No error conditions are expected
  public func getBaseType() ->  EdmComplexType  {
    checkBaseType()
    return baseType as! EdmComplexType
  }
  

  /// validate basetype name and type have values and create new basetype instance
  /// - parameters:
  ///   - none
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  override func checkBaseType() {
    if (baseTypeName != nil && baseType == nil) {
      baseType = buildBaseType(baseTypeName)
    }
  }
}
