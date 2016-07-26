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
//  ClientODataDeserializerImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class ClientODataDeserializerImpl: ClientODataDeserializer {
  
  // MARK: - Stored Properties

  private let deserializer:JsonDeserializer   //ODataDeserializer
  private let contentType:ContentType
  
  // MARK: - Computed Properties

  // MARK: - Init

  init (boolean serverMode:Bool,contentType:ContentType) {
    self.contentType = contentType
    // only working with xml to start with
    deserializer = JsonDeserializer(serverMode: serverMode)
    
    // TODO: add in capacity to switch to ATOM
//    if (contentType.isCompatible(ContentType.APPLICATION_ATOM_SVC!)
//      || contentType.isCompatible(ContentType.APPLICATION_ATOM_XML!)
//      || contentType.isCompatible(ContentType.APPLICATION_XML!)) {
//      deserializer =  AtomDeserializer()
//    } else {
//      deserializer = JsonDeserializer(serverMode)
//    }
  }
  
  // MARK: - Methods

  
  public func toEntitySet(input:NSData) throws -> ResWrap<EntityCollection>? {
    do {
      return try deserializer.toEntitySet(input)!
    }
    catch {
      throw GetODataException.OdataEntitySetFailed
    }
  }
  
  
  public func toEntity(input:NSData) throws -> ResWrap<Entity>? {
    do{
      return try deserializer.toEntity(input)!
    }
  }
  
  //TODO: func toProperty(input:NSData) throws -> ResWrap<Property>
  /*
  public func toProperty(input:NSData) throws -> ResWrap<Property> {
    return deserializer.toProperty(input)
  }
 */
  
  //TODO: func toError(input:NSData) throws -> ODataError 
  /*
  public func toError(input:NSData) throws -> ODataError  {
    return deserializer.toError(input)
  }
 */
  
  // TODO: getXmlMapper()
//  func getXmlMapper() -> XmlMapper {
//    let xmlMapper = XmlMapper(XmlFactory(InputFactoryImpl(),OutputFactoryImpl()),JacksonXmlModule())
//    
//    xmlMapper.setInjectableValues(new InjectableValues.Std().addValue(Boolean.class, Boolean.FALSE))
//    
//    xmlMapper.addHandler(new DeserializationProblemHandler() {
//    
//    public boolean handleUnknownProperty(final DeserializationContext ctxt, final JsonParser jp,
//    final com.fasterxml.jackson.databind.JsonDeserializer<?> deserializer,
//    final Object beanOrClass, final String propertyName)
//    throws IOException, JsonProcessingException {
//    
//    // skip any unknown property
//    ctxt.getParser().skipChildren()
//    return true
//    }
//    })
//    return xmlMapper
//  }
  
  // TODO: toMetadata(input:NSData)
//  public func toMetadata(input:NSData) -> XMLMetadata {
//    try {
//      return new ClientCsdlXMLMetadata(getXmlMapper().readValue(input, ClientCsdlEdmx.class))
//    } catch (Exception e) {
//      throw new IllegalArgumentException("Could not parse as Edmx document", e)
//    }
//  }
  
  // TODO: func toServiceDocument(input:NSData)
//  public func toServiceDocument(input:NSData) throws -> ResWrap<ServiceDocument>  {
//    return contentType.isCompatible(ContentType.APPLICATION_XML) ?
//      XMLServiceDocumentDeserializer(false).toServiceDocument(input) :
//        JSONServiceDocumentDeserializer(false).toServiceDocument(input)
//  }
  
  // TODO: toDelta(input:NSData)
//  public func toDelta(input:NSData) throws -> ResWrap<Delta> {
//    try {
//      return contentType.isCompatible(ContentType.APPLICATION_ATOM_SVC)
//        || contentType.isCompatible(ContentType.APPLICATION_ATOM_XML) ?
//      new AtomDeserializer().delta(input) :
//      new JsonDeltaDeserializer(false).toDelta(input)
//    } catch (final XMLStreamException e) {
//      throw new ODataDeserializerException(e)
//    } catch (final EdmPrimitiveTypeException e) {
//      throw new ODataDeserializerException(e)
//    }
//  }
}
