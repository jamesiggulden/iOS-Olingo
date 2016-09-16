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
//  ContextURLParser.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 18/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public struct ContextURLParser {
  
  // MARK: - Stored Properties

  
  // MARK: - Computed Properties


  // MARK: - Init

  
  // MARK: - Methods
 
  /// Parse the provided URI
  /// - parameters:
  ///   - contextURL: TBC
  /// - returns: Context URL
  /// - throws: No error conditions are expected
  public static func parse(contextURL:NSURL) -> ContextURL? {
    
    var contextUrl = ContextURL.with()
    var contextURLasString = contextURL.absoluteString
  
    var isEntity = false
    if (contextURLasString.hasSuffix("/$entity") || contextURLasString.hasSuffix("/@Element")) {
      isEntity = true
      contextUrl.suffix(ContextURL.Suffix.ENTITY)
      contextURLasString = contextURLasString.stringByReplacingOccurrencesOfString("/$entity", withString: "").stringByReplacingOccurrencesOfString("/@Element", withString: "")
    }
    else if (contextURLasString.hasSuffix("/$ref")) {
      contextUrl.suffix(ContextURL.Suffix.REFERENCE)
      contextURLasString = contextURLasString.stringByReplacingOccurrencesOfString("/$ref", withString: "")
    }
    else if (contextURLasString.hasSuffix("/$delta")) {
      contextUrl.suffix(ContextURL.Suffix.DELTA)
      contextURLasString = contextURLasString.stringByReplacingOccurrencesOfString("/$delta", withString: "")
    }
    else if (contextURLasString.hasSuffix("/$deletedEntity")) {
      contextUrl.suffix(ContextURL.Suffix.DELTA_DELETED_ENTITY)
      contextURLasString = contextURLasString.stringByReplacingOccurrencesOfString("/$deletedEntity", withString: "")
    } else if (contextURLasString.hasSuffix("/$link")) {
      contextUrl.suffix(ContextURL.Suffix.DELTA_LINK)
      contextURLasString = contextURLasString.stringByReplacingOccurrencesOfString("/$link", withString: "")
    } else if (contextURLasString.hasSuffix("/$deletedLink")) {
      contextUrl.suffix(ContextURL.Suffix.DELTA_DELETED_LINK)
      contextURLasString = contextURLasString.stringByReplacingOccurrencesOfString("/$deletedLink", withString: "")
    }
  
    guard let metaDataIdx = contextURLasString.rangeOfString(METADATA) else {
      // TODO: handling metadata
      return nil
    }
      
    contextUrl.serviceRoot(NSURL(string: contextURLasString.substringToIndex(metaDataIdx.startIndex))!)
    let rest = contextURLasString.substringFromIndex(metaDataIdx.endIndex.advancedBy(1))
    var firstToken:String = ""
    var entitySetOrSingletonOrType:String = ""
    if rest.hasSuffix("Collection(") {
      firstToken = "Collection(" + rest.substringBetweenStrings("Collection(", end: ")")! + ")"
      entitySetOrSingletonOrType = firstToken
    }
    else {
      let openParIdx = rest.rangeOfString("(")?.startIndex
      if openParIdx == nil {
        if let endIdx = rest.rangeOfString("/", options: .BackwardsSearch)?.startIndex {
          firstToken = rest.substringToIndex(endIdx)
        }
        else {
          firstToken = rest
        }
        entitySetOrSingletonOrType = firstToken
      }
      else {
        if isEntity {
          firstToken = rest
        }
        else {
          let endIdx = rest.rangeOfString(")", options: .BackwardsSearch)?.startIndex
          firstToken = rest.substringToIndex(endIdx!.advancedBy(1))
        }
        var parts:[String] = []
        for split in firstToken.componentsSeparatedByString("\\)/") {
          parts.append(split.stringByReplacingOccurrencesOfString("\\(.*", withString: ""))
        }
        entitySetOrSingletonOrType = parts.joinWithSeparator("/")
        let commaIdx = firstToken.rangeOfString(",")?.startIndex
        if (commaIdx != nil) {
          contextUrl.selectList(firstToken.substringFromIndex(openParIdx!))
        }
      }
    }
    contextUrl.entitySetOrSingletonOrType(entitySetOrSingletonOrType)
  
    let slashIdx = entitySetOrSingletonOrType.rangeOfString("/", options: .BackwardsSearch)?.startIndex
    if slashIdx != nil {
        let subString = entitySetOrSingletonOrType.substringFromIndex(slashIdx!)
        if subString.rangeOfString(".") != nil {
            contextUrl.entitySetOrSingletonOrType(entitySetOrSingletonOrType.substringToIndex(slashIdx!))
            contextUrl.derivedEntity(entitySetOrSingletonOrType.substringFromIndex((slashIdx?.advancedBy(1))!))
        }
    }
  
    if firstToken != rest {
      let pathElems = rest.substringFromIndex((rest.rangeOfString("/")?.startIndex)!).componentsSeparatedByString("/")
      
      if (pathElems.count > 0 && pathElems[0].characters.count > 0) {
        if pathElems[0].containsString(".") {
          contextUrl.navOrPropertyPath(pathElems[0])
        }
        else {
          contextUrl.derivedEntity(pathElems[0])
        }
        if (pathElems.count > 1) {
          contextUrl.navOrPropertyPath(pathElems[1])
        }
      }
    }
    return contextUrl.build()
  }
}

