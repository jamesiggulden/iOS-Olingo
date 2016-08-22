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

// Implementation based on Olingo's original java V4 implmentation.  Further details can be found at http://olingo.apache.org

//
//  JsonEntityDeserializer.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 08/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

  /// Reads JSON string into an entity.
  /// If metadata information is available, the corresponding entity fields and content will be populated.
public class JsonEntityDeserializer : JsonDeserializer {
  
  // MARK: - Stored Properties


  // MARK: - Computed Properties


  // MARK: - Init

  override init(serverMode:Bool) {
    super.init(serverMode: serverMode)
  }
  
  
  // MARK: - Methods
  
  /// Deserialize the data into an Entity object.
  /// - parameters:
  ///   - inputData: NSDATA object containing the preparsed JSON data
  /// - returns: Entity
  /// - throws: Error thrown from deserializeEntity function
  func doDeserialize(inputData: AnyObject) throws -> Entity?  {
    guard let data = inputData as? [String: AnyObject] else {
      log.error("Not a dictionary")
      return nil
    }
    log.debug(data.debugDescription)
    let entityData = try deserializeEntity(data)
    return entityData.payload
  }
  
  
  /// Deserialize the data dictionary into an Entity object.
  /// - parameters:
  ///   - inputData: dictionary containing the preparsed JSON data
  /// - returns: Entity
  /// - throws: Error thrown from deserializeEntity function
  private func deserializeEntity(inputData:[String:AnyObject]) throws -> (contextURL: NSURL!, metadataETag: String, payload: Entity!) {
    
    var data = inputData
    let entity:Entity = Entity()
    var contextURL:NSURL? = nil
    var metadataETag:String = ""
    
    // Check for, populate entity with values if found and remove from data array
    if data[JSON_CONTEXT] != nil {
      contextURL = NSURL(string: (data[JSON_CONTEXT]?.description)!)!
      data[JSON_CONTEXT] = nil
    }
    else if data[JSON_METADATA] != nil {
      contextURL = NSURL(string: (data[JSON_METADATA]?.description)!)!
      data[JSON_METADATA] = nil
    }
    if let contextURL = contextURL {
      let idx = contextURL.absoluteString.rangeOfString(METADATA)?.startIndex
      if let idx = idx {
        entity.baseURI = NSURL(string: contextURL.absoluteString.substringToIndex(idx))
      }
      else {
        entity.baseURI = NSURL(string: contextURL.absoluteString)
      }
    }
    if data[JSON_METADATA_ETAG] != nil {
      metadataETag = data[JSON_METADATA_ETAG]!.description
      data[JSON_METADATA_ETAG] = nil
    } else {
      metadataETag = ""
    }
    if data[JSON_ETAG] != nil {
      entity.eTag = (data[JSON_ETAG]?.description)!
      data[JSON_ETAG] = nil
    }
    if data[JSON_ID] != nil {
      entity.id = NSURL(string: (data[JSON_ID]?.description)!)
      data[JSON_ID] = nil
    }
    if (data[JSON_TYPE] != nil) {
      entity.type = EdmTypeInfo.Builder().setTypeExpression((data[JSON_TYPE]?.description)!).build()!.internalToString()
      data[JSON_TYPE] = nil
    }
    if (data[JSON_READ_LINK] != nil) {
      let link = Link()
      link.rel = SELF_LINK_REL
      link.href = data[JSON_READ_LINK]!.description
      entity.selfLink = link
      data[JSON_READ_LINK] = nil
    }
    if (data[JSON_EDIT_LINK] != nil) {
      let link = Link()
      if (serverMode) {
        link.rel = EDIT_LINK_REL
      }
      link.href = data[JSON_EDIT_LINK]!.description
      entity.editLink = link
      data[JSON_EDIT_LINK] = nil
    }
    if (data[JSON_MEDIA_READ_LINK] != nil) {
      entity.mediaContentSource = NSURL(string:data[JSON_MEDIA_READ_LINK]!.description)
      data[JSON_MEDIA_READ_LINK] = nil
    }
    if (data[JSON_MEDIA_EDIT_LINK] != nil) {
      entity.mediaContentSource = NSURL(string:data[JSON_MEDIA_EDIT_LINK]!.description)
      data[JSON_MEDIA_EDIT_LINK] = nil
    }
    if (data[JSON_MEDIA_CONTENT_TYPE] != nil) {
      entity.mediaContentType = data[JSON_MEDIA_CONTENT_TYPE]!.description
      data[JSON_MEDIA_CONTENT_TYPE] = nil
    }
    if (data[JSON_MEDIA_ETAG] != nil) {
      entity.mediaETag = data[JSON_MEDIA_ETAG]!.description
      data[JSON_MEDIA_ETAG] = nil
    }
    
    // TODO: Annotations
    /*
     var toRemove:[String] = []
     
     //final Map<String, List<Annotation>> annotations = new HashMap<String, List<Annotation>>()
     
     // with explictly checked for keys and values handled and removed
     // work through the remaining data
     
     for (jsonKey,jsonValue) in data {
     let customAnnotation:Matcher = CUSTOM_ANNOTATION.matcher(jsonKey)
     
     links(field, entity, toRemove, tree, parser.getCodec())
     if (jsonKey.containsString(getJSONAnnotation(JSON_MEDIA_EDIT_LINK)) { // endsWith(getJSONAnnotation(JSON_MEDIA_EDIT_LINK))) {
     let link = Link()
     link.title(getTitle(field))
     link.setRel(NS_MEDIA_EDIT_LINK_REL + getTitle(field))
     link.setHref(field.getValue().textValue())
     link.setType(MEDIA_EDIT_LINK_TYPE)
     entity.getMediaEditLinks().add(link)
     
     if (tree.has(link.getTitle() + getJSONAnnotation(JSON_MEDIA_ETAG))) {
     link.setMediaETag(tree.get(link.getTitle() + getJSONAnnotation(JSON_MEDIA_ETAG)).asText())
     toRemove.add(link.getTitle() + getJSONAnnotation(JSON_MEDIA_ETAG))
     }
     
     toRemove.add(jsonKey)
     toRemove.add(setInline(jsonKey, getJSONAnnotation(JSON_MEDIA_EDIT_LINK), tree, parser
     .getCodec(), link))
     } else if (jsonKey.endsWith(getJSONAnnotation(JSON_MEDIA_CONTENT_TYPE))) {
     final String linkTitle = getTitle(field)
     for (Link link : entity.getMediaEditLinks()) {
     if (linkTitle.equals(link.getTitle())) {
     link.setType(field.getValue().asText())
     }
     }
     toRemove.add(jsonKey)
     } else if (jsonKey.charAt(0) == '#') {
     final Operation operation = new Operation()
     operation.setMetadataAnchor(jsonKey)
     
     final ObjectNode opNode = (ObjectNode) tree.get(jsonKey)
     operation.setTitle(opNode.get(ATTR_TITLE).asText())
     operation.setTarget(URI.create(opNode.get(ATTR_TARGET).asText()))
     
     entity.getOperations().add(operation)
     
     toRemove.add(jsonKey)
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
     
     }
     */
    
    // TODO: Annotations & Links
    /*
     for link in entity.navigationLinks {
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
     */
    
    do {
      try populate(&entity.properties, data: data)
      log.debug("Number of properties: \(entity.properties.count)")
    }
    catch let error as NSError{
      log.error("Error deserialzing entity: \(error.localizedDescription)")
      // bubble up error to calling function
    }
    return (contextURL: contextURL, metadataETag: metadataETag, payload: entity)
  }

  
  //TODO: doDeserialize(parser:JsonParser) throws -> ResWrap<Entity>
  /// Parse and deserialize the data into an Entity object.
  /// - parameters:
  ///   - inputData: NSDATA object containing the unparsed JSON data
  /// - returns: Resource Wrapper with Entity
  /// - throws: No error conditions are expected
  func doDeserialize(inputData: NSData) throws -> ResWrap<Entity>?  {
    
    guard let data = parseHttpData(inputData) else {
      return nil
    }
    do {
      let entityData = try deserializeEntity(data)
      if entityData.contextURL == nil {
        return nil
      }
      return  ResWrap<Entity>(contextURL: entityData.contextURL!, metadataETag: entityData.metadataETag, payload: entityData.payload)
    }
    catch let error as NSError{
      log.error("Error deserialzing results: \(error.localizedDescription)")
      throw GetODataException.ODataEntityFailed
    }
  }
  
  
  /// parse response JSON NSData into an array of customer objects
  /// - parameters:
  ///   - data: raw JSON data
  /// - returns: Dictionary of JSON key value pairs
  /// - throws: No error conditions are expected
  private func parseHttpData(data: NSData?) -> [String:AnyObject]! {
    do {
      if let data = data, response = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(rawValue:0)) as? [String: AnyObject] {
        return response
      } else {
        log.error("JSON Error")
      }
    } catch let error as NSError {
      log.error("Error parsing results: \(error.localizedDescription)")
    }
    return nil
  }
}
