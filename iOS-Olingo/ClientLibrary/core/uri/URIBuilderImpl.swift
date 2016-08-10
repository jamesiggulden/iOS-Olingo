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
//  URIBuilderImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 03/08/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class URIBuilderImpl: URIBuilder {
  
  // MARK: - Stored Properties
  
  
  private final let configuration:Configuration
  
  final var segments:[Segment] = []
  
  /// Insertion-order map of query options.
  final var queryOptions:[String:String] = [:]  // final Map<String, String> queryOptions = new LinkedHashMap<String, String>()
  
  /// Insertion-order map of parameter aliases.
  final var parameters:[String:String] = [:] // final Map<String, String> parameters = new LinkedHashMap<String, String>()

  // MARK: - Computed Properties

  // MARK: - Init

  /// Constructor
  /// - parameters:
  ///   - serviceRoot: absolute URL (schema, host and port included) representing the location of the root of the data
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  public init(configuration:Configuration, serviceRoot:String) {
    self.configuration = configuration
    
    segments.append(Segment(type: SegmentType.SERVICEROOT, value: serviceRoot))
  }
  // MARK: - Methods

  public class Segment {
    
    let type:SegmentType
    let value:String?
    
    internal  init(type:SegmentType,value:String?) {
      self.type = type
      self.value = value
    }
  }
  
  
  /// Adds the specified query option to the URI. Concatenates value if the specified query option already exists.
  /// - parameters:
  ///   - option: query option
  ///   - value: query option value
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func addQueryOption(option:QueryOption , value:String) -> URIBuilder {
    return addQueryOption(option.toString(), value: value, replace: false)
  }
  
  /// Adds/replaces the specified query option to the URI.
  /// - parameters:
  ///   - option: query option
  ///   - value: query option value
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func replaceQueryOption(option:QueryOption , value:String) -> URIBuilder {
    return addQueryOption(option.toString(), value: value, replace: true)
  }
  
  
  /// Adds/Replaces the specified (custom) query option to the URI.
  /// - parameters:
  ///   - option: query option
  ///   - value: query option value
  ///   - replace: if `true` then replace existing value for given option, defaults to false
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func addQueryOption(option:String, value:String,replace:Bool = false) -> URIBuilder {
    var builder:String = ""
    
    if value.isEmpty {
      return self
    }
    
    if let keyValue = queryOptions[option] {
      if !replace {
        builder += (keyValue + ",")
      }
    }
    builder += value
    queryOptions[option] = builder
    return self

  }
  
  
  /// Adds the specified (custom) parameter alias to the URI.
  /// - parameters:
  ///   - alias: parameter alias
  ///   - exp: expression value
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func addParameterAlias(alias:String, exp:String) -> URIBuilder {
    parameters[alias] = exp
    return self
  }
  
  /// Appends EntitySet segment to the URI.
  /// - parameters:
  ///  - segmentValue: segment value.
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func appendEntitySetSegment(segmentValue:String) -> URIBuilder {
    
    if !segmentValue.isEmpty {
      segments.append(Segment(type: SegmentType.ENTITYSET, value: segmentValue))
    }
    return self
  }
  
  
  /// Appends key segment to the URI.
  /// - parameters:
  ///  - val: segment value.
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func appendKeySegment(val:AnyObject) -> URIBuilder {
    
    var segValue:String = String(val)  //URIUtils.escape(val)
    if segValue.isEmpty {
      return self
    }
    
    // replacing any " with ' as Swift usage is normally dbl quotes but Odata expects '
    if segValue.containsString("\"") {
      segValue = segValue.stringByReplacingOccurrencesOfString("\"", withString: "'")
    }
    
    if configuration.keyAsSegment {
      segments.append(Segment(type: SegmentType.KEY_AS_SEGMENT, value: segValue))
    }
    else {
      segments.append(Segment(type: SegmentType.KEY, value: "(" + segValue + ")"))
    }
    return self
  }
  
  
  /// Appends key segment to the URI, for multiple keys.
  /// - parameters:
  ///  - segmentValues: segment values.
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func appendKeySegment(segmentValues:[String:AnyObject]) -> URIBuilder {
    if !configuration.keyAsSegment {
      let key:String = buildMultiKeySegment(segmentValues, escape: true, seperator: ",")
      if key.isEmpty {
        segments.append(Segment(type: SegmentType.KEY, value: noKeysWrapper()))
      } else {
        segments.append(Segment(type: SegmentType.KEY, value: key))
      }
    }
    
    return self
  }
  
  
  /// Appends property segment to the URI.
  /// - parameters:
  ///  - segmentValue segment value.
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func appendPropertySegment(segmentValue:String) -> URIBuilder {
    if !segmentValue.isEmpty {
      segments.append(Segment(type: SegmentType.PROPERTY, value: segmentValue))
    }
    return self
  }
  
  /// Appends navigation segment to the URI.
  /// - parameters:
  ///  - segmentValue: segment value.
  /// - returns: current URIBuilder instance
  public func appendNavigationSegment(segmentValue:String) -> URIBuilder {
    if !segmentValue.isEmpty {
      segments.append(Segment(type: SegmentType.NAVIGATION, value: segmentValue))
    }
    return self
      
  }
  
  
  /// Appends derived entity type segment to the URI.
  /// - parameters:
  ///  - segmentValue: segment value.
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func appendDerivedEntityTypeSegment(segmentValue:String) -> URIBuilder {
    if !segmentValue.isEmpty {
      segments.append(Segment(type: SegmentType.DERIVED_ENTITY_TYPE, value: segmentValue))
    }
    return self
  }
  
  
  /// Appends value segment to the URI.
  /// - parameters:
  ///  - none:
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func appendValueSegment() -> URIBuilder {
    segments.append(Segment(type: SegmentType.VALUE, value: SegmentType.VALUE.rawValue))
    return self
  }
  
  
  /// Appends count segment to the URI.
  ///  - parameters:
  ///  - none:
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func appendCountSegment() -> URIBuilder {
    segments.append(Segment(type: SegmentType.COUNT, value: SegmentType.COUNT.rawValue))
    return self
  }
  
  
  /// Appends operation (action or  function) segment to the URI.
  /// - parameters:
  ///  - operation: Operation (action or  function) name
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func appendOperationCallSegment(operation:String) -> URIBuilder {
    if !operation.isEmpty {
      if segments.count == 1 {
        segments.append(Segment(type: SegmentType.UNBOUND_OPERATION,value: operation))
      }
      else {
        segments.append(Segment(type: SegmentType.BOUND_OPERATION, value: operation))
      }
    }
    return self
  }
  
  
  /// Appends metadata segment to the URI.
  /// - parameters:
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func appendMetadataSegment() -> URIBuilder {
    segments.append(Segment(type: SegmentType.METADATA, value: SegmentType.METADATA.rawValue))
    return self
  }
  
  /// Appends batch segment to the URI.
  /// - parameters:
  ///  - none:
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func appendBatchSegment() -> URIBuilder {
    segments.append(Segment(type: SegmentType.BATCH, value: SegmentType.BATCH.rawValue))
    return self
  }
  
  
  /// Adds count query option.
  /// - parameters:
  ///  - none:
  /// - returns: current URIBuilder instance
  public func count() -> URIBuilder {
    segments.append(Segment(type: SegmentType.ROOT_QUERY_OPTION, value: "$" + QueryOption.COUNT.toString()))
    return self
  }
  
  /// Appends count query option.
  /// - parameters:
  ///  - value: true or false
  /// - returns: current URIBuilder instance
  
  public func count(value:Bool) -> URIBuilder {
    return addQueryOption(QueryOption.COUNT, value: String(value))
  }
  
  
  /// Adds expand query option.
  /// - parameters:
  ///  - expandItems: items to be expanded in-line
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func expand(expandItems:String... ) -> URIBuilder {
      return addQueryOption(QueryOption.EXPAND, value: expandItems.joinWithSeparator(","))
  }
  
  
  /// Adds format query option.
  /// - parameters:
  ///  - format: media type acceptable in a response.
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func format(format:String) -> URIBuilder {
    if format.isEmpty {
      return self
    }
    return replaceQueryOption(QueryOption.FORMAT, value: format)
    
  }
  
  //TODO: filter(filter:URIFilter) -> URIBuilder
  /*
  /// Adds filter for filter query option.
  /// - parameters:
  ///  - filter: filter instance (to be obtained via `FilterFactory`) -> URIBuilder note that 'build()' method will be immediately invoked.
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  func filter(filter:URIFilter) -> URIBuilder {
    let result:URIBuilder
    do {
      // decode in order to support @ in parameter aliases
      result = filter(URLDecoder.decode(filter.build(), UTF8))
    } catch {
      result = filter(filter.build())
    }
    return result
  }
 */
  
  
  /// Adds filter query option.
  /// - parameters:
  ///  - filter: filter string.
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func filter(filter:String) -> URIBuilder {
    if filter.isEmpty {
      return self
    }
    return replaceQueryOption(QueryOption.FILTER, value: filter)
  }
  

  
  /// Adds select query option.
  /// - parameters:
  ///  - selectItems: select items
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func select(selectItems:String...) -> URIBuilder {
      return addQueryOption(QueryOption.SELECT, value: selectItems.joinWithSeparator( ","))
  }
  
  
  /// Overload to orginal select query option to pass in array of Strings
  /// - parameters:
  ///  - selectItems: select items as string array
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func select(selectItems:[String]) -> URIBuilder {
    return addQueryOption(QueryOption.SELECT, value: selectItems.joinWithSeparator( ","))
  }
  
  /// Adds orderby query option.
  /// - parameters:
  ///  - order: order string.
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func orderBy(order:String) -> URIBuilder {
    if order.isEmpty {
      return self
    }
    return replaceQueryOption(QueryOption.ORDERBY, value: order)
  }

  /// Adds top query option.
  /// - parameters:
  ///  - top: maximum number of entities to be returned.
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func top(top:Int) -> URIBuilder {
    return replaceQueryOption(QueryOption.TOP, value: String(top))
  }
  
  
  /// Adds skip query option.
  /// - parameters:
  ///  - skip: number of entities to be skipped into the response.
  /// - returns: current URIBuilder instance
  
  public func skip(skip:Int) -> URIBuilder {
    return replaceQueryOption(QueryOption.SKIP, value: String(skip))
  }
  
  
  /// Adds skiptoken query option.
  /// - parameters:
  ///  - skipToken: opaque token.
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func skipToken(skipToken:String) -> URIBuilder {
    return replaceQueryOption(QueryOption.SKIPTOKEN, value: skipToken)
  }
  
  
  
  /// Build OData URI.
  /// - parameters:
  ///  - none:
  /// - returns: OData URI.
  /// - throws: No error conditions are expected
  public func build() throws -> NSURL {
    var segmentsBuilder:String = ""
    
    for seg in segments {
      if (segmentsBuilder.characters.count > 0 && seg.type != SegmentType.KEY) {
        switch (seg.type) {
        case SegmentType.BOUND_OPERATION:
          segmentsBuilder += getBoundOperationSeparator()
          break
        case SegmentType.BOUND_ACTION:
          segmentsBuilder += getBoundOperationSeparator()
          break
        default:
          if (segmentsBuilder.characters.count > 0 && !segmentsBuilder.endsWith("/")) {
            segmentsBuilder += "/"
          }
        }
      }
      
      if (seg.type == SegmentType.ENTITY) {
        segmentsBuilder += seg.type.rawValue
      } else {
        if let seqVal = seg.value {
          segmentsBuilder += seqVal
        }
      }
      if (seg.type == SegmentType.BOUND_OPERATION || seg.type == SegmentType.UNBOUND_OPERATION) {
        segmentsBuilder += getOperationInvokeMarker()
      }
    }
    
    do {
      if ((queryOptions.count + parameters.count) > 0) {
        segmentsBuilder += "?"
        var list1:[String:String] = [:]
        for (key,value) in queryOptions {
          list1["$" + key] =  value
        }
        for (key,value) in parameters {
          list1["@" + key] =  value
        }
        
        // don't use UriBuilder.build():
        // it will try to call URLEncodedUtils.format(Iterable<>,Charset) method,
        // which works in desktop java application, however, throws NoSuchMethodError in android OS,
        // so here manually construct the URL by its overload URLEncodedUtils.format(List<>,String).
        let queryStr = encodeQueryParameter(list1)
        segmentsBuilder += queryStr
      }
      
      guard let escapedUrl = segmentsBuilder.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) else {
        throw IllegalArgumentException.CouldNotBuildValidURI
      }
      
      guard let url = NSURL(string:escapedUrl) else {
        throw IllegalArgumentException.CouldNotBuildValidURI
      }
      
      
      //let url = NSURL(string: segmentsBuilder)!
      return url
    } catch  {
      throw IllegalArgumentException.CouldNotBuildValidURI //("Could not build valid URI", e)
    }
  }
  
  
  /// Appends enum key segment to the URI.
  /// - parameters:
  ///  - enumType: enum type
  ///  - memberName enum member name
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func appendKeySegment(enumType:EdmEnumType, memberName:String) -> URIBuilder {
    if memberName.isEmpty {
      return self
    }
    return appendKeySegment(enumType.toUriLiteral(memberName)!)
  }
  
  
  /// Appends key segment to the URI, for multiple keys.
  /// - parameters:
  ///  - enumValues: enum segment values.
  ///  - segmentValues segment values.
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func appendKeySegment(enumValues:[String:(EdmEnumType, String)], segmentValues:[String: AnyObject]) -> URIBuilder {
      
    var values:[String:AnyObject] = [:]
    for (key,value) in enumValues {
      values[key] = value.0.toUriLiteral(value.1)
    }
    for (key,value) in segmentValues {
      values[key] = value
    }
    return appendKeySegment(values)
  }
  
  
  /// Appends Singleton segment to the URI.
  /// - parameters:
  ///  - segmentValue: segment value.
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
    public func appendSingletonSegment(segmentValue:String) -> URIBuilder {
      if !segmentValue.isEmpty {
        segments.append(Segment(type: SegmentType.SINGLETON, value: segmentValue))
      }
      return self
    }
  
  
  /// Appends entity-id segment to the URI.
  /// - parameters:
  ///  - segmentValue: segment value
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
    public func appendEntityIdSegment(segmentValue:String) -> URIBuilder {
      if !segmentValue.isEmpty {
        segments.append(Segment(type: SegmentType.ENTITY, value: nil))
      }
      return addQueryOption(QueryOption.ID, value: segmentValue)
    }
  
  
  /// Appends ref segment to the URI.
  /// - parameters:
  ///  - none:
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
    public func appendRefSegment() -> URIBuilder {
      segments.append(Segment(type: SegmentType.REF, value: SegmentType.REF.rawValue))
      return self
    }
  
  
  /// Appends cross join segment to the URI.
  /// - parameters:
  ///  - segmentValues: segment values.
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
    public func appendCrossjoinSegment(segmentValues:String...) -> URIBuilder {
      var segValue:String = ""
      segValue += SegmentType.CROSS_JOIN.rawValue
      segValue += "(" + segmentValues.joinWithSeparator(",") + ")"
      segments.append(Segment(type: SegmentType.CROSS_JOIN, value: segValue))
      return self
    }
  
  
  /// Appends all segment to the URI.
  /// - parameters:
  ///  - none:
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
    public func appendAllSegment() -> URIBuilder {
      segments.append(Segment(type: SegmentType.ALL, value: SegmentType.ALL.rawValue))
      return self
    }
  
  
  /// Adds id query option.
  /// - parameters:
  ///  - idValue opaque token.
  /// - returns: current URIBuilder instance
  
  public func id(idValue:String) -> URIBuilder {
    if idValue.isEmpty {
      return self
    }
    return addQueryOption(QueryOption.ID, value: idValue)
  }
  
  

  
  //TODO: search(search:URISearch) -> URIBuilder 
  /*
  /// Appends search query option.
  /// - parameters:
  ///  - search: search expression
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
    func search(search:URISearch) -> URIBuilder {
        return search(search.build())
    }
 */
  
  
  /// Appends search query option.
  /// - parameters:
  ///  - expression: search expression
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
    public func search(expression:String) -> URIBuilder {
      if expression.isEmpty {
        return self
      }
      return addQueryOption(QueryOption.SEARCH, value: expression)
    }

  
  /// The set of expanded entities can be refined through the application of expand options, expressed as a
  /// semicolon-separated list of system query options, enclosed in parentheses, see [OData-URL].
  /// - parameters:
  ///  - expandItem: item to be expanded.
  ///  - options: System query options. Allowed query options are: $filter, $select, $orderby, $skip, $top, $count, $search, $expand, and $levels.
  /// - returns: current URIBuilder instance.
  /// - throws: No error conditions are expected
    public func expandWithOptions(expandItem:String,options:[QueryOption: AnyObject]) -> URIBuilder {
      if expandItem.isEmpty {
        return self
      }
      return expandWithOptions(expandItem, pathRef: false, pathCount: false, options: options)
    }
  
  
  /// The set of expanded entities can be refined through the application of expand options, expressed as a
  /// semicolon-separated list of system query options, enclosed in parentheses, see [OData-URL].
  /// - parameters:
  ///  - expandItem: item to be expanded.
  ///  - pathRef: include the /$ref at the end of the $expand item's path -> URIBuilderif true pathCount MUST be false
  ///  - pathCount: include /$count at the end of the $expand item's path -> URIBuilderif true pathRef MUST be false
  ///  - options: System query options. Allowed query options are: $filter, $select, $orderby, $skip, $top, $count, $search, $expand, and $levels.
  /// - returns: current URIBuilder instance.
  /// - throws: No error conditions are expected
    public func expandWithOptions(expandItem:String, pathRef:Bool,pathCount:Bool, options:[QueryOption: AnyObject]) -> URIBuilder {
      if expandItem.isEmpty {
        return self
      }
      var _options:[String:AnyObject] = [:]
      for (key,value) in options {
        let optionKey = "$" + key.rawValue
        _options[optionKey] = value
      }
      var path:String = ""
      if pathRef {
        path = "/$ref"
      }
      else {
        if pathCount {
          path = "/$count"
        }
        else {
          path = ""
        }
      }
      return expand(expandItem + buildMultiKeySegment(_options, escape: false, seperator: "") + path)
    }
  
  
  /// Properties of related entities can be specified by including the $select query option within the $expand.
  /// <br />
  /// <tt>http://host/service/Products?$expand=Category($select=Name)</tt>
  /// - parameters:
  ///  - expandItem: related entity name.
  ///  - selectItems: properties to be selected.
  /// - returns: current URIBuilder instance.
  /// - throws: No error conditions are expected
    public func expandWithSelect(expandItem:String,selectItems:String...) -> URIBuilder {
      if expandItem.isEmpty {
        return self
      }
      return expand(expandItem + "($select=" + selectItems.joinWithSeparator(",") + ")")
    }
  
  
  /// Appends action segment to the URI.
  /// - parameters:
  ///  - action: Action name
  /// - returns: current URIBuilder instance
  /// - throws: No error conditions are expected
  public func appendActionCallSegment(action:String) -> URIBuilder {
    if action.isEmpty {
      return self
    }
    if segments.count == 1 {
      segments.append(Segment(type: SegmentType.UNBOUND_ACTION, value: action))
    }
    else {
      segments.append(Segment(type: SegmentType.BOUND_ACTION, value: action))
    }
    return self
  }


  
  private func encodeQueryParameter(list:[String:String]) -> String {
    var builder:String = ""
    
    for (name,value) in list {
      if builder.characters.count > 0 {
        builder += "&"
      }
      builder += name
      builder += "="
      builder += value
      // we dont need to handle encoding till we have built a full URL string
      /*
      builder += Encoder.encode(name)
      builder += "="
      builder += Encoder.encode(value)
 */
    }
    return builder
  }

  
  public func toString() -> String {
    do {
      let url = try build()
      return url.absoluteString  //.toASCIIString()
    }
    catch {
      return ""
    }
  }
  
  func buildMultiKeySegment(segmentValues:[String:AnyObject],escape:Bool, seperator:String) -> String {
    if segmentValues.count == 0 {
      return ""
    }
    else {
      var keyBuilder:String = "("
      for (key,value) in segmentValues {
        keyBuilder += (key + "=")
        if escape {
          keyBuilder += String(value)
          // we dont need to handle esac[e values till we have built a full URL string
          //keyBuilder += URIUtils.escape(value)
        }
        else {
          keyBuilder += String(value)
        }
        keyBuilder += seperator
      }
      keyBuilder = keyBuilder.substringToIndex(keyBuilder.endIndex.advancedBy(-1))
      keyBuilder += ")"
  
      return keyBuilder
    }
  }
  
  
    func noKeysWrapper()-> String {
      return "()"
    }
  
    func getBoundOperationSeparator()-> String {
      return "/"
    }
  
    func getOperationInvokeMarker() -> String {
      return "()"
    }



}

