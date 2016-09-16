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
//  CsdlAbstractEdmItem.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 15/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Super type of all CsdlEdmItems
public class CsdlAbstractEdmItem {
  
  /// Search the provided item array for the name provided and return the first item found
  /// - parameters:
  ///   - name: name to be searched
  ///   - items: the array of items to be searched
  /// - returns: the first item found
  /// - throws: No error conditions are expected
  func getOneByName <T:CsdlNamed> (name:String, items: [T]) -> T? {
    let result = getAllByName(name, items: items)
    return result.isEmpty ? nil : result[0]
  }
  
  /// Gets all csdl items with the specified name
  /// - parameters:
  ///   - name: the name to be searched for
  ///   - items: the array of items to be searched
  /// - returns: array of items that match the searched name
  /// - throws: No error conditions are expected
  func getAllByName <T:CsdlNamed> (name:String, items:[T]) -> [T] {
  
    var result = [T]()
    for type in items {
      if name == type.name {
          result.append(type)
      }
    }
    return result
  }
}
