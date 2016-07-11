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
//  ODataDeserializer.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


/// Interface/protocol for de-serialization.

public protocol ODataDeserializer {
  
  /**
   * Gets an entity set object from the given InputStream.
   *
   * @param input stream to be de-serialized.
   * @return {@link EntityCollection} instance.
   */
   func toEntitySet(input: NSData) -> ResWrap<EntityCollection>
  
  /**
   * Gets an entity object from the given InputStream.
   *
   * @param input stream to be de-serialized.
   * @return {@link Entity} instance.
   */
  func toEntity(input: NSData) -> ResWrap<Entity>
  
  /**
   * Gets a property object from the given InputStream.
   *
   * @param input stream to be de-serialized.
   * @return Property instance.
   */
  func toProperty(input: NSData) ->  ResWrap<Property>
  
  /**
   * Gets the ODataError object represented by the given InputStream.
   *
   * @param input stream to be parsed and de-serialized.
   * @return parsed ODataError object represented by the given InputStream
   */
   func toError(input: NSData) -> ODataError
}

