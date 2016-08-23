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
//  ClientODataDeserializer.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


public protocol ClientODataDeserializer: ODataDeserializer {
  
  // MARK: - Protocol Properties
  
  // MARK: - Protocol Methods
  
  // TODO: func toMetadata( input: NSData) -> XMLMetadata
  //func toMetadata( input: NSData) -> XMLMetadata
  
  // TODO: func toServiceDocument(input: NSData) -> ResWrap<ServiceDocument>

//  /**
//   * Gets the ServiceDocument object represented by the given InputStream.
//   *
//   * @param input stream to be de-serialized.
//   * @return `ServiceDocument` object.
//   * @throws ODataDeserializerException
//   */
//  func toServiceDocument(input: NSData) -> ResWrap<ServiceDocument>
//  
  
  //TODO: func  toDelta(input: NSData) -> ResWrap<Delta>
//  /**
//   * Gets a delta object from the given InputStream.
//   *
//   * @param input stream to be de-serialized.
//   * @return {@link Delta} instance.
//   * @throws ODataDeserializerException
//   */
//  func  toDelta(input: NSData) -> ResWrap<Delta>
}
