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
//  ContentType.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 28/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


/// Internally used `ContentType` for OData library.
 ///
 /// For more details on format and content of a `ContentType` see
 /// `Media Type` format as defined in
 /// [RFC 7231, chapter 3.1.1.1.](http://www.ietf.org/rfc/rfc7231.txt)
 /// ````
 /// media-type = type "/" subtype *( OWS "" OWS parameter )
 /// type = token
 /// subtype = token
 /// OWS = *( SP / HTAB )  optional whitespace
 /// parameter = token "=" ( token / quoted-string )
 /// ````
 ///
 /// Once created a `ContentType` is **IMMUTABLE**

public final class ContentType {
  
  // MARK: - Stored Properties

  private static let APPLICATION:String = "application"
  private static let TEXT:String = "text"
  private static let MULTIPART:String = "multipart"
  
  public static let PARAMETER_CHARSET:String = "charset"
  public static let PARAMETER_IEEE754_COMPATIBLE:String = "IEEE754Compatible"
  public static let PARAMETER_ODATA_METADATA:String = "odata.metadata"
  
  public static let VALUE_ODATA_METADATA_NONE:String = "none"
  public static let VALUE_ODATA_METADATA_MINIMAL:String = "minimal"
  public static let VALUE_ODATA_METADATA_FULL:String = "full"
  
  public static let APPLICATION_JSON = ContentType(conType: APPLICATION, conSubtype: "json")
  
  public static let JSON = ContentType(conType:APPLICATION_JSON!.type,conSubtype:APPLICATION_JSON!.subtype, parameterName: PARAMETER_ODATA_METADATA, parameterValue: VALUE_ODATA_METADATA_MINIMAL)
  public static let JSON_NO_METADATA = ContentType(conType: APPLICATION_JSON!.type,conSubtype: APPLICATION_JSON!.subtype,parameterName: PARAMETER_ODATA_METADATA, parameterValue: VALUE_ODATA_METADATA_NONE)
  public static let JSON_FULL_METADATA = ContentType(conType:APPLICATION_JSON!.type,conSubtype: APPLICATION_JSON!.subtype,parameterName: PARAMETER_ODATA_METADATA, parameterValue: VALUE_ODATA_METADATA_FULL)
  
  public static let APPLICATION_XML = ContentType(conType: APPLICATION, conSubtype: "xml")
  public static let APPLICATION_ATOM_XML = ContentType(conType: APPLICATION, conSubtype: "atom+xml")
  
  public static let APPLICATION_ATOM_XML_ENTRY = ContentType(conType:APPLICATION_ATOM_XML!.type,conSubtype: APPLICATION_ATOM_XML!.subtype, parameterName: "type", parameterValue: "entry")
  public static let APPLICATION_ATOM_XML_ENTRY_UTF8 = ContentType(conType:APPLICATION_ATOM_XML_ENTRY!.type,conSubtype: APPLICATION_ATOM_XML_ENTRY!.subtype,parameterName: PARAMETER_CHARSET, parameterValue: "utf-8")
  public static let APPLICATION_ATOM_XML_FEED = ContentType(conType:APPLICATION_ATOM_XML!.type,conSubtype: APPLICATION_ATOM_XML!.subtype, parameterName: "type", parameterValue: "feed")
  public static let APPLICATION_ATOM_XML_FEED_UTF8 = ContentType(conType:APPLICATION_ATOM_XML_FEED!.type,conSubtype: APPLICATION_ATOM_XML_FEED!.subtype,parameterName: PARAMETER_CHARSET, parameterValue: "utf-8")
  
  public static let APPLICATION_ATOM_SVC = ContentType(conType: APPLICATION, conSubtype: "atomsvc+xml")
  public static let APPLICATION_OCTET_STREAM = ContentType(conType: APPLICATION, conSubtype: "octet-stream")
  public static let APPLICATION_XHTML_XML = ContentType(conType: APPLICATION, conSubtype: "xhtml+xml")
  public static let TEXT_HTML = ContentType(conType: TEXT, conSubtype: "html")
  public static let TEXT_XML = ContentType(conType: TEXT, conSubtype: "xml")
  public static let TEXT_PLAIN = ContentType(conType: TEXT, conSubtype: "plain")
  public static let APPLICATION_SVG_XML = ContentType(conType: APPLICATION, conSubtype: "svg+xml")
  public static let APPLICATION_FORM_URLENCODED = ContentType(conType: APPLICATION, conSubtype: "x-www-form-urlencoded")
  public static let APPLICATION_HTTP =  ContentType(conType: APPLICATION,conSubtype: "http")
  public static let MULTIPART_MIXED = ContentType(conType: MULTIPART, conSubtype: "mixed")
  public static let MULTIPART_FORM_DATA =  ContentType(conType: MULTIPART, conSubtype: "form-data")
  
  private var type:String = ""
  private var subtype:String = ""
  private var parameters:[String:String] = ["":""]
  
  private struct TypeSubTypeParams {
    var typeSubType:[String]
    var parameters:[String:String]
  }
  
  // MARK: - Computed Properties


  // MARK: - Init
  
  /// Initialises a content type from type, subtype, and optional parameters
  /// (Overload available for adding a single paramter name & value)
  /// - parameters:
  ///   - ctype: content type
  ///   - csubtype: content subtype
  ///   - parameters: Dictionary of values defaults to [:]
  /// - returns: a new `ContentType` object
  /// - throws: Fails to instantiate if error caught
  init?(conType:String,conSubtype:String,parameters:[String:String]=[:]) {
    do {
      self.type = try validateType(conType)
      self.subtype = try validateType(conSubtype)
      self.parameters = parameters
    }
    catch {
      return nil
    }
  }
  
  /// Initialises a content type from type, subtype, single parameter name and value
  /// (Overload available adding an optional parameter dictionary )
  /// - parameters:
  ///   - conType: TBC
  ///   - conSubtype: TBC
  ///   - parameterName : Name of parameter key value pair
  ///   - parameterValue : Value of parameter key value pair
  /// - returns: a new `ContentType` object
  /// - throws: Fails to instantiate if error caught
  init?(conType:String,conSubtype:String,parameterName:String,parameterValue:String) {
    do {
      try TypeUtil.validateParameterNameAndValue(parameterName, parameterValue: parameterValue)
      self.type = try validateType(conType)
      self.subtype = try validateType(conSubtype)
      self.parameters[parameterName.lowercaseStringWithLocale(NSLocale.systemLocale())] = parameterValue
    }
    catch {
      return nil
    }
  }
  
  // MARK: - Methods
  
  /// Validate the type string and throw error if its nil, empty, equals the * wildcard
  /// or containes whitespace
  /// - parameters:
  ///   - type: optional string
  /// - returns: type as an optional string
  /// - throws: Illegal Argument Exceptions
  private func validateType(type:String) throws -> String{
    
    if type.isEmpty ?? true {
      throw IllegalArgumentException.NilOrEmptyString  //throw IllegalArgumentException("Illegal type (nil or empty)" + type + ".")
    }
    if type == "*" {
      throw IllegalArgumentException.ContainsWildCard //throw IllegalArgumentException("Illegal type (*)" + type + ".")
    }
    if (type.rangeOfCharacterFromSet(NSCharacterSet.whitespaceCharacterSet())) != nil {
      throw IllegalArgumentException.ContainsWhiteSpace //throw new IllegalArgumentException("Illegal whitespace found for type '" + type + "'.")
    }
    return type
  }
  
   
  /// Creates a content type from an existing content type and adds an additional parameter as key-value pair
  /// - parameters:
  ///   - contentType: an existing content type
  ///   - parameterName: the name of the additional parameter add or remove params from list as required
  ///   - parameterValue: the value of the additional parameter  
  /// - returns: a new `ContentType` object
  /// - throws: Propogates illegal exception errors from called methods
  
  //renamed to createFromExisting from create to provide more meaningful name
  public static func createFromExisting(contentType:ContentType,parameterName:String,parameterValue:String)  throws -> ContentType {
    do {
      try TypeUtil.validateParameterNameAndValue(parameterName, parameterValue: parameterValue)
      
      guard let ct = ContentType(conType: contentType.type, conSubtype: contentType.subtype, parameters: contentType.parameters) else {
        throw ClassInitialisationException.InitialisationFailed
      }
      ct.parameters[parameterName.lowercaseStringWithLocale(NSLocale.systemLocale())] = parameterValue
      return contentType
    }
    
  }
  

  /// Creates a `ContentType` based on given input string (`format`). Supported format is
  ///  `Media Type` format as defined in RFC 7231, chapter 3.1.1.1.
  /// - parameters:
  ///   - format: a string in format as defined in RFC 7231, chapter 3.1.1.1
  /// - returns: a new `ContentType` object
  /// - throws: IllegalArgumentException if input string is not parseable
  public static func create(format:String?) throws -> ContentType {
    if format?.isEmpty ?? true {
      throw IllegalArgumentException.NilOrEmptyString //if (format == nil) {throw IllegalArgumentException("Parameter format MUST NOT be nil.")
    }
    do {
      let typeSubTypeParams = try parseFormat(format!)
      guard let newContent = ContentType(conType:typeSubTypeParams.typeSubType[0], conSubtype: typeSubTypeParams.typeSubType[1], parameters: typeSubTypeParams.parameters) else {
        throw ClassInitialisationException.InitialisationFailed
      }
      return newContent
    }
    
  }
  
  
  /// Parses the given input string (`format`) and returns created `ContentType` if input was valid or
  /// return `nil` if input was not parseable.
  /// For the definition of the supported format see {@link #create(String)}.
  /// - parameters:
  ///   - format: a string in format as defined in RFC 7231, chapter 3.1.1.1
  /// - returns: a new `ContentType` object
  /// - throws: No error conditions are expected
  public static func parse(format:String?) -> ContentType? {
    do {
      let newContent = try ContentType.create(format)
      return newContent
    }
    catch is IllegalArgumentException{
      return nil
    }
    catch {
      return nil
    }
  }
  
  /// Split format string into type & subtype and parameters
  /// - parameters:
  ///   - format : a string in format as defined in RFC 7231, chapter 3.1.1.1
  ///   - typeSubType: an array of strings (modifiable)
  ///   - parameters: set of key value pairs (modifiable)
  /// - returns: No return value (void)
  /// - throws: IllegalArgumentException if input string is not parseable
  private static func parseFormat(format:String) throws -> TypeSubTypeParams {
    
    var types:String = ""
    var params:String = ""
    
    // split string into 2 parts, type & subtypes + parameters
    if let idx = format.rangeOfString(TypeUtil.PARAMETER_SEPARATOR)?.startIndex {
      types = format.substringToIndex(idx)
      params = format.substringFromIndex(idx.advancedBy(1))
    }
    else
    {
      types = format
    }
    var typeSubTypeParams = TypeSubTypeParams(typeSubType: [],parameters: [:])
    if (types.rangeOfString(TypeUtil.TYPE_SUBTYPE_SEPARATOR) != nil) {
      let tokens:[String] = types.componentsSeparatedByString(TypeUtil.TYPE_SUBTYPE_SEPARATOR)
      if tokens.count == 2 {
        if tokens[0].isEmpty {
          throw IllegalArgumentException.InvalidFormat //"No type found in format '"
        }
        else if tokens[1].isEmpty {
          throw IllegalArgumentException.InvalidFormat //"No subtype found in format '"
        }
        else {
          typeSubTypeParams.typeSubType.append(tokens[0])
          typeSubTypeParams.typeSubType.append(tokens[1])
        }
      }
      else {
        throw IllegalArgumentException.InvalidFormat // "Too many '" + TypeUtil.TYPE_SUBTYPE_SEPARATOR + "' in format '" + format"
      }
    }
    else {
      throw IllegalArgumentException.InvalidFormat //"No separator '" + TypeUtil.TYPE_SUBTYPE_SEPARATOR+ "' was found in format "
    }
    do {
      try TypeUtil.parseParameters(params, parameterDictionary: &typeSubTypeParams.parameters)
    }
    return typeSubTypeParams
  }

  
  /// Gets the type of this content type.
  /// - parameters:
  ///   - none
  /// - returns: type
  /// - throws: No error conditions are expected
  public func getType() -> String? {
    return type
  }
  
  /// Gets the subtype of this content type.
  /// - parameters:
  ///   - none
  /// - returns: subtype
  /// - throws: No error conditions are expected
  public func getSubtype() -> String? {
    return subtype
  }
  

  /// Gets the parameters of this content type.
  /// - parameters:
  ///   - none
  /// - returns: dictionary of paramater names & values
  /// - throws: No error conditions are expected
  public func getParameters() -> [String:String]{
    return parameters
  }
  
  
  /// Returns the value of a given parameter forced to lowercase based on system (no specific) locale
  /// - parameters:
  ///   - name: the name of the parameter to get (case-insensitive)
  /// - returns: the value of the parameter or `nil` if the parameter is not present
  /// - throws: No error conditions are expected
  public func getParameter(name:String) -> String? {
    
    guard let value = parameters[name]
      where value.characters.count>0 else {
        return nil
    }
    return parameters[name]!.lowercaseStringWithLocale(NSLocale.systemLocale())  //return parameters.get(name.toLowerCase(Locale.ROOT))
  }
  
  /// Return hashcode
  /// - parameters:
  ///   - none
  /// - returns: hashcode of 1
  /// - throws: No error conditions are expected
  public func hashCode() -> Int {
    return 1
  }
  
  /// `ContentType`s are **compatible** if `type` and `subtype` have the same value
  /// The set `parameters` are **always** ignored (for compare with parameters see ` equals(AnyObject)`)
  /// - parameters:
  ///   - other: ContentType
  /// - returns: `true` if both instances are compatible (see definition above), otherwise `false`
  /// - throws: No error conditions are expected
  public func isCompatible(other:ContentType) -> Bool {
    return (self.type.caseInsensitiveCompare(other.type).rawValue == 0) &&
      (self.subtype.caseInsensitiveCompare(other.subtype).rawValue == 0)  //return type.equalsIgnoreCase(other.type) && subtype.equalsIgnoreCase(other.subtype)
  }
  
   
  /// Checks whether both strings are equal ignoring the case of the strings
  /// - parameters:
  ///   - first: first string
  ///   - second: second string
  /// - returns: `true` if both strings are equal (ignoring the case), otherwise `false`
  /// - throws: No error conditions are expected
  private static func areEqual(first:String?,second:String?)-> Bool {
    
    if let first = first{
      if let second = second {
        return first.caseInsensitiveCompare(second) == .OrderedSame
      }
      else{
        return false
      }
    }
    else{
      if second != nil {
        return false
      }
      else{
        return true
      }
    }
  }
  
  
  /// Gets `ContentType` as string as defined in
  /// [RFC 7231, chapter 3.1.1.1: Media Type](http://www.ietf.org/rfc/rfc7231.txt)
  /// - parameters:
  ///   - none:
  /// - returns: string representation of `ContentType` object
  /// - throws: No error conditions are expected
  public func toContentTypeString()-> String{
    var contentTypeAsString:String = ""
    
    contentTypeAsString = self.type + TypeUtil.TYPE_SUBTYPE_SEPARATOR + subtype
    for (name,value) in parameters {
      if !name.isEmpty {
        contentTypeAsString += TypeUtil.PARAMETER_SEPARATOR + name + TypeUtil.PARAMETER_KEY_VALUE_SEPARATOR + value
      }
    }
    return contentTypeAsString
  }
   
  /// Return the `ContentType` as a string
  /// - parameters:
  ///   - none:
  /// - returns: String representtation of `contentType`
  /// - throws: No error conditions are expected
  public func toString() -> String {
    return toContentTypeString()
  }
}

// MARK: - Extension

extension ContentType:Equatable {}

/// Equality check (equivalent of java isEquals)
/// - parameters:
///   - lhs: object on left of == to compare for equality
///   - rhs: object on right of == to compare for equality
/// - returns: True if objects are equal
/// - throws: No error conditions are expected
public func ==<T>(lhs:ContentType,rhs:T) -> Bool {
  // check right hand side is same class type as lhs
  // do this before casting as we dont want to downcast
  if !(rhs is ContentType) {
    return false
  }
  // cast to lhs type so we can do comparisons
  guard let rhs = rhs as? ContentType else {
    return false
  }
  if lhs === rhs {
    return true
  }
  
  if (!lhs.isCompatible(rhs)) {
    return false
  }
  if (lhs.parameters == rhs.parameters) {
    return true
  }
  else{
    return false
  }
}


