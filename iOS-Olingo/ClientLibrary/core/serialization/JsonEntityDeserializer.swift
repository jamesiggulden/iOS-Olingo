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
//  JsonEntityDeserializer.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 08/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

  /// Reads JSON string into an entity.
  ///
  /// If metadata information is available, the corresponding entity fields and content will be populated.
public class JsonEntityDeserializer : JsonDeserializer {
  
  // MARK: - Stored Properties


  // MARK: - Computed Properties


  // MARK: - Init

  override init(serverMode:Bool) {
    super.init(serverMode: serverMode)
  }
  
  
  // MARK: - Methods
  
  //TODO: doDeserialize(parser:JsonParser) throws -> ResWrap<Entity>
  func doDeserialize(inputData: NSData) throws -> ResWrap<Entity>?  {
  //func doDeserialize(parser:JsonParser) throws -> ResWrap<Entity>?  {
    
  /*
    final ObjectNode tree = parser.getCodec().readTree(parser)
    
    if (tree.has(VALUE) && tree.get(VALUE).isArray()) {
      throw new JsonParseException("Expected OData Entity, found EntitySet", parser.getCurrentLocation())
    }
    
    final let entity:Entity = Entity()
    
    final let contextURL:NSURL
    
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
      entity.setBaseURI(URI.create(StringUtils.substringBefore(contextURL.toASCIIString(), METADATA)))
    }
    
    final String metadataETag
    if (tree.hasNonnil(JSON_METADATA_ETAG)) {
      metadataETag = tree.get(JSON_METADATA_ETAG).textValue()
      tree.remove(JSON_METADATA_ETAG)
    } else {
      metadataETag = nil
    }
    
    if (tree.hasNonnil(JSON_ETAG)) {
      entity.setETag(tree.get(JSON_ETAG).textValue())
      tree.remove(JSON_ETAG)
    }
    
    if (tree.hasNonnil(JSON_TYPE)) {
      entity.setType(new EdmTypeInfo.Builder().setTypeExpression(tree.get(JSON_TYPE).textValue()).build()
      .internal())
      tree.remove(JSON_TYPE)
    }
    
    if (tree.hasNonnil(JSON_ID)) {
      entity.setId(URI.create(tree.get(JSON_ID).textValue()))
      tree.remove(JSON_ID)
    }
    
    if (tree.hasNonnil(JSON_READ_LINK)) {
      final Link link = new Link()
      link.setRel(SELF_LINK_REL)
      link.setHref(tree.get(JSON_READ_LINK).textValue())
      entity.setSelfLink(link)
      
      tree.remove(JSON_READ_LINK)
    }
    
    if (tree.hasNonnil(JSON_EDIT_LINK)) {
      final Link link = new Link()
      if (serverMode) {
        link.setRel(EDIT_LINK_REL)
      }
      link.setHref(tree.get(JSON_EDIT_LINK).textValue())
      entity.setEditLink(link)
      
      tree.remove(JSON_EDIT_LINK)
    }
    
    if (tree.hasNonnil(JSON_MEDIA_READ_LINK)) {
      entity.setMediaContentSource(URI.create(tree.get(JSON_MEDIA_READ_LINK).textValue()))
      tree.remove(JSON_MEDIA_READ_LINK)
    }
    if (tree.hasNonnil(JSON_MEDIA_EDIT_LINK)) {
      entity.setMediaContentSource(URI.create(tree.get(JSON_MEDIA_EDIT_LINK).textValue()))
      tree.remove(JSON_MEDIA_EDIT_LINK)
    }
    if (tree.hasNonnil(JSON_MEDIA_CONTENT_TYPE)) {
      entity.setMediaContentType(tree.get(JSON_MEDIA_CONTENT_TYPE).textValue())
      tree.remove(JSON_MEDIA_CONTENT_TYPE)
    }
    if (tree.hasNonnil(JSON_MEDIA_ETAG)) {
      entity.setMediaETag(tree.get(JSON_MEDIA_ETAG).textValue())
      tree.remove(JSON_MEDIA_ETAG)
    }
    
    final Set<String> toRemove = new HashSet<String>()
    
    final Map<String, List<Annotation>> annotations = new HashMap<String, List<Annotation>>()
    for (final Iterator<Map.Entry<String, JsonNode>> itor = tree.fields() itor.hasNext()) {
      final Map.Entry<String, JsonNode> field = itor.next()
      final Matcher customAnnotation = CUSTOM_ANNOTATION.matcher(field.getKey())
      
      links(field, entity, toRemove, tree, parser.getCodec())
      if (field.getKey().endsWith(getJSONAnnotation(JSON_MEDIA_EDIT_LINK))) {
        final Link link = new Link()
        link.setTitle(getTitle(field))
        link.setRel(NS_MEDIA_EDIT_LINK_REL + getTitle(field))
        link.setHref(field.getValue().textValue())
        link.setType(MEDIA_EDIT_LINK_TYPE)
        entity.getMediaEditLinks().add(link)
        
        if (tree.has(link.getTitle() + getJSONAnnotation(JSON_MEDIA_ETAG))) {
          link.setMediaETag(tree.get(link.getTitle() + getJSONAnnotation(JSON_MEDIA_ETAG)).asText())
          toRemove.add(link.getTitle() + getJSONAnnotation(JSON_MEDIA_ETAG))
        }
        
        toRemove.add(field.getKey())
        toRemove.add(setInline(field.getKey(), getJSONAnnotation(JSON_MEDIA_EDIT_LINK), tree, parser
          .getCodec(), link))
      } else if (field.getKey().endsWith(getJSONAnnotation(JSON_MEDIA_CONTENT_TYPE))) {
        final String linkTitle = getTitle(field)
        for (Link link : entity.getMediaEditLinks()) {
          if (linkTitle.equals(link.getTitle())) {
            link.setType(field.getValue().asText())
          }
        }
        toRemove.add(field.getKey())
      } else if (field.getKey().charAt(0) == '#') {
        final Operation operation = new Operation()
        operation.setMetadataAnchor(field.getKey())
        
        final ObjectNode opNode = (ObjectNode) tree.get(field.getKey())
        operation.setTitle(opNode.get(ATTR_TITLE).asText())
        operation.setTarget(URI.create(opNode.get(ATTR_TARGET).asText()))
        
        entity.getOperations().add(operation)
        
        toRemove.add(field.getKey())
      } else if (customAnnotation.matches() && !"odata".equals(customAnnotation.group(2))) {
        final Annotation annotation = new Annotation()
        annotation.setTerm(customAnnotation.group(2) + "." + customAnnotation.group(3))
        try {
          value(annotation, field.getValue(), parser.getCodec())
        } catch (final EdmPrimitiveTypeException e) {
          throw new IOException(e)
        }
        
        if (!annotations.containsKey(customAnnotation.group(1))) {
          annotations.put(customAnnotation.group(1), new ArrayList<Annotation>())
        }
        annotations.get(customAnnotation.group(1)).add(annotation)
      }
    }
    
    for (Link link : entity.getNavigationLinks()) {
      if (annotations.containsKey(link.getTitle())) {
        link.getAnnotations().addAll(annotations.get(link.getTitle()))
        for (Annotation annotation : annotations.get(link.getTitle())) {
          toRemove.add(link.getTitle() + "@" + annotation.getTerm())
        }
      }
    }
    for (Link link : entity.getMediaEditLinks()) {
      if (annotations.containsKey(link.getTitle())) {
        link.getAnnotations().addAll(annotations.get(link.getTitle()))
        for (Annotation annotation : annotations.get(link.getTitle())) {
          toRemove.add(link.getTitle() + "@" + annotation.getTerm())
        }
      }
    }
    
    tree.remove(toRemove)
    
    try {
      populate(entity, entity.getProperties(), tree, parser.getCodec())
    } catch (final EdmPrimitiveTypeException e) {
      throw new IOException(e)
    }
    
    return new ResWrap<Entity>(contextURL, metadataETag, entity)
  }
 */
    return nil
  }
}
