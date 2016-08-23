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
//  ODataDeserializer.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


/// Interface/protocol for de-serialization.

public protocol ODataDeserializer {
  
  // MARK: - Protocol Properties
  
  // MARK: - Protocol Methods
  
  /// Gets an entity set object from the given InputStream
  /// - parameters:
  ///   - input: stream to be de-serialized
  /// - returns: EntityCollection instance
  /// - throws: No error conditions are expected
  func toEntitySet(input: NSData) throws -> ResWrap<EntityCollection>?
  
  /// Gets an entity object from the given InputStream
  /// - parameters:
  ///   - input: stream to be de-serialized
  /// - returns: Entity instance
  /// - throws: No error conditions are expected
  func toEntity(input: NSData) throws -> ResWrap<Entity>?

  //TODO: Include when impl functionality added
  /*
  /// Gets a property object from the given InputStream
  /// - parameters:
  ///   - input: stream to be de-serialized
  /// - returns: Property instance
  /// - throws: No error conditions are expected
  func toProperty(input: NSData) ->  ResWrap<Property>
 */
  
  //TODO: Include when impl functionality added
  /*
  /// Gets the ODataError object represented by the given InputStream
  /// - parameters:
  ///   - input: stream to be de-serialized
  /// - returns: parsed ODataError object instance
  /// - throws: No error conditions are expected
  func toError(input: NSData) -> ODataError
 */
  
}

