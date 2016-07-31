/*
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with self work for additional information
  regarding copyright ownership.  The ASF licenses self file
  to you under the Apache License, Version 2.0 (the
  "License") you may not use self file except in compliance
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
//  JsonDeserializer.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 07/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class JsonDeserializer: ODataDeserializer {
  
  // MARK: - Stored Properties

  //TODO: Pattern regex
  //protected final Pattern CUSTOM_ANNOTATION = Pattern.compile("(.+)@(.+)\\.(.+)")
  
  final let serverMode: Bool
  
  // TODO: geoDeserializer: JsonGeoValueDeserializer
  //private var geoDeserializer: JsonGeoValueDeserializer
  
  //private var parser: JsonParser
  
  // MARK: - Computed Properties

  // MARK: - Init
  init(serverMode:Bool) {
    self.serverMode = serverMode
  }

  // MARK: - Methods

  
  public func toEntitySet(input:NSData) throws  -> ResWrap<EntityCollection>? {
    do {
      // we will just pass the json content directly and see if we can handle the json deserializer inside the class
      return try JsonEntitySetDeserializer(serverMode: serverMode).doDeserialize(input)!
      
      //parser = try JsonFactory(ObjectMapper()).createParser(input)
      //return try JsonEntitySetDeserializer(serverMode).doDeserialize(parser)
    }
    catch {
      throw GetODataException.OdataEntitySetFailed
    }
    return nil
  }
  
  
  public func toEntity(input:NSData) throws -> ResWrap<Entity>? {
    do {
      // we will just pass the json content directly and see if we can handle the json deserializer inside the class
      return try JsonEntityDeserializer(serverMode: serverMode).doDeserialize(input)!
      
      //parser = try JsonFactory(ObjectMapper()).createParser(input)
      //return try JsonEntityDeserializer(serverMode: serverMode).doDeserialize(parser)
    }
    catch {
      
    }
    return nil
  }

 
  /// Check for @ char at start of string and prepend if not found
  /// - parameters:
  ///   - string: string to check
  /// - returns: String with @ as inital char
  /// - throws: No error conditions are expected
  func getJSONAnnotation(string:String) -> String {
    if string[string.startIndex] != "@" {
      return "@" + string
    }
    return string
  }
  
  // TODO: Annotatable
  func populate(inout properties:[Property],data:[String:AnyObject]) throws {
  //func populate(annotatable:Annotatable,properties:[Property],tree:ObjectNode,codec:ObjectCodec) throws {
  
      var type:String = ""
      // TODO: Annotations
      //var annotation:Annotation = nil
    
    // swift dictionary is unsorted so need to get teh data into a sorted order to esnure 
    // that the value type key value pair if it exists is before the actual value

    let sortedDataKeys = Array(data.keys).sort(>)
      
    for key in sortedDataKeys {
      
      guard let value = data[key] else {
        throw IllegalArgumentException.NilOrEmptyString
      }
        
        // TODO: Annotations
        /*
        let customAnnotation:Matcher  = CUSTOM_ANNOTATION.matcher(key)
  
        if (key[key.startIndex] == "@" ) {
          let entityAnnot:Annotation = Annotation()
          entityAnnot.term(key.substringFromIndex(key.startIndex.advancedBy(1)))
            value(entityAnnot, value)
            //value(entityAnnot, field.getValue(), codec)
            if (annotatable != nil) {
              annotatable.annotations.append(entityAnnot)
            }
        }
         else if (type.isEmpty && key.endsWith(getJSONAnnotation(JSON_TYPE))) {
         */
        
        if (type.isEmpty && key.endsWith(getJSONAnnotation(JSON_TYPE))) {
          type = String(value)
        }
        else if key.endsWith(getJSONAnnotation(JSON_COUNT)) {
          let property = Property()
          property.name = key
          property.setValue(ValueType.PRIMITIVE, value: Int(value as! NSNumber) as AnyObject)

          properties.append(property)
        }
        // TODO: Annotations
        /*
        else if (annotation == nil && customAnnotation.matches() && !"odata".equals(customAnnotation.group(2))) {
          let annotation = Annotation()
          annotation.term(customAnnotation.group(2) + "." + customAnnotation.group(3))
          value(annotation, value)
        }
        */
        else {
          let property = Property()
          property.name = key
          if type.isEmpty {
            property.type = ""
          }
          else {
            property.type = EdmTypeInfo.Builder().setTypeExpression(type).build()!.internalToString()
          }
          
          type = ""
          do {
            try calcValue(property, value: value)
          }
          catch {
            
          }
          //value(property, field.getValue(), codec)
          if let pval = property.value {
            log.debug("Property name: \(property.name)  Value: \(pval)")
          }
          else {
            log.debug("Property name: \(property.name)  Value: nil")
          }
          
          properties.append(property)
          log.debug( "Number of properties: \(properties.count)")
          // TODO: Annotations
          /*
          if (annotation != nil) {
            property.annotations.append(annotation)
            annotation = nil
          }
           */
        }
      }
    }
  
  
  func calcValue(valuable:Valuable , value:AnyObject ) throws {
    
    // func value(valuable:Valuable , node:JsonNode ,codec: ObjectCodec ) throws {
    var  typeInfo:EdmTypeInfo?
    let guessed = guessPropertyType(value)
    var keyGuess:PropertyType? = nil
    var valueGuess:EdmTypeInfo? = nil
    var propType = PropertyType.EMPTY
    
    if valuable.type.isEmpty {
      typeInfo = nil
    }
    else {
      typeInfo = EdmTypeInfo.Builder().setTypeExpression(valuable.type).build()
    }
    
    for (key,value) in guessed {
      keyGuess = key
      valueGuess = value
    }
    
    if let typeInfo = typeInfo {
      if typeInfo.isCollection  {
        propType = PropertyType.COLLECTION
      }
      else if typeInfo.isPrimitiveType {
        propType = PropertyType.PRIMITIVE
      }
        // TODO: .isValueNode
        /*
         else if node.isValueNode != nil {
         propType = PropertyType.ENUM
         }
         */
      else {
        propType = PropertyType.COMPLEX
      }
    }
    else {
      typeInfo = valueGuess
      if keyGuess != nil {
        propType = keyGuess!
      }
      else {
        propType = PropertyType.PRIMITIVE
      }
    }
      
     /*
    if (typeInfo == nil) {
      
      
    }
    else {
      
    }
 */
    
    
    switch (propType) {
    case PropertyType.COLLECTION:
      // TODO: Coolections
      //fromCollection(valuable, node.elements(), typeInfo, codec)
      break
      
    case PropertyType.COMPLEX:
      //TODO: Complex types
      /*
      if (node.has(JSON_TYPE)) {
        valuable.setType(node.get(JSON_TYPE).asText())
        ((ObjectNode) node).remove(JSON_TYPE)
      }
      let value:AnyObject = fromComplex((ObjectNode) node, codec)
      valuable.setValue(ValueType.COMPLEX, value: value)
      */
      break
      
    case PropertyType.ENUM:
      valuable.setValue(ValueType.ENUM, value: String (value))
      break
      
    case PropertyType.PRIMITIVE:
      if (valuable.type.isEmpty && typeInfo != nil) {
        valuable.type = typeInfo!.fullQualifiedName.toString()
      }
      do {
        if let primitiveValue = try fromPrimitive(value, typeInfo: typeInfo) {
          valuable.setValue(primitiveValue is Geospatial ? ValueType.GEOSPATIAL : ValueType.PRIMITIVE, value: primitiveValue)
        }
        else {
          valuable.setValue(ValueType.PRIMITIVE, value: "")
        }
        break
      }
      catch {
        valuable.setValue(ValueType.PRIMITIVE, value: "")
        break
      }
    case PropertyType.EMPTY:
      valuable.setValue(ValueType.PRIMITIVE, value: "")
      break
    default:
      valuable.setValue(ValueType.PRIMITIVE, value: "")
    }
    
  }
  
    private func guessPropertyType(node:AnyObject) -> [PropertyType: EdmTypeInfo] {
      let type: PropertyType
      
      var typeInfo:EdmTypeInfo? = nil
      var typeExpression:String = ""
      var entry:[PropertyType:EdmTypeInfo] = [:]
      // TODO:
      // use this as a default to start with till we get it working properly
      type = PropertyType.PRIMITIVE
      typeExpression = guessPrimitiveTypeKind(node).getFullQualifiedName().toString()
      /*
      if (node.isValueNode || node == nil) {
        type = PropertyType.PRIMITIVE
        typeExpression = guessPrimitiveTypeKind(value).fullQualifiedName.toString()
      }
      else if (node.isArray) {
        type = PropertyType.COLLECTION
        if (node.has(0) && node.get(0).isValueNode()) {
          typeExpression = "Collection(" + guessPrimitiveTypeKind(value) + ")"
        }
      }
      else if (node.isObject()) {
        if (node.has(ATTR_TYPE)) {
          type = PropertyType.PRIMITIVE
          typeExpression = "Edm.Geography" + node.get(ATTR_TYPE).asText()
        } else {
          type = PropertyType.COMPLEX
        }
      }
 
      else {
        type = PropertyType.EMPTY
      }
 */
      if !typeExpression.isEmpty {
        typeInfo = EdmTypeInfo.Builder().setTypeExpression(typeExpression).build()
        if typeInfo == nil {
          log.warn("typeInfo value nil")
        }
      }
      // if typeinfo is nil then no entry is added to the dictionary (or the entry for the key will be removed)
      entry[type] = typeInfo
        
      return entry
    }

    private func guessPrimitiveTypeKind(value:AnyObject) -> EdmPrimitiveTypeKind {
      
      let valueStr = String(value)
      if !valueStr.isEmpty {
        if valueStr.caseInsensitiveCompare("true") == NSComparisonResult.OrderedSame || valueStr.caseInsensitiveCompare("false") == NSComparisonResult.OrderedSame {
          return EdmPrimitiveTypeKind.BOOLEAN
        }
        
        let nf = NSNumberFormatter()
        guard let nsNum = nf.numberFromString(valueStr) else {
          return EdmPrimitiveTypeKind.STRING
        }
        let idx = valueStr.rangeOfString(".")?.startIndex
        if idx != nil {
          // its a float or a double
          let flt:Float = nsNum.floatValue
          if flt.isInfinite {
            return EdmPrimitiveTypeKind.DOUBLE
          }
          else {
            return EdmPrimitiveTypeKind.SINGLE
          }
        }
        else {
          if nsNum.integerValue == -9223372036854775808 {
            return EdmPrimitiveTypeKind.DECIMAL
          }
          else {
            if nsNum.intValue > Int32.max {
              return EdmPrimitiveTypeKind.INT64
            }
            return EdmPrimitiveTypeKind.INT32
          }
        }
      }
      else {
        return EdmPrimitiveTypeKind.STRING
      }

      // original olingo using jackson library for JSON
      //  private func guessPrimitiveTypeKind(node:JsonNode) -> EdmPrimitiveTypeKind {
      //    return node.isShort() ? EdmPrimitiveTypeKind.Int16 :
      //      node.isInt() ? EdmPrimitiveTypeKind.Int32 :
      //      node.isLong() ? EdmPrimitiveTypeKind.Int64 :
      //      node.isBoolean() ? EdmPrimitiveTypeKind.Boolean :
      //      node.isFloat() ? EdmPrimitiveTypeKind.Single :
      //      node.isDouble() ? EdmPrimitiveTypeKind.Double :
      //      node.isBigDecimal() ? EdmPrimitiveTypeKind.Decimal :
      //      EdmPrimitiveTypeKind.String
      //  }

    }
  
  // TODO: func fromPrimitive(node:JsonNode,typeInfo:EdmTypeInfo) throws -> AnyObject
    private func fromPrimitive(node:AnyObject?,typeInfo:EdmTypeInfo?) throws -> AnyObject? {
      guard let node = node else {
        return nil
      }
      
      guard let typeInfo = typeInfo else {
        return String(node)
      }
      // TODO : geo
      /*
       if typeInfo!.primitiveTypeKind.isGeospatial {
       return getGeoDeserializer().deserialize(node, typeInfo)
       }
       */
      do {
        //let pType = typeInfo.type as! EdmString
        //let pClass = pType.dynamicType
        
        let primType = typeInfo.type as! EdmPrimitiveType
        let swiftType = primType.defaultType
        //let primClass = primType.dynamicType
        log.debug(" value: \(String(node)) of type \(node.dynamicType)")
        if let swiftValue = try primType.valueOfString(String(node), isnilable: true, maxLength: nil,precision: DEFAULT_PRECISION, scale: DEFAULT_SCALE, isUnicode: true,returnType: swiftType) {
          log.debug(" value: \(String(swiftValue)) of type \(swiftValue.dynamicType)")
          return swiftValue as? AnyObject
        }
        else {
          return nil
        }
        
        
        
        // TODO: need to come back to cast to specific primitive type
        
          let nd = String(node)
          return String(node)
        
        
        //return typeInfo!.type.valueOfString(String(value), true, nil,DEFAULT_PRECISION, DEFAULT_SCALE, true,typeInfo.type as EdmPrimitiveType).getDefaultType() as EdmPrimitiveType
      }
      catch {
        // TODO:
      }
      //}
      
      return nil
      //return node.isnil() ? nil: typeInfo == nil ? node.asText(): typeInfo.getPrimitiveTypeKind().isGeospatial()? getGeoDeserializer().deserialize(node, typeInfo): ((EdmPrimitiveType) typeInfo.getType()).valueOfString(node.asText(), true, nil,Constants.DEFAULT_PRECISION, Constants.DEFAULT_SCALE, true,((EdmPrimitiveType) typeInfo.getType()).getDefaultType())

    }

  
  
  //TODO: func getGeoDeserializer() -> JsonGeoValueDeserializer
//  private func getGeoDeserializer() -> JsonGeoValueDeserializer {
//    if (geoDeserializer == nil) {
//      geoDeserializer = JsonGeoValueDeserializer()
//    }
//    return geoDeserializer
//  }
  

  
  //TODO: func getTitle(entry:[String:JsonNode) -> String
  /*
  func getTitle(entry:[String:JsonNode]) -> String {
    return entry.getKey().substring(0, entry.getKey().indexOf("@"))
  }
 */
 
  
  //TODO: func setInline(name:String,suffix:String,tree:JsonNode,codec:ObjectCodec, link:Link) throws  -> String 
  /*
  func setInline(name:String,suffix:String,tree:JsonNode,codec:ObjectCodec, link:Link) throws  -> String {
    final let entityNamePrefix:String = name.substring(0, name.indexOf(suffix))
    var count:Int = -1
    
    if (tree.hasNonnil(entityNamePrefix+JSON_COUNT)) {
      count = tree.get(entityNamePrefix+JSON_COUNT).asInt()
    }
                              
    if (tree.has(entityNamePrefix)) {
      final inline = tree.path(entityNamePrefix)
      let entityDeserializer = JsonEntityDeserializer(serverMode)
                                
      if (inline instanceof ObjectNode) {
        link.type = ENTITY_NAVIGATION_LINK_TYPE
        link.inlineEntitySet = entityDeserializer.doDeserialize(inline.traverse(codec)).getPayload()
      }
      else if (inline instanceof ArrayNode) {
        link.type = ENTITY_SET_NAVIGATION_LINK_TYPE
        let entitySet = EntityCollection()
        if (count > -1) {
          entitySet.count = count
        }
        for (final Iterator<JsonNode> entries = inline.elements() entries.hasNext()) {
          entitySet.entities.append(entityDeserializer.doDeserialize(entries.next().traverse(codec)).getPayload())
        }
        link.inlineEntitySet = entitySet
      }
    }
    return entityNamePrefix
  }
 */
  
  //TODO: func links(field:[String:JsonNode],linked:Linked,toRemove:[String], tree:JsonNode,  codec:ObjectCodec)
//  func links(field:[String:JsonNode],linked:Linked,toRemove:[String], tree:JsonNode,  codec:ObjectCodec) throws {
//    if (serverMode) {
//      serverLinks(field, linked, toRemove, tree, codec)
//    }
//    else {
//      clientLinks(field, linked, toRemove, tree, codec)
//    }
//  }
  
  //TODO: func clientLinks(field:[String:JsonNode], linked:Linked,toRemove:[String], tree:JsonNode,  codec:ObjectCodec)
//  private func clientLinks(field:[String:JsonNode], linked:Linked,toRemove:[String], tree:JsonNode,  codec:ObjectCodec) throws {
//    
//    if (field.getKey().endsWith(JSON_NAVIGATION_LINK)) {
//      let link = Link()
//      link.title = getTitle(field)
//      link.rel = NS_NAVIGATION_LINK_REL + getTitle(field)
//      
//      if (field.getValue().isValueNode()) {
//        link.href = field.getValue().textValue()
//        link.type = ENTITY_NAVIGATION_LINK_TYPE
//      }
//      
//      linked.getNavigationLinks().add(link)
//      
//      toRemove.append(field.getKey())
//      toRemove.append(setInline(field.getKey(), JSON_NAVIGATION_LINK, tree, codec, link))
//    }
//    else if (field.getKey().endsWith(JSON_ASSOCIATION_LINK)) {
//      let link = Link()
//      link.title = getTitle(field)
//      link.rel = NS_ASSOCIATION_LINK_REL + getTitle(field)
//      link.href = field.getValue().textValue()
//      link.type = ASSOCIATION_LINK_TYPE
//      linked.associationLinks.append(link)
//      
//      toRemove.append(field.getKey())
//    }
//  }
  
  //TODO: func serverLinks(field:[String:JsonNode], linked:Linked,toRemove:[String], tree:JsonNode,  codec:ObjectCodec)
//  private func serverLinks(field:[String:JsonNode], linked:Linked,toRemove:[String], tree:JsonNode,  codec:ObjectCodec) throws {
//    
//    if (field.getKey().endsWith(JSON_BIND_LINK_SUFFIX) || field.getKey().endsWith(Constants.JSON_NAVIGATION_LINK)) {
//      if (field.getValue().isValueNode()) {
//        let suffix = field.getKey().replaceAll("^.*@", "@")
//        let link = Link()
//        link.title = getTitle(field)
//        link.rel = NS_NAVIGATION_LINK_REL + getTitle(field)
//        link.href = field.getValue().textValue()
//        link.type = ENTITY_NAVIGATION_LINK_TYPE
//        linked.getNavigationLinks().add(link)
//        
//        toRemove.append(setInline(field.getKey(), suffix, tree, codec, link))
//      }
//      else if (field.getValue().isArray()) {
//        for (final Iterator<JsonNode> itor = field.getValue().elements() itor.hasNext()) {
//          node = itor.next()
//          
//          link = Link()
//          link.title = getTitle(field)
//          link.rel = NS_NAVIGATION_LINK_REL + getTitle(field)
//          link.href = node.asText()
//          link.type = ENTITY_SET_NAVIGATION_LINK_TYPE
//          linked.getNavigationLinks().add(link)
//          toRemove.append(setInline(field.getKey(), JSON_BIND_LINK_SUFFIX, tree, codec, link))
//        }
//      }
//      toRemove.append(field.getKey())
//    }
//  }
  
  

  
  
  
  // TODO: func fromComplex(node:ObjectNode , codec:ObjectCodec)
//  private func fromComplex(node:ObjectNode , codec:ObjectCodec)
//  throws -> AnyObject {
//    
//    final ComplexValue complexValue = new ComplexValue()
//    final Set<String> toRemove = new HashSet<String>()
//    for (final Iterator<Map.Entry<String, JsonNode>> itor = node.fields() itor.hasNext()) {
//      final Map.Entry<String, JsonNode> field = itor.next()
//      
//      links(field, complexValue, toRemove, node, codec)
//    }
//    node.remove(toRemove)
//    
//    populate(complexValue, complexValue.getValue(), node, codec)
//    return complexValue
//  }
  
  // TODO: func fromCollection(valuable:Valuable ,nodeItor:Iterator<JsonNode>, typeInfo:EdmTypeInfo,codec: ObjectCodec)
//  private func fromCollection(valuable:Valuable ,nodeItor:Iterator<JsonNode>, typeInfo:EdmTypeInfo,codec: ObjectCodec) throws {
//    final List<Object> values = new ArrayList<Object>()
//    ValueType valueType = ValueType.COLLECTION_PRIMITIVE
//    
//    final EdmTypeInfo type = typeInfo == nil ? nil
//      : new EdmTypeInfo.Builder().setTypeExpression(typeInfo.getFullQualifiedName().toString()).build()
//    
//    while (nodeItor.hasNext()) {
//      final JsonNode child = nodeItor.next()
//      
//      if (child.isValueNode()) {
//        if (typeInfo == nil || typeInfo.isPrimitiveType()) {
//          final Object value = fromPrimitive(child, type)
//          valueType = value instanceof Geospatial ? ValueType.COLLECTION_GEOSPATIAL : ValueType.COLLECTION_PRIMITIVE
//          values.add(value)
//        } else {
//          valueType = ValueType.COLLECTION_ENUM
//          values.add(child.asText())
//        }
//      } else if (child.isContainerNode()) {
//        if (child.has(Constants.JSON_TYPE)) {
//          ((ObjectNode) child).remove(Constants.JSON_TYPE)
//        }
//        final Object value = fromComplex((ObjectNode) child, codec)
//        valueType = ValueType.COLLECTION_COMPLEX
//        values.add(value)
//      }
//    }
//    valuable.setValue(valueType, values)
//  }
  
  
  
// TODO: func toProperty(input:NSData) throws -> ResWrap<Property>
/*
  public func toProperty(input:NSData) throws -> ResWrap<Property> {
    do {
      // we will just pass the json content directly and see if we can handle the json deserializer inside the class
      return try JsonPropertyDeserializer(serverMode: serverMode).doDeserialize(input)!
      // parser = try JsonFactory(ObjectMapper()).createParser(input)
      // return try JsonPropertyDeserializer(serverMode).doDeserialize(parser)
    }
    catch {

    }
  }
  */
 
  
  // TODO: func toError(input:NSData) throws -> ODataError
  /*
  public func toError(input:NSData) throws -> ODataError {
    do {
      parser = try JsonFactory(ObjectMapper()).createParser(input)
      return try JsonODataErrorDeserializer(serverMode).doDeserialize(parser)
    }
    catch {
      
    }
  }
 */
}
