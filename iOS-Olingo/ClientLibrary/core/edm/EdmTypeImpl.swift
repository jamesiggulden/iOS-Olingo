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
//  EdmTypeImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class EdmTypeImpl: AbstractEdmNamed, EdmType {
  // MARK: - Stored Properties


  final let typeName:FullQualifiedName
  public final let kind:EdmTypeKind? //G
  
  // MARK: - Computed Properties
  
  public var namespace:String {
    get {
      return typeName.namespace
    }
  }
  
  public var fullQualifiedName:FullQualifiedName  {
    get {
      return typeName
    }
  }


  // MARK: - Init

  init (edm:Edm,typeName:FullQualifiedName ,kind:EdmTypeKind,annotatable:CsdlAnnotatable ) {
    self.typeName = typeName
    self.kind = kind
    super.init(edm: edm, name: typeName.name, annotatable: annotatable)
  }
  
  // MARK: - Methods
  
  
  
  

  
  

}
