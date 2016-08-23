
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
//  EdmTypeDefinition.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 18/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// An EdmTypeDefinition defines a specialization of one of the possible primitive types.  For more information on primitive types refer to EdmPrimitiveType
 
public protocol EdmTypeDefinition:EdmPrimitiveType, EdmAnnotatable {
  
  // MARK: - Protocol Properties
  
   /// return EdmPrimitiveTyp this type definition is based upon
  var underlyingType: EdmPrimitiveType {get}
   /// return the maximum length as an Integer or null if not specified
  var maxLength:Int {get}
   /// return the precision as an Integer or null if not specified
  var precision:Int {get}
   /// return the scale as an Integer or null if not specified
  var scale:Int {get}
   /// return a non-negative integer or the special value `variable`
  var srid:SRID {get}
   /// return true if unicode or null if not specified
  var isUnicode:Bool {get}
  
  // MARK: - Protocol Methods
}
