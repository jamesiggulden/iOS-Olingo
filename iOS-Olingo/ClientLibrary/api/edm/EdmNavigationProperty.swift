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


//
//  EdmNavigationProperty.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * A CSDL NavigationProperty element
 * <br/>
 * EdmNavigationProperty allows navigation from one entity type to another via a relationship.
 */
public protocol EdmNavigationProperty:EdmElement { // TODO: EdmAnnotatable {
  
  ///
  ///var type: EdmEntityType {get}
  
  /// return true if nullable or not specified
  var isNullable:Bool {get}
  
  /// return true if containsTarget
  var containsTarget: Bool {get}
  
  /// return the partner navigation property
   var partner: EdmNavigationProperty? {get}

  
  /// Get property name for referenced property
  /// - parameters:
  ///   - referencedPropertyName: name of referenced property
  /// - returns: propertyName for this referenced property
  /// - throws: No error conditions are expected
  func getReferencingPropertyName(referencedPropertyName:String) -> String
  
  /// return all referential constraints for this navigation property
  var referentialConstraints:[EdmReferentialConstraint] { get set }
  
}
