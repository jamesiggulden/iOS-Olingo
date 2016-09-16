
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
//  EdmTerm.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 18/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


 /// An EdmTerm defines a term in a vocabulary.
public protocol EdmTerm: EdmNamed, EdmAnnotatable {
  
  // MARK: - Protocol Properties
  
   /// return type of value returned by the expression contained in an annotation using this term
   var type: EdmType {get}
   /// return the fully qualified name of this term
   var fullQualifiedName: FullQualifiedName {get}
   /// When applying a term with a base term,the base term MUST also be applied with the same qualifier, and so on until a
   /// term without a base term is reached.
   /// return the base term if found or null otherwise
   var baseTerm: EdmTerm {get}
   /// return list of CSDL element that this term can be applied to; if no value is supplied, the term is not restricted
   /// in its application.
   // TODO: TragetType
  //var appliesTo: [TargetType] {get}
  
   /// return true if nullable
  var isNullable:Bool  {get}
   /// return the maximum length as an Integer or null if not specified
  var maxLength: Int {get}
   /// return the precision as an Integer or null if not specified
  var precision: Int {get}
   /// return the scale as an Integer or null if not specified
  var scale: Int {get}
   /// return a non-negative integer or the special value `variable`
  var srid: SRID {get}
   /// return the default value as a String or null if not specified
  var defaultValue: String {get}
  
  // MARK: - Protocol Methods
  
}
