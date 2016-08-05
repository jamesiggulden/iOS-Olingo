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
//  EdmEntityType.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * A CSDL EntityType element.
 */
public class EdmEntityTypeImpl: AbstractEdmStructuredType, EdmEntityType {
  
  var theKeyPropertyRefs = [String: EdmKeyPropertyRef]()
    
  /**
   * Get a key property ref by its name.
   *
   * @param keyPredicateName name of key property
   * @return {@link EdmKeyPropertyRef} for given name
   */
  public func getKeyPropertyRef(keyPredicateName:String) -> EdmKeyPropertyRef {
    fatalError("Unsupported Operation")
  }
  
  /**
   * Gets all key predicate names. In case an alias is defined for a key predicate this will be returned.
   *
   * @return collection of key property names of type List&lt;String&gt;
   */
  public var keyPredicateNames:[String] {
    fatalError("Unsupported Operation")
  }
  
  /**
   * Get all key properties references as list of {@link EdmKeyPropertyRef}.
   *
   * @return collection of key properties of type List&lt;EdmKeyPropertyRef&gt;
   */
  public func getKeyPropertyRefs() -> [EdmKeyPropertyRef] {
    return Array(theKeyPropertyRefs.values)
  }
  
  /**
   * Indicates if the entity type is treated as Media Link Entry with associated Media Resource.
   *
   * @return <code>true</code> if the entity type is a Media Link Entry
   */
  public var hasStream:Bool {
    fatalError("Unsupported Operation")
  }
  
}
