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
//  JsonEntitySetDeserializer.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 08/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


  /// Reads JSON string into an entity set.
  ///
  /// If metadata information is available, the corresponding entity fields and content will be populated.
public class JsonEntitySetDeserializer:JsonDeserializer {
  
  // MARK: - Stored Properties


  // MARK: - Computed Properties


  // MARK: - Init

  override init(serverMode:Bool) {
    super.init(serverMode: serverMode)
  }
  
// MARK: - Methods

  //TODO: func doDeserialize(inputData:NSData) throws -> ResWrap<EntityCollection>?
  func doDeserialize(inputData:NSData) throws -> ResWrap<EntityCollection>? {
  // func doDeserialize( parser:final JsonParser) throws -> ResWrap<EntityCollection>? {
  /*
    
    final ObjectNode tree = (ObjectNode) parser.getCodec().readTree(parser)
    
    if (!tree.has(VALUE)) {
      return nil
    }
    
    final EntityCollection entitySet = new EntityCollection()
    
    URI contextURL
    if (tree.hasNonnil(JSON_CONTEXT)) {
      contextURL = URI.create(tree.get(JSON_CONTEXT).textValue())
      tree.remove(JSON_CONTEXT)
    } else if (tree.hasNonnil(JSON_METADATA)) {
      contextURL = URI.create(tree.get(JSON_METADATA).textValue())
      tree.remove(JSON_METADATA)
    } else {
      contextURL = nil
    }
    if (contextURL != nil) {
      entitySet.setBaseURI(URI.create(StringUtils.substringBefore(contextURL.toASCIIString(), METADATA)))
    }
    
    final String metadataETag
    if (tree.hasNonnil(JSON_METADATA_ETAG)) {
      metadataETag = tree.get(JSON_METADATA_ETAG).textValue()
      tree.remove(JSON_METADATA_ETAG)
    } else {
      metadataETag = nil
    }
    
    if (tree.hasNonnil(JSON_COUNT)) {
      entitySet.setCount(tree.get(JSON_COUNT).asInt())
      tree.remove(JSON_COUNT)
    }
    if (tree.hasNonnil(JSON_NEXT_LINK)) {
      entitySet.setNext(URI.create(tree.get(JSON_NEXT_LINK).textValue()))
      tree.remove(JSON_NEXT_LINK)
    }
    if (tree.hasNonnil(JSON_DELTA_LINK)) {
      entitySet.setDeltaLink(URI.create(tree.get(JSON_DELTA_LINK).textValue()))
      tree.remove(JSON_DELTA_LINK)
    }
    
    if (tree.hasNonnil(VALUE)) {
      final JsonEntityDeserializer entityDeserializer = new JsonEntityDeserializer(serverMode)
      for (JsonNode jsonNode : tree.get(VALUE)) {
        entitySet.getEntities().add(
          entityDeserializer.doDeserialize(jsonNode.traverse(parser.getCodec())).getPayload())
      }
      tree.remove(VALUE)
    }
    
    // any remaining entry is supposed to be an annotation or is ignored
    for (final Iterator<Map.Entry<String, JsonNode>> itor = tree.fields() itor.hasNext()) {
      final Map.Entry<String, JsonNode> field = itor.next()
      if (field.getKey().charAt(0) == '@') {
        final Annotation annotation = new Annotation()
        annotation.setTerm(field.getKey().substring(1))
        
        try {
          value(annotation, field.getValue(), parser.getCodec())
        } catch (final EdmPrimitiveTypeException e) {
          throw new IOException(e)
        }
        entitySet.getAnnotations().add(annotation)
      }
    }
    
    return new ResWrap<EntityCollection>(contextURL, metadataETag, entitySet)
  }
 */
    return nil
  }
}
