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

public class JsonDeserializer { // implements ODataDeserializer {
  
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

  //TODO: func getGeoDeserializer() -> JsonGeoValueDeserializer
//  private func getGeoDeserializer() -> JsonGeoValueDeserializer {
//    if (geoDeserializer == nil) {
//      geoDeserializer = JsonGeoValueDeserializer()
//    }
//    return geoDeserializer
//  }
  
//TODO: getJSONAnnotation(string:String) -> String
//  func getJSONAnnotation(string:String) -> String {
//    if string[string.startIndex] != "@" {
//      return "@" + string
//    }
//    return string
//    // return StringUtils.prependIfMissing(string, "@")
//  }
  
  //TODO: func getTitle(entry:[String:JsonNode) -> String
  /*
  func getTitle(entry:[String:JsonNode) -> String {
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
  
  // TODO: func guessPropertyType(node:final JsonNode) -> [PropertyType: EdmTypeInfo]
//  private func guessPropertyType(node:final JsonNode) -> [PropertyType: EdmTypeInfo] {
//    let type: PropertyType
//    var typeExpression:String = ""
//    
//    if (node.isValueNode() || node.isnil()) {
//      type = PropertyType.PRIMITIVE
//      typeExpression = guessPrimitiveTypeKind(node).getFullQualifiedName().toString()
//    }
//    else if (node.isArray()) {
//      type = PropertyType.COLLECTION
//      if (node.has(0) && node.get(0).isValueNode()) {
//        typeExpression = "Collection(" + guessPrimitiveTypeKind(node.get(0)) + ")"
//      }
//    }
//    else if (node.isObject()) {
//      if (node.has(Constants.ATTR_TYPE)) {
//        type = PropertyType.PRIMITIVE
//        typeExpression = "Edm.Geography" + node.get(ATTR_TYPE).asText()
//      } else {
//        type = PropertyType.COMPLEX
//      }
//    }
//    else {
//      type = PropertyType.EMPTY
//    }
//    
//    typeInfo = typeExpression == nil ? nil : new EdmTypeInfo.Builder().setTypeExpression(typeExpression).build()
//    return SimpleEntry<PropertyType, EdmTypeInfo>(type, typeInfo)
//  }
  
  //TODO: func guessPrimitiveTypeKind(node:JsonNode) -> EdmPrimitiveTypeKind
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
  
  //TODO: func populate(annotatable:Annotatable,properties:[Property],tree:ObjectNode,codec:ObjectCodec)
//  func populate(annotatable:Annotatable,properties:[Property],tree:ObjectNode,codec:ObjectCodec)
//  throws {
//    
//    String type = nil
//    Annotation annotation = nil
//    for (final Iterator<Map.Entry<String, JsonNode>> itor = tree.fields() itor.hasNext()) {
//      final Map.Entry<String, JsonNode> field = itor.next()
//      final Matcher customAnnotation = CUSTOM_ANNOTATION.matcher(field.getKey())
//      
//      if (field.getKey().charAt(0) == '@') {
//        final Annotation entityAnnot = new Annotation()
//        entityAnnot.setTerm(field.getKey().substring(1))
//        
//        value(entityAnnot, field.getValue(), codec)
//        if (annotatable != nil) {
//          annotatable.getAnnotations().add(entityAnnot)
//        }
//      } else if (type == nil && field.getKey().endsWith(getJSONAnnotation(Constants.JSON_TYPE))) {
//        type = field.getValue().asText()
//      } else if (field.getKey().endsWith(getJSONAnnotation(Constants.JSON_COUNT))) {
//        final Property property = new Property()
//        property.setName(field.getKey())
//        property.setValue(ValueType.PRIMITIVE, Integer.parseInt(field.getValue().asText()))
//        properties.add(property)
//      } else if (annotation == nil && customAnnotation.matches() && !"odata".equals(customAnnotation.group(2))) {
//        annotation = new Annotation()
//        annotation.setTerm(customAnnotation.group(2) + "." + customAnnotation.group(3))
//        value(annotation, field.getValue(), codec)
//      } else {
//        final Property property = new Property()
//        property.setName(field.getKey())
//        property.setType(type == nil
//          ? nil
//          : new EdmTypeInfo.Builder().setTypeExpression(type).build().internal())
//        type = nil
//        
//        value(property, field.getValue(), codec)
//        properties.add(property)
//        
//        if (annotation != nil) {
//          property.getAnnotations().add(annotation)
//          annotation = nil
//        }
//      }
//    }
//  }
  
  // TODO: func fromPrimitive(node:JsonNode,typeInfo:EdmTypeInfo) throws -> AnyObject
//  private func fromPrimitive(node:JsonNode,typeInfo:EdmTypeInfo) throws -> AnyObject {
//    return node.isnil() ? nil
//      : typeInfo == nil ? node.asText()
//      : typeInfo.getPrimitiveTypeKind().isGeospatial()
//      ? getGeoDeserializer().deserialize(node, typeInfo)
//      : ((EdmPrimitiveType) typeInfo.getType())
//    .valueOfString(node.asText(), true, nil,
//                   Constants.DEFAULT_PRECISION, Constants.DEFAULT_SCALE, true,
//                   ((EdmPrimitiveType) typeInfo.getType()).getDefaultType())
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
  
  // TODO: func value(valuable:Valuable , node:JsonNode ,codec: ObjectCodec )
  /*
  func value(valuable:Valuable , node:JsonNode ,codec: ObjectCodec ) throws {
    
    EdmTypeInfo typeInfo = StringUtils.isBlank(valuable.getType()) ? nil
      : new EdmTypeInfo.Builder().setTypeExpression(valuable.getType()).build()
    
    final Map.Entry<PropertyType, EdmTypeInfo> guessed = guessPropertyType(node)
    if (typeInfo == nil) {
      typeInfo = guessed.getValue()
    }
    
    final PropertyType propType = typeInfo == nil ? guessed.getKey()
      : typeInfo.isCollection() ? PropertyType.COLLECTION
      : typeInfo.isPrimitiveType() ? PropertyType.PRIMITIVE
      : node.isValueNode() ? PropertyType.ENUM : PropertyType.COMPLEX
    
    switch (propType) {
    case COLLECTION:
      fromCollection(valuable, node.elements(), typeInfo, codec)
      break
      
    case COMPLEX:
      if (node.has(Constants.JSON_TYPE)) {
        valuable.setType(node.get(Constants.JSON_TYPE).asText())
        ((ObjectNode) node).remove(Constants.JSON_TYPE)
      }
      final Object value = fromComplex((ObjectNode) node, codec)
      valuable.setValue(ValueType.COMPLEX, value)
      break
      
    case ENUM:
      valuable.setValue(ValueType.ENUM, node.asText())
      break
      
    case PRIMITIVE:
      if (valuable.getType() == nil && typeInfo != nil) {
        valuable.setType(typeInfo.getFullQualifiedName().toString())
      }
      final Object primitiveValue = fromPrimitive(node, typeInfo)
      valuable.setValue(primitiveValue instanceof Geospatial ? ValueType.GEOSPATIAL : ValueType.PRIMITIVE,
                        primitiveValue)
      break
      
    case EMPTY:
    default:
      valuable.setValue(ValueType.PRIMITIVE, StringUtils.EMPTY)
    }
  }
 */
  
  public func toEntitySet(input:NSData) throws  -> ResWrap<EntityCollection>? {
    do {
      // we will just pass the json content directly and see if we can handle the json deserializer inside the class
      return try JsonEntitySetDeserializer(serverMode: serverMode).doDeserialize(input)!
      
      //parser = try JsonFactory(ObjectMapper()).createParser(input)
      //return try JsonEntitySetDeserializer(serverMode).doDeserialize(parser)
    }
    catch {
      
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
  
// TODO: func toProperty(input:NSData) throws -> ResWrap<Property>
/*
  public func toProperty(input:NSData) throws -> ResWrap<Property> {
    do {
      parser = try JsonFactory(ObjectMapper()).createParser(input)
      return try JsonPropertyDeserializer(serverMode).doDeserialize(parser)
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
