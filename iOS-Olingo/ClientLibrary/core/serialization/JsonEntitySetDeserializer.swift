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
  /// If metadata information is available, the corresponding entity fields and content will be populated. 

public class JsonEntitySetDeserializer:JsonDeserializer {
  
  // MARK: - Stored Properties


  // MARK: - Computed Properties


  // MARK: - Init

  override init(serverMode:Bool) {
    super.init(serverMode: serverMode)
  }
  
// MARK: - Methods

  /// Deserialize the data into an EntityCollection object.
  /// - parameters:
  ///   - inputData: NSDATA object containing the JSON data
  /// - returns: EntityCollection in a ResWrap object
  /// - throws: No error conditions are expected
  func doDeserialize(inputData:NSData) throws -> ResWrap<EntityCollection>? {
    
    guard var data = parseHttpData(inputData) else {
      return nil
    }
    
    let entitySet = EntityCollection()
    
    var contextURL:NSURL?
    var metadataETag:String = ""
    
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
        entitySet.baseURI = NSURL(string: contextURL.absoluteString.substringToIndex(idx))
      }
      else {
        entitySet.baseURI = NSURL(string: contextURL.absoluteString)
      }
    }
    else {
      log.info("context URL not defined")
      throw GetODataException.ODataEntitySetFailed
    }
    
    if data[JSON_METADATA_ETAG] != nil {
      metadataETag = data[JSON_METADATA_ETAG]!.description
      data[JSON_METADATA_ETAG] = nil
    } else {
      metadataETag = ""
    }
    if data[JSON_COUNT] != nil {
      entitySet.count = Int(data[JSON_COUNT]!.description)!
      data[JSON_COUNT] = nil
    }
    if data[JSON_NEXT_LINK] != nil {
      entitySet.next = NSURL(string: (data[JSON_NEXT_LINK]?.description)!)
      data[JSON_NEXT_LINK] = nil
    }
    if data[JSON_DELTA_LINK] != nil {
      entitySet.deltaLink = NSURL(string: (data[JSON_DELTA_LINK]?.description)!)
      data[JSON_DELTA_LINK] = nil
    }
    if data[VALUE] != nil {
      let entityDeserializer:JsonEntityDeserializer = JsonEntityDeserializer(serverMode: serverMode)
      let valueData = data[VALUE]
      
      for entitySetData in valueData as! [AnyObject]
      {
        log.debug(entitySetData.debugDescription)
        do {
          if let entity = try entityDeserializer.doDeserialize(entitySetData) {
            entitySet.entities.append(entity)
            log.debug("Number of entities: \(entitySet.entities.count)")
          }
        }
        catch  let err{
          log.error("JSON value error: \(err)")
        }
      }
      data[VALUE] = nil
    }
    
    // TODO: Annotations
    /*
    // any remaining entry is supposed to be an annotation or is ignored
    for (key,value) in data {
      if key.characters[0] == "@" {
        let annotation = Annotation()
        annotation.term = value.description
        entitySet.annotations.append(annotation)
      }
    }
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
     */
    
    return ResWrap<EntityCollection>(contextURL: contextURL!, metadataETag: metadataETag, payload: entitySet)
  }
   
  /// helper method helps parse response JSON NSData into an array of customer objects.
  /// - parameters:
  ///   - data: Raw JSON data
  /// - returns: Dictionary of JSON key value pairs
  /// - throws: No error conditions are expected
  private func parseHttpData(data: NSData?) -> [String:AnyObject]! {
    do {
      if let data = data, response = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(rawValue:0)) as? [String: AnyObject] {
        return response
      } else {
        log.error("JSON Parsing Error")
      }
    } catch let error as NSError {
      log.error("Error parsing JSON data : \(error.localizedDescription)")
    }
    return nil
  }
}


