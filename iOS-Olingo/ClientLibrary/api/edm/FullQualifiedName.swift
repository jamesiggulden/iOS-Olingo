/*
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with self work for additional information
  regarding copyright ownership.  The ASF licenses self file
  to you under the Apache License, Version 2.0 (the
  "License") you may not use self file except in compliance
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
//  FullQualifiedName.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 07/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


 /// A full qualified name of any element in the EDM consists of a name and a namespace.

public final class FullQualifiedName { //implements Serializable {
  
  // MARK: - Stored Properties

  private static let serialVersionUID:Int = -4063629050858999076
  
  public final let namespace:String
  public final let name:String
  public final let fqn:String
  
  // MARK: - Computed Properties
  

  // MARK: - Init
   
  /// Create the FQN with given namespace and name
  /// - parameters:
  ///   - namespace: namespace of FQN
  ///   - name: name of FQN
  /// - returns: New instance of object
  /// - throws: No error conditions are expected
  init(namespace:String,name:String) {
    self.namespace = namespace
    self.name = name
    self.fqn = namespace + "." + name
  }
   
  /// Create the FQN with given namespace and name (which is split of last `.` of the parameter)
  /// - parameters:
  ///   - namespaceAndName: namespace and name of FQN
  /// - returns: New instance of object
  /// - throws: No error conditions are expected
  init?(namespaceAndName:String) throws {
  
    // Find the last instance of "." in the string
    guard let dotIdx = namespaceAndName.rangeOfString(".", options: .BackwardsSearch)?.startIndex else {
      throw IllegalArgumentException.InvalidFormat // "Malformed " + FullQualifiedName.class.getSimpleName() + ": " + namespaceAndName)
      //return nil
    }
    // check if "." is the first or last char in the string
    if dotIdx == namespaceAndName.startIndex || dotIdx == namespaceAndName.endIndex.advancedBy(-1) {
      throw IllegalArgumentException.InvalidFormat // "Malformed " + FullQualifiedName.class.getSimpleName() + ": " + namespaceAndName)
      //return nil
    }
    self.fqn = namespaceAndName
    self.namespace = namespaceAndName.substringToIndex(dotIdx)
    self.name = namespaceAndName.substringFromIndex(dotIdx.advancedBy(1))
  }

  // MARK: - Methods
  
  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    return fqn.isEmpty ? 0 : fqn.hashCode()
//  }
  
  public func toString() -> String {
    return fqn
  }

}

// MARK: - Extension

extension FullQualifiedName:Equatable {}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:FullQualifiedName,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is FullQualifiedName) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? FullQualifiedName else {
    return false
  }
  if lhs === rhs {
    return true
  }
  if lhs.name == rhs.name && lhs.namespace == rhs.namespace {
    return true
  }
  else {
    return false
  }
}


