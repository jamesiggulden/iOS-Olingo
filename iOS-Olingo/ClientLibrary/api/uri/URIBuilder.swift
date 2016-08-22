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
//  URIBuilder.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 03/08/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public protocol URIBuilder {
  
  // MARK: - Protocol Properties

  // MARK: - Protocol Properties

  /// Adds the specified query option to the URI. Concatenates value if the specified query option already exists.
  /// - parameters:
  ///   - option: query option
  ///   - value: query option value
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  func addQueryOption(option:QueryOption , value:String) -> URIBuilder
  
  /// Adds/replaces the specified query option to the URI.
  /// - parameters:
  ///   - option: query option
  ///   - value: query option value
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  func replaceQueryOption(option:QueryOption , value:String) -> URIBuilder
  

  /// Adds/Replaces the specified (custom) query option to the URI.
  /// - parameters:
  ///   - option: query option
  ///   - value: query option value
  ///   - replace: if `true` then replace existing one
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  func addQueryOption(option:String, value:String,replace:Bool) -> URIBuilder
  

  /// Adds the specified (custom) parameter alias to the URI.
  /// - parameters:
  ///   - alias: parameter alias
  ///   - exp: expression value
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  func addParameterAlias(alias:String, exp:String) -> URIBuilder
  

   /// Appends EntitySet segment to the URI.
   /// - parameters:
   ///  - segmentValue: segment value.
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendEntitySetSegment(segmentValue:String) -> URIBuilder
  

   /// Appends key segment to the URI.
   /// - parameters:
   ///  - val: segment value.
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendKeySegment(val:AnyObject) -> URIBuilder
  

   /// Appends key segment to the URI, for multiple keys.
   /// - parameters:
   ///  - segmentValues: segment values.
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendKeySegment(segmentValues:[String:AnyObject]) -> URIBuilder
  

   /// Appends property segment to the URI.
   /// - parameters:
   ///  - segmentValue segment value.
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendPropertySegment(segmentValue:String) -> URIBuilder
  

   /// Appends navigation segment to the URI.
   /// - parameters:
   ///  - segmentValue: segment value.
   /// - returns: current URIBuilder instance
  func appendNavigationSegment(segmentValue:String) -> URIBuilder
  

   /// Appends derived entity type segment to the URI.
   /// - parameters:
   ///  - segmentValue: segment value.
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendDerivedEntityTypeSegment(segmentValue:String) -> URIBuilder
  

   /// Appends value segment to the URI.
   /// - parameters:
   ///  - none:
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendValueSegment() -> URIBuilder
  

  /// Appends count segment to the URI.
  ///  - parameters:
  ///  - none:
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  func appendCountSegment() -> URIBuilder
  

   /// Appends operation (action or  function) segment to the URI.
   /// - parameters:
   ///  - operation: Operation (action or  function) name
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendOperationCallSegment(operation:String) -> URIBuilder
  

   /// Appends metadata segment to the URI.
   /// - parameters:
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendMetadataSegment() -> URIBuilder
  

   /// Appends batch segment to the URI.
   /// - parameters:
   ///  - none:
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendBatchSegment() -> URIBuilder
  

   /// Adds count query option.
   /// - parameters:
   ///  - none:
   /// - returns: current URIBuilder instance
  func count() -> URIBuilder
  

   /// Adds expand query option.
   /// - parameters:
   ///  - expandItems: items to be expanded in-line
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func expand(expandItems:String... ) -> URIBuilder
  

   /// Adds format query option.
   /// - parameters:
   ///  - format: media type acceptable in a response.
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func format(format:String) -> URIBuilder
  
  // TODO: Filter
   /// Adds filter for filter query option.
   /// - parameters:
   ///  - filter: filter instance (to be obtained via `FilterFactory`) -> URIBuilder note that 'build()' method will be immediately invoked.
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  //func filter(filter:URIFilter) -> URIBuilder
  
   /// Adds filter query option.
   /// - parameters:
   ///  - filter: filter string.
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func filter(filter:String) -> URIBuilder
  

   /// Adds select query option.
   /// - parameters:
   ///  - selectItems: select items
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func select(selectItems:String...) -> URIBuilder
  
  /// Overload to orginal select query option to pass in array of Strings
  /// - parameters:
  ///  - selectItems: select items as string array
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  func select(selectItems:[String]) -> URIBuilder

   /// Adds orderby query option.
   /// - parameters:
   ///  - order: order string.
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func orderBy(order:String) -> URIBuilder
  

   /// Adds top query option.
   /// - parameters:
   ///  - top: maximum number of entities to be returned.
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func top(top:Int) -> URIBuilder
  

   /// Adds skip query option.
   /// - parameters:
   ///  - skip: number of entities to be skipped into the response.
   /// - returns: current URIBuilder instance

  func skip(skip:Int) -> URIBuilder

  

   /// Adds skiptoken query option.
   /// - parameters:
   ///  - skipToken: opaque token.
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func skipToken(skipToken:String) -> URIBuilder

  

   /// Build OData URI.
   /// - parameters:
   ///  - none:
   /// - returns: OData URI.
   /// - throws: No error conditions are expected
  func build() throws -> NSURL
 

   /// Appends enum key segment to the URI.
   /// - parameters:
   ///  - enumType: enum type
   ///  - memberName enum member name
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendKeySegment(enumType:EdmEnumType, memberName:String) -> URIBuilder


   /// Appends key segment to the URI, for multiple keys.
   /// - parameters:
   ///  - enumValues: enum segment values.
   ///  - segmentValues segment values.
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendKeySegment(enumValues:[String:(EdmEnumType, String)], segmentValues:[String: AnyObject]) -> URIBuilder
  

   /// Appends Singleton segment to the URI.
   /// - parameters:
   ///  - segmentValue: segment value.
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendSingletonSegment(segmentValue:String) -> URIBuilder
  

   /// Appends entity-id segment to the URI.
   /// - parameters:
   ///  - segmentValue: segment value
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendEntityIdSegment(segmentValue:String) -> URIBuilder
  

   /// Appends ref segment to the URI.
   /// - parameters:
   ///  - none:
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendRefSegment() -> URIBuilder
  

   /// Appends cross join segment to the URI.
   /// - parameters:
   ///  - segmentValues: segment values.
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendCrossjoinSegment(segmentValues:String...) -> URIBuilder

   

   /// Appends all segment to the URI.
   /// - parameters:
   ///  - none:
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendAllSegment() -> URIBuilder
  

   /// Adds id query option.
   /// - parameters:
   ///  - idValue opaque token.
   /// - returns: current URIBuilder instance

  func id(idValue:String) -> URIBuilder
  

   /// Appends count query option.
   /// - parameters:
   ///  - value: true or false
   /// - returns: current URIBuilder instance

  func count(value:Bool) -> URIBuilder
  
  //TODO: Search
   /// Appends search query option.
   /// - parameters:
   ///  - search: search expression
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  //func search(search:URISearch) -> URIBuilder
  

   /// Appends search query option.
   /// - parameters:
   ///  - expression: search expression
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func search(expression:String) -> URIBuilder
  

   /// The set of expanded entities can be refined through the application of expand options, expressed as a
   /// semicolon-separated list of system query options, enclosed in parentheses, see [OData-URL].
   /// - parameters:
   ///  - expandItem: item to be expanded.
   ///  - options: System query options. Allowed query options are: $filter, $select, $orderby, $skip, $top, $count, $search, $expand, and $levels.
   /// - returns: current URIBuilder instance.
   /// - throws: No error conditions are expected
  func expandWithOptions(expandItem:String,options:[QueryOption: AnyObject]) -> URIBuilder
  

   /// The set of expanded entities can be refined through the application of expand options, expressed as a
   /// semicolon-separated list of system query options, enclosed in parentheses, see [OData-URL].
   /// - parameters:
   ///  - expandItem: item to be expanded.
   ///  - pathRef: include the /$ref at the end of the $expand item's path -> URIBuilderif true pathCount MUST be false
   ///  - pathCount: include /$count at the end of the $expand item's path -> URIBuilderif true pathRef MUST be false
   ///  - options: System query options. Allowed query options are: $filter, $select, $orderby, $skip, $top, $count, $search, $expand, and $levels.
   /// - returns: current URIBuilder instance.
   /// - throws: No error conditions are expected
  func expandWithOptions(expandItem:String, pathRef:Bool,pathCount:Bool, options:[QueryOption: AnyObject]) -> URIBuilder
  

   /// Properties of related entities can be specified by including the $select query option within the $expand.
   /// <br />
   /// <tt>http://host/service/Products?$expand=Category($select=Name)</tt>
   /// - parameters:
   ///  - expandItem: related entity name.
   ///  - selectItems: properties to be selected.
   /// - returns: current URIBuilder instance.
   /// - throws: No error conditions are expected
  func expandWithSelect(expandItem:String,selectItems:String...) -> URIBuilder
  

   /// Appends action segment to the URI.
   /// - parameters:
   ///  - action: Action name
   /// - returns: current URIBuilder instance
   /// - throws: No error conditions are expected
  func appendActionCallSegment(action:String) -> URIBuilder
 
 
}

