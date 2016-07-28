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
//  ODataBinderImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 11/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class ODataBinderImpl: ODataBinder {

  // MARK: - Stored Properties

  let client:ODataClient
  private var base:NSURL?
  private var entitySet:ClientEntitySet?
  
  
  // MARK: - Computed Properties

  // MARK: - Init

  init (client:ODataClient ) {
    self.client = client
  }
  
  // MARK: - Methods
 
  /// Add a property to the client entity (this is the current Olingo implmentation)
  /// This modifies the entity parameter
  /// - parameters:
  ///   - entity: **modifiable** client entity
  ///   - property: client property to be added
  /// - returns: true
  /// - throws: No error conditions are expected
  public func addProperty(inout entity:ClientEntity , property:ClientProperty ) -> Bool {
    entity.properties.append(property)
    return  true
  }

  
  /// Add a property to the client entity (alternative)
  /// This returns an updated entity 
  /// - parameters:
  ///   - entity: **non modifiable** client entity
  ///   - property: client property to be added
  /// - returns: updated client entity
  /// - throws: No error conditions are expected
  public func addProperty(entity:ClientEntity , property:ClientProperty ) -> ClientEntity {
    var _entity:ClientEntity = entity
    
    // this next line throws on building i.e. complier crashes: Command failed due to signal: Segmentation fault 11
    // return _entity.properties.append(property)
    // but this works fine
    _entity.properties.append(property)
    return _entity
  }
  
  
   
  /// Add an entity to the client entity set (this is the current Olingo implmentation)
  /// This modifies the entityset parameter
  /// - parameters:
  ///   - entityset: **modifiable** client entityset
  ///   - entity: client entity to be added
  /// - returns: true
  /// - throws: No error conditions are expected
  public func add(inout entitySet:ClientEntitySet, entity:ClientEntity ) -> Bool {
    entitySet.entities.append(entity)
    return true
  }
  
  /// Add an entity to the client entityset (alternative)
  /// This returns an updated entityset
  /// - parameters:
  ///   - entityset: **non modifiable** client entityset
  ///   - entity: client entity to be added
  /// - returns: updated client entityset
  /// - throws: No error conditions are expected
  public func add(entitySet:ClientEntitySet, entity:ClientEntity ) -> ClientEntitySet {
    
    
    var _entitySet = entitySet
    _entitySet.entities.append(entity)
    
    return _entitySet
    // split into 2 lines as append and return on same line causes complier crash
    //return _entitySet.entities.append(entity)
  }
  
  
   
  /// Build an entityset from an odata entityset
  /// - parameters:
  ///   - odataEntitySet: entityset provided by service
  /// - returns: Entityset
  /// - throws: No error conditions are expected
  public func getEntitySet(odataEntitySet: ClientEntitySet ) ->  EntityCollection {
    
    let entitySet = EntityCollection()
    entitySet.count = odataEntitySet.count
    if let next = odataEntitySet.next {
      entitySet.next = next
    }
    //TODO : OData Entity
    
    for odataEntity in odataEntitySet.entities {
      entitySet.entities.append(getEntity(odataEntity))
    }
 
    //TODO: Add deltas and annotations
    /*
     entitySet.setDeltaLink(odataEntitySet.getDeltaLink())
     annotations(odataEntitySet, entitySet)
     */
    return entitySet
    
  }
  
  
  /// Build an Odata entityset from the suppled resource
  /// - parameters:
  ///   - resource: entity collection
  /// - returns: Client Entityset
  /// - throws: No error conditions are expected
  public func getODataEntitySet(resource:ResWrap<EntityCollection>) -> ClientEntitySet {
    
   
    if log.isDebug  {
      // TODO: Debug output
//      if let dataString = NSString(data:resource.payload,encoding: NSUTF8StringEncoding) {
//        log.debug(String(dataString))
//      }
//      else {
//        log.debug ("No data")
//      }
    }
    if resource.contextURL == nil {
      base = resource.payload.baseURI
    }
    else {
      base = ContextURLParser.parse(resource.contextURL!)!.serviceRoot
    }
    
    let next = resource.payload.next
    
    if next == nil {
      entitySet = client.objectFactory.newEntitySet()
    }
    else {
      entitySet = client.objectFactory.newEntitySet(NSURL(string:(next!.absoluteString),relativeToURL:base)!)
    }
    
    
    if (resource.payload.count > 0) {
      entitySet!.count = resource.payload.count
    }
    // TODO: Odata Entity
    
    for entityResource in resource.payload.entities {
      do {
        try add(entitySet!, entity: getODataEntity(ResWrap<Entity>(contextURL: resource.contextURL!, metadataETag: resource.metadataETag!, payload: entityResource)))
      }
      catch {
        // catch the error and then keep going for teh rest of teh entities
        log.warn("Adding entity to entity set failed")
      }
    }
    
    // TODO: Deltas & annotations
    /*
    if (resource.payload.getDeltaLink() != nil) {
      entitySet.setDeltaLink(URIUtils.getURI(base, resource.payload.getDeltaLink()))
    }
    odataAnnotations(resource.payload, entitySet)
    */
    return entitySet!
 
   
  }

  
  // TODO: public func getEntity(odataEntity: ClientEntity) -> Entity {
  
  public func getEntity(odataEntity: ClientEntity) -> Entity {
    let entity = Entity()
 
    entity.type = odataEntity.typeName.toString()
    
    // TODO: Links
    /*
    // -------------------------------------------------------------
    // Add edit and self link
    // -------------------------------------------------------------
    if let odataEditLink = odataEntity.editLink {
      var editLink = Link()
      editLink.title = entity.type
      editLink.rel = EDIT_LINK_REL
      editLink.href = odataEditLink.absoluteString
      entity.editLink = editLink
      // editLink.setTitle(entity.getType())
      // editLink.setRel(EDIT_LINK_REL)
      // entity.setEditLink(editLink)
    }
    
    if odataEntity.isReadOnly {
      let selfLink = Link()
      
      selfLink.title = entity.type
      selfLink.rel = SELF_LINK_REL
      selfLink.href = odataEntity.link.absoluteString
      entity.selfLink = selfLink
      
      //      selfLink.setTitle(entity.getType())
      //      selfLink.setRel(Constants.SELF_LINK_REL)
      //      entity.setSelfLink(selfLink)
    }
    // -------------------------------------------------------------
    
    links(odataEntity, entity)
    */
    
    // TODDO: media links
    /*
    // -------------------------------------------------------------
    // Append edit-media links
    // -------------------------------------------------------------
    for link in odataEntity.mediaEditLinks {
      log.debug("Append edit-media link\n\(link)")
      entity.mediaEditLinks.append(getLink(link))
    }
    // -------------------------------------------------------------
    
    if odataEntity.isMediaEntity {
      entity.mediaContentSource = odataEntity.mediaContentSource
      entity.mediaContentType = odataEntity.mediaContentType
      entity.mediaETag = odataEntity.mediaETag
    }
      */
    
    for property in odataEntity.properties {
      entity.properties.append(self.getProperty(property))
    }
    
    entity.id = odataEntity.id

    // TODO: annotations
    //annotations(odataEntity, entity)
    return entity
  }
 
  

  
  /// Build an Odata entity from the supplied resource
  /// - parameters:
  ///   - resource: entity
  /// - returns: Client Entity
  /// - throws: No error conditions are expected
  public func getODataEntity(resource: ResWrap<Entity> ) throws -> ClientEntity {
    
    let contextURL = ContextURLParser.parse(resource.contextURL!)
    let base = resource.contextURL == nil ? resource.payload.baseURI: contextURL!.serviceRoot
    
    let edmType = findType(resource.payload.type, contextURL: contextURL, metadataETag: resource.metadataETag)
    
    var typeName:FullQualifiedName? = nil
    var entity:ClientEntity
    
    log.debug ("getOdataEntity")
    
    if resource.payload.type.isEmpty {
      if let edmType = edmType {
        typeName = edmType.fullQualifiedName
      }
    }
    else {
      do {
        typeName =  try FullQualifiedName(namespaceAndName: resource.payload.type)
      }
      catch {
        //TODO: error handling
      }
      
    }
    
    if typeName == nil  {
       throw GetODataException.ODataEntityFailed
    }
    
    if let selfLink = resource.payload.selfLink {
      entity = client.objectFactory.newEntity(typeName!,link: NSURL(string:selfLink.href,relativeToURL: base)!)
    }
    else {
      entity = client.objectFactory.newEntity(typeName!)
    }

    // check for empty or with whitesapce only
    if resource.payload.eTag.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).isEmpty {
      entity.eTag = resource.payload.eTag
    }
    
    if let editLink = resource.payload.editLink  {
      entity.editLink = NSURL(string: editLink.href,relativeToURL: base)
    }
    // TODO: Links
    /*
    for link in resource.payload.associationLinks {
      entity.addLink(client.getObjectFactory().newAssociationLink(link.title, NSURL(String: link.href,relativeToURL: base)))
    }
    
    odataNavigationLinks(edmType, resource.payload, entity, resource.metadataETag, base)
    for link in resource.payload.mediaEditLinks {
      entity.addLink(client.getObjectFactory().newMediaEditLink(link.title, NSURL(String: link.href,relativeToURL: base)))
    }
     */
    
    // TODO Operations
    /*
    for op in resource.payload.operations {
      let operation = ClientOperation()
      operation.target = URIUtils.getURI(base, op.target)
      operation.title = op.title
      operation.metadataAnchor = op.metadataAnchor
      entity.operations.add(operation)
    }
    */
    /* TODO: MediaContent
    if (resource.payload.isMediaEntity()) {
      entity.mediaEntity = true
      entity.mediaContentSource = NSURL(string: resource.payload.mediaContentSource,relativeToURL: base)
      entity.mediaContentType = resource.payload.mediaContentType
      entity.mediaETag = resource.payload.mediaETag
    }
    */
    
    // used by navigation
    let CountDic:[String:Int] = [:]
    
    
    for property in resource.payload.properties {
      var propertyType: EdmType? = nil
      if edmType is EdmEntityType {
        if let edmProperty = (edmType as! EdmEntityType).getProperty(property.name) {
          propertyType = edmProperty.type
          // TODO: Navigation
          /*
          if (edmProperty is EdmNavigationProperty && !property.isnil()) {
            let propertyTypeName = propertyType.fullQualifiedName.fullQualifiedNameAsString
            entity.addLink(createLinkFromNavigationProperty(property, propertyTypeName,CountDic.remove(property.name)))
            continue
          }
           */
        }
        else {
          if property.name.containsString(JSON_COUNT){
            let navigationName = property.name.substringToIndex(property.name.rangeOfString(JSON_COUNT)!.startIndex)
            let edmProperty = (edmType as! EdmEntityType).getProperty(navigationName)
            // TODO : Navigation
            /*
            if (edmProperty != nil) {
              if (edmProperty is EdmNavigationProperty) {
                if let link = entity.getNavigationLink(navigationName) {
                  link.asInlineEntitySet().entitySet.setCount(property.value as Int)
                }
                CountDic.put(navigationName,property.value as Int)
              }
            }
            */
          }
        }
      }
      do {
        try addProperty(entity, property: getODataProperty(propertyType, resource: property))
      }
      catch {
        log.warn("Property not added")
      }
      
    }
    
    // TODO : Navigation
    /*
    if (!CountDic.isEmpty) {
      for (name, count) in CountDic {
        entity.addLink(createLinkFromEmptyNavigationProperty(name, count))
      }
    }
     */
    
    entity.id = resource.payload.id
    
    // TODO: Annotations
    //odataAnnotations(resource.payload, entity)
    
    return entity
  }
  
  // TODO: func getProperty(property:ClientProperty ) -> Property
  
  public func getProperty(property:ClientProperty ) -> Property {
    
    let propertyResource = Property(type: "", name: property.name)
    
    updateValuable(propertyResource, odataValuable: property)
    // TODO: Annotations
    // annotations(property, propertyResource)
    return propertyResource
  }
 
 

  /// Build an Odata property from the suppled resource
  /// - parameters:
  ///   - resource: property
  /// - returns: Client property
  /// - throws: GetODataException.ODataValueFailed
  public func getODataProperty(resource:ResWrap<Property>) throws -> ClientProperty {
    let payload = resource.payload
    var property:ClientProperty
    
    do {
      guard let contextUrl = resource.contextURL else {
        throw GetODataException.ODataValueFailed
      }
      guard let parsedUrl = ContextURLParser.parse(contextUrl) else {
        throw GetODataException.ODataValueFailed
      }
      if let typeInfo = buildTypeInfo(parsedUrl,metadataETag: resource.metadataETag, propertyName: payload.name, propertyType: payload.type) {
        if let odataVal = try getODataValue(typeInfo.fullQualifiedName,valuable: payload, contextURL: resource.contextURL, metadataETag: resource.metadataETag) {
          property = ClientPropertyImpl(name: payload.name,value: odataVal)
        }
        else {
          throw GetODataException.ODataValueFailed
        }
      }
      else {
        if let odataVal = try getODataValue(nil,valuable: payload, contextURL: resource.contextURL, metadataETag: resource.metadataETag) {
          property = ClientPropertyImpl(name: payload.name,value: odataVal)
        }
        else {
          throw GetODataException.ODataValueFailed
          
          
        }
        
      }
    }
    catch {
      throw GetODataException.ODataValueFailed
    }
    // TODO: Annotations
    // odataAnnotations(payload, property)
    
    return property
  }
 
  
  
  /// Build an Odata value from the suppled resource
  /// - parameters:
  ///   - fullQualName: the full qualified name
  ///   - valuable: the value to be updated
  ///   - contextURL: the conetxt URL
  ///   - metadataETag: the Etag
  /// - returns: Client value
  /// - throws: Illegal arguement exception
  func getODataValue(fullQualName:FullQualifiedName?,valuable:Valuable,contextURL:NSURL?,metadataETag:String?) throws -> ClientValue? {
    
    // fixes enum values treated as primitive when no type information is available
    /*
    if fullQualName == nil {
      throw IllegalArgumentException.NilOrEmptyString
    }
    
    guard let fullQualName = fullQualName else {
      throw IllegalArgumentException.NilOrEmptyString
    }
 */
    
      // TODO: EDM Enabled Client
      /*
      if client is EdmEnabledODataClient {
        if let edmType = client.getEdm(metadataETag).getEnumType(type) as EdmEnabledODataClient {
          if (!valuable.isCollection() && valuable.isPrimitive()) {
            valuable.setValue(ValueType.ENUM, valuable.asPrimitive())
          }
        }
      } */
    
    log.debug("getOdataValue: \(valuable.value)")
    
    var value:ClientValue? = nil
    
    
        // TODO: Collections
    if valuable.isCollection {
      /*
      value = client.objectFactory.newCollectionValue(fullQualName == nil ? nil : "Collection(" + fullQualName.toString() + ")")
      for  _value in valuable.asCollection! {
        let fake = Property()
        fake.setValue(valuable.getValueType().getBaseType(), _value)
        value.collection.append(getODataValue(fullQualName, fake, contextURL, metadataETag))
      }
      */
    }
      //TODO: Enum
    else if valuable.isEnum {
      // value = client.objectFactory.newEnumValue(fullQualName == nil ? "" : fullQualName!.toString(),value: valuable.asEnum.toString())
    }
      //TODO: Complex
    else if valuable.isComplex {
      /*
      let lcValue = client.objectFactory.newComplexValue(fullQualName == nil ? nil : fullQualName.toString())
      let edmType = nil
      // TODO: EDM Enabled client
      /*
      if (client is EdmEnabledODataClient && fullQualName != nil) {
        edmType = client.getEdm(metadataETag).getComplexType(fullQualName) as EdmEnabledODataClient
      }
      */
      for property in valuable.asComplex!.value {
        let edmPropertyType:EdmType?
        if (edmType != nil) {
          if let edmProp = edmType.getProperty(property.name){
            edmPropertyType = edmProp.type
          }
        }
        lcValue.add(getODataProperty(edmPropertyType, property))
      }
      // TODO: Links
      /*
      odataNavigationLinks(edmType, valuable.asComplex(), lcValue, metadataETag, contextURL)
      odataAnnotations(valuable.asComplex(), lcValue)
      */
      value = lcValue
    */
    }
    else {
      // TODO: Geospatial
      /*
      if valuable.isGeospatial {
        value = client.objectFactory.newPrimitiveValueBuilder().setValue(valuable.asGeospatial()).setType(fullQualName == nil || EdmPrimitiveTypeKind.GEOGRAPHY.fullQualifiedName.equals(fullQualName) || EdmPrimitiveTypeKind.GEOMETRY.getFullQualifiedName().equals(fullQualName) ? valuable.asGeospatial().getEdmPrimitiveTypeKind() : EdmPrimitiveTypeKind.valueOfFQN(fullQualName.toString())).build()
      }
      else if (valuable.isPrimitive || valuable.getValueType() == nil) {
      */
      if (valuable.isPrimitive || valuable.valueType == nil) {
        // fixes non-string values treated as string when no type information is available at de-serialization level
        
        //if (type != null && !EdmPrimitiveTypeKind.String.getFullQualifiedName().equals(type) && EdmPrimitiveType.EDM_NAMESPACE.equals(type.getNamespace()) && valuable.asPrimitive() instanceof String) {
        if (!EdmPrimitiveTypeKind.STRING.getFullQualifiedName().equals(Object: fullQualName!) && EDM_NAMESPACE == fullQualName!.namespace && valuable.asPrimitive is String) {
          do {
            
            let  primitiveType = try EdmPrimitiveTypeFactory.getInstance(EdmPrimitiveTypeKind(rawValue:fullQualName!.name)!)
          
            // TODO: date & time formats
            // let returnType = primitiveType.defaultType.isAssignableFrom(Calendar.class) ? Timestamp.class : primitiveType.defaultType
            // temp:
            let returnType = primitiveType.defaultType
            guard let pVal = valuable.asPrimitive else {
              throw IllegalArgumentException.InvalidFormat
              
            }
            //log.debug(String(pVal.self))
            let primval = String(pVal)
            //let primval = String(valuable.asPrimitive) //.toString()
            let val = try primitiveType.valueOfString(primval,isnilable: false, maxLength: nil, precision: DEFAULT_PRECISION, scale: DEFAULT_SCALE, isUnicode: false,returnType: returnType)
            
            valuable.setValue(valuable.valueType!,value: val)
          }
          catch {
            throw IllegalArgumentException.InvalidFormat
          }
        }
        
        var type:EdmPrimitiveTypeKind? = nil
        
        if let fullQualName = fullQualName {
          if fullQualName.namespace == EDM_NAMESPACE {
            do {
              type = try EdmPrimitiveTypeKind.valueOfFQN(fullQualName.toString())
            }
            catch {
              
            }
          }
          if let valuableAsPrimitive = valuable.asPrimitive {
            log.debug (String(valuableAsPrimitive))
            let x = valuableAsPrimitive.dynamicType
              log.debug(String(x))
            
            value = try client.objectFactory.newPrimitiveValueBuilder().setValue(valuableAsPrimitive).setType(type).build()
          }
          else {
            throw IllegalArgumentException.NilOrEmptyString
          }
        }
      }
        
      else if valuable.isComplex
      {
        // TODO: Complex
        /*
        var cValue:ClientComplexValue
        if let fullQualName = fullQualName {
          cValue = client.objectFactory.newComplexValue(fullQualName.toString())
        }
        else {
          cValue = client.objectFactory.newComplexValue("")
        }
        if !valuable.isNil {
          let edmType:EdmComplexType?
          // TODO : EDM Enabled Client
          /*
          if (client is EdmEnabledODataClient && fullQualName != nil) {
            edmType = client.getEdm(metadataETag).getComplexType(fullQualName) as EdmEnabledODataClient
          }
          */
          for property in valuable.asComplex!.value {
            let edmPropertyType:EdmType?
            if (edmType != nil) {
              if let edmProp = edmType.getProperty(property.name) {
                edmPropertyType = edmProp.type
              }
            }
            cValue.add(getODataProperty(edmPropertyType, property))
          }
        }
        value = cValue
        */
      }
    }
    return value
  }
 
 
  /// Get the Odata property from the provided service property
  /// - parameters:
  ///   - type: EdmType
  ///   - resource: Property to be used
  /// - returns: Client property
  /// - throws: No error conditions are expected
  func getODataProperty(type: EdmType? , resource: Property) throws -> ClientProperty {
    
    let typeInfo: EdmTypeInfo?
    let oDataValue: ClientValue?
    
    if let type = type {
      typeInfo = buildTypeInfo(type.fullQualifiedName, propertyType: resource.type)
    }
    else {
      typeInfo = buildTypeInfo(nil, propertyType: resource.type)
    }
    do {
      if let typeInfo = typeInfo {
        oDataValue = try getODataValue(typeInfo.fullQualifiedName,valuable: resource, contextURL: nil, metadataETag: nil)
      }
      else {
        oDataValue = try getODataValue(nil,valuable: resource, contextURL: nil, metadataETag: nil)
      }
    }
    catch {
      throw GetODataException.ODataPropertyFailed
    }
    
    if let oDataValue = oDataValue {
      let property = ClientPropertyImpl(name: resource.name,value: oDataValue)
      // TODO: Annotations
      // odataAnnotations(resource, property)
      return property
    }
    else {
      throw GetODataException.ODataPropertyFailed
    }
    
    
    
    
    
  }

 
  /// Check if typename is a primitive type
  /// - parameters:
  ///   - typename: an existing fullqualifiedname to be checked
  /// - returns: True if is a primitive type, false otherwise
  /// - throws: No error conditions are expected
  private func isPrimitiveType(typeName: FullQualifiedName ) -> Bool {
    
    if EDM_NAMESPACE == typeName.namespace {
      if EdmPrimitiveTypeKind(rawValue:typeName.name) != nil {
        return true
      }
    }
    return false
    // replaces :
    //return try EdmPrimitiveTypeKind.valueOfFQN(typeName) != nil
  
  }
 
  /// Build type information
  /// - parameters:
  ///   - contextURL: ContextURL
  ///   - metadataETag: etag fo the metadata
  ///   - propertyName: name of the property
  ///   - propertyType: type of the property
  /// - returns: EDM type info
  /// - throws: No error conditions are expected

  private func buildTypeInfo(contextURL:ContextURL?, metadataETag: String? ,propertyName: String? , propertyType: String? ) -> EdmTypeInfo? {
    
    var typeName: FullQualifiedName? = nil
    let type = findType("", contextURL: contextURL, metadataETag: metadataETag)
    
    // TODO: EDMEnabledClient
    /*
    if (type is EdmStructuredType) {
      if let edmProperty = type.getStructuralProperty(propertyName) as EdmStructuredType {
        typeName = edmProperty.getType().getFullQualifiedName()
      }
    }
     */
    if let type = type {
      if typeName == nil {
        typeName = type.fullQualifiedName
      }
    }
    return buildTypeInfo(typeName, propertyType: propertyType)
  }

 
  /// Build type info from full qualified name and the property type
  /// - parameters:
  ///   - typeName: the Full Qualified Name
  ///   - propertyType: the type of the property
  /// - returns: EDM Type Info
  /// - throws: No error conditions are expected
  private func buildTypeInfo(typeName: FullQualifiedName?,propertyType:String?) -> EdmTypeInfo? {
    
    var typeInfo:EdmTypeInfo?
    
    if let typeName = typeName {
      if let propertyType = propertyType {
        if isPrimitiveType(typeName) {
          // Inheritance is not allowed for primitive types, so we use the type given by the EDM.
          typeInfo = EdmTypeInfo.Builder().setTypeExpression(typeName.toString()).build()
        }
        else {
          typeInfo = EdmTypeInfo.Builder().setTypeExpression(propertyType).build()
        }
      }
      if propertyType == EdmPrimitiveTypeKind.STRING.getFullQualifiedName().toString() {
        typeInfo = EdmTypeInfo.Builder().setTypeExpression(typeName.toString()).build()
      }
    }
    else {
      if let propertyType = propertyType {
        typeInfo = EdmTypeInfo.Builder().setTypeExpression(propertyType).build()
      }
      
    }
    return typeInfo
  }

  
  /// Infer type name from various sources of information including Edm and context URL, if available.
  /// - parameters:
  ///   - candidateTypeName: type name as provided by the service
  ///   - contextURL: context URL
  ///   - metadataETag metadata ETag
  /// - returns: Edm type information
  /// - throws: No error conditions are expected

    private func findType(candidateTypeName: String , contextURL:ContextURL? ,metadataETag:String?) -> EdmType? {
      var type:EdmType? = nil
      
      // TODO: EDMEnabledClient
      /*
      if (client is EdmEnabledODataClient) {
        let edm = ((EdmEnabledODataClient) client).getEdm(metadataETag)
        if (StringUtils.isNotBlank(candidateTypeName)) {
          type = edm.getEntityType(new FullQualifiedName(candidateTypeName))
        }
        if (type == nil && contextURL != nil) {
          if (contextURL.getDerivedEntity() == nil) {
            for (EdmSchema schema : edm.getSchemas()) {
              final EdmEntityContainer container = schema.getEntityContainer()
              if (container != nil) {
                final EdmEntityType entityType = findEntityType(contextURL.getEntitySetOrSingletonOrType(), container)
                if (entityType != nil) {
                  if (contextURL.getNavOrPropertyPath() == nil) {
                    type = entityType
                  }
                  else {
                    final EdmNavigationProperty navProp = entityType.getNavigationProperty(contextURL.getNavOrPropertyPath())
                    type = navProp == nil ? entityType : navProp.getType()
                  }
                }
              }
            }
            if (type == nil) {
              type = EdmTypeInfo.Builder().setEdm(edm).setTypeExpression(contextURL.getEntitySetOrSingletonOrType()).build().getType()
            }
          }
          else {
            type = edm.getEntityType(new FullQualifiedName(contextURL.getDerivedEntity()))
          }
        }
      }
      */
      
      return type
    }

  
  // TODO: func getODataServiceDocument(resource: ServiceDocument ) -> ClientServiceDocument
  /*
  public func getODataServiceDocument(resource: ServiceDocument ) -> ClientServiceDocument {
    let serviceDocument = ClientServiceDocument()
    for (ServiceDocumentItem entitySet : resource.getEntitySets()) {
      serviceDocument.getEntitySets().
      put(entitySet.getName(), URIUtils.getURI(resource.getBaseURI(), entitySet.getUrl()))    }
    
    for (ServiceDocumentItem functionImport : resource.getFunctionImports()) {
      serviceDocument.getFunctionImports().put(
        functionImport.getName() == nil ? functionImport.getUrl() : functionImport.getName(),
        URIUtils.getURI(resource.getBaseURI(), functionImport.getUrl()))    }
    
    for (ServiceDocumentItem singleton : resource.getSingletons()) {
      serviceDocument.getSingletons().put(
        singleton.getName() == nil ? singleton.getUrl() : singleton.getName(),
        URIUtils.getURI(resource.getBaseURI(), singleton.getUrl()))    }
    for (ServiceDocumentItem sdoc : resource.getRelatedServiceDocuments()) {
      serviceDocument.getRelatedServiceDocuments().put(
        sdoc.getName() == nil ? sdoc.getUrl() : sdoc.getName(),
        URIUtils.getURI(resource.getBaseURI(), sdoc.getUrl()))    }
    
    return serviceDocument  }
  */
  
  // TODO: func updateValuable(propertyResource: Valuable , odataValuable:ClientValuable )
  
  private func updateValuable(propertyResource: Valuable , odataValuable:ClientValuable ) {

    let propertyValue = odataValuable.value
    
    if odataValuable.hasPrimitiveValue {
      
      propertyResource.type = odataValuable.primitiveValue!.typeName!
      if propertyValue is Geospatial {
        propertyResource.setValue(ValueType.GEOSPATIAL,value: propertyValue)
      }
      else {
        propertyResource.setValue(ValueType.PRIMITIVE,value: propertyValue)
      }
      //propertyResource.setValue(propertyValue is Geospatial ? ValueType.GEOSPATIAL : ValueType.PRIMITIVE,propertyValue)
 
    }
    else if odataValuable.hasEnumValue {
      
      propertyResource.type = odataValuable.enumValue!.typeName!
      propertyResource.setValue(ValueType.ENUM, value: propertyValue)
 
    }
    else if odataValuable.hasComplexValue {
      
      propertyResource.type = odataValuable.complexValue!.typeName!
      propertyResource.setValue(ValueType.COMPLEX, value: propertyValue)
 
    }
    else if odataValuable.hasCollectionValue {
      

      let collectionValue = odataValuable.collectionValue
      propertyResource.type = collectionValue!.typeName!
      
      let value:ClientValue
      var valueType = ValueType.COLLECTION_PRIMITIVE
      
      if collectionValue!.size() > 0 {
        if let valueCollection = collectionValue?.asSwiftCollection() {
          value = valueCollection[0] as! ClientValue
          
          
          //        value = collectionValue?.asSwiftCollection()[0]
          if value.isPrimitive {
            if value.asPrimitive!.value is Geospatial {
              valueType = ValueType.COLLECTION_GEOSPATIAL
            }
            else {
              valueType = ValueType.COLLECTION_PRIMITIVE
            }
          }
          else if (value.isEnum()) {
            valueType = ValueType.COLLECTION_ENUM
          }
          else if value.isComplex {
            valueType = ValueType.COLLECTION_COMPLEX
          }
        }
      }
      propertyResource.setValue(valueType, value: propertyValue)

    }
     
  }
  
  
  
  
  // TODO: func annotations(odataAnnotatable: ClientAnnotatable , annotatable:Annotatable )
  /*
  private func annotations(odataAnnotatable: ClientAnnotatable , annotatable:Annotatable ) {
   
    for (ClientAnnotation odataAnnotation : odataAnnotatable.getAnnotations()) {
      final Annotation annotation = new Annotation()      
      annotation.setTerm(odataAnnotation.getTerm())
      annotation.setType(odataAnnotation.getValue().getTypeName())
      updateValuable(annotation, odataAnnotation)
      annotatable.getAnnotations().add(annotation)
    }
   
  }
 */

  
  
  
  
  // TODO: func links(odataLinked: ClientLinked ,linked:Linked )
  /*
  protected func links(odataLinked: ClientLinked ,linked:Linked ) {
    // -------------------------------------------------------------
    // Append navigation links (handling inline entity / entity set as well)
    // -------------------------------------------------------------
    // handle navigation links
    for link in odataLinked.getNavigationLinks() {
      // append link
      log.debug("Append navigation link \n\(link)" )
      linked.getNavigationLinks().add(getLink(link))
    }
    // -------------------------------------------------------------
    
    // -------------------------------------------------------------
    // Append association links
    // -------------------------------------------------------------
    for link in odataLinked.getAssociationLinks() {
      log.debug("Append association link \n\(link)" )
      linked.getAssociationLinks().add(getLink(link))
    }
    // -------------------------------------------------------------
    
    for link in linked.getNavigationLinks() {
      let odataLink = odataLinked.getNavigationLink(link.title)
      if (!(odataLink is ClientInlineEntity) && !(odataLink is ClientInlineEntitySet)) {
        annotations(odataLink, link)
      }
    }
  }
  */
  
  
  // TODO: func getLink(link:ClientLink ) -> Link
  /*
  public func getLink(link:ClientLink ) -> Link {
    final Link linkResource = new Link()
    linkResource.setRel(link.getRel())
    linkResource.setTitle(link.getName())
    linkResource.setHref(link.getLink() == nil ? nil : link.getLink().toASCIIString())
    linkResource.setType(link.getType().toString())
    linkResource.setMediaETag(link.mediaETag)
    if (link is ClientInlineEntity) {
      // append inline entity
      final ClientEntity inlineEntity = ((ClientInlineEntity) link).getEntity()
      log.debug("Append in-line entity\n\(inlineEntity)")
      linkResource.setInlineEntity(getEntity(inlineEntity))
    }
    else if (link is ClientInlineEntitySet) {
      // append inline entity set
      final ClientEntitySet InlineEntitySet = ((ClientInlineEntitySet) link).entitySet
      log.debug("Append in-line entity set\n\(inlineEntity)")
      linkResource.setInlineEntitySet(getEntitySet(InlineEntitySet))
    }
    
    return linkResource
  }
 */
  

  
  // TODO: func getValue(value:ClientValue ) -> AnyObject
  /*
  func getValue(value:ClientValue ) -> AnyObject {
    var valueResource:AnyObject?
    if (value == nil) {
      return nil
    }
    if (value.isEnum()) {
      valueResource = value.asEnum().getValue()
    }
    else if (value.isPrimitive()) {
      valueResource = value.asPrimitive().toValue()
    }
    else if (value.isComplex()) {
      let complexProperties:[Property] = []
      for propertyValue in value.asComplex() {
        complexProperties.add(getProperty(propertyValue))
      }
      let lcValueResource = ComplexValue()
      lcValueResource.getValue().addAll(complexProperties)
      annotations(value.asComplex(), lcValueResource)
      links(value.asComplex(), lcValueResource)
      valueResource = lcValueResource
    }
    else if (value.isCollection())
    {
      let _value = value.asCollection() //final ClientCollectionValue<? extends ClientValue> _value = value.asCollection()
      let lcValueResource:[AnyObject] = []
      for collectionValue in _value {
        lcValueResource.add(getValue(collectionValue))
      }
      valueResource = lcValueResource
    }
    return valueResource
  }
 */
  
  // TODO: func odataAnnotations(annotatable:Annotatable , odataAnnotatable: ClientAnnotatable )
  /*
  private func odataAnnotations(annotatable:Annotatable , odataAnnotatable: ClientAnnotatable ) {
    for annotation in annotatable.getAnnotations() {
      let fqn:FullQualifiedName?
      
      if (client is EdmEnabledODataClient) {
        let term = ((EdmEnabledODataClient) client).getCachedEdm().getTerm(FullQualifiedName(annotation.getTerm()))
        //let term = ((EdmEnabledODataClient) client).getCachedEdm().getTerm(new FullQualifiedName(annotation.getTerm()))
        if (term != nil) {
          fqn = term.getType().getFullQualifiedName()
        }
      }
      
      if (fqn == nil && annotation.getType() != nil) {
        let typeInfo = EdmTypeInfo.Builder().setTypeExpression(annotation.getType()).build()
        if (typeInfo.isPrimitiveType()) {
          fqn = typeInfo.getPrimitiveTypeKind().getFullQualifiedName()
        }
      }
      
      let odataAnnotation = ClientAnnotationImpl(annotation.getTerm(), getODataValue(fqn, annotation, nil, nil))
      odataAnnotatable.getAnnotations().add(odataAnnotation)
    }
  }
 */
  
  
  
 
  //TODO: func odataNavigationLinks(edmType: EdmType ,linked:Linked ,odataLinked:ClientLinked ,metadataETag:String ,base:NSURL)
//  func odataNavigationLinks(edmType: EdmType ,linked:Linked ,odataLinked:ClientLinked ,metadataETag:String ,base:NSURL) {
//    for link in linked.getNavigationLinks() {
//      final let href = link.href
//      final let title = link.title
//      final let inlineEntity = link.getInlineEntity()
//      final let inlineEntitySet = link.getInlineEntitySet()
//      if (inlineEntity == nil && inlineEntitySet == nil) {
//        let linkType = nil
//        if (edmType is EdmStructuredType) {
//          final let navProp = edmType.getNavigationProperty(title) as EdmStructuredType
//          if (navProp != nil) {
//            linkType = navProp.isCollection() ? ClientLinkType.ENTITY_SET_NAVIGATION : ClientLinkType.ENTITY_NAVIGATION
//          }
//        }
//        if (linkType == nil) {
//          linkType = link.getType() == nil ? ClientLinkType.ENTITY_NAVIGATION :ClientLinkType.fromString(link.getRel(), link.getType())
//        }
//        odataLinked.addLink(linkType == ClientLinkType.ENTITY_NAVIGATION ? client.getObjectFactory().newEntityNavigationLink(title, URIUtils.getURI(base, href)) : client.getObjectFactory().newEntitySetNavigationLink(title, URIUtils.getURI(base, href)))
//      }
//      else if (inlineEntity != nil) {
//        odataLinked.addLink(createODataInlineEntity(inlineEntity,URIUtils.getURI(base, href), title, metadataETag))
//      }
//      else {
//        if let href = href {
//          odataLinked.addLink(createODataInlineEntitySet(inlineEntitySet,URIUtils.getURI(base, href), title, metadataETag))
//        }
//        else {
//          odataLinked.addLink(createODataInlineEntitySet(inlineEntitySet, nil, title, metadataETag))
//        }
//      }
//    }
//                                        
//    for link in odataLinked.getNavigationLinks() {
//      if (!(link is ClientInlineEntity) && !(link is ClientInlineEntitySet)) {
//        odataAnnotations(linked.getNavigationLink(link.getName()), link)
//      }
//    }
//  }


  // TODO: func createODataInlineEntity(inlineEntity: Entity ,uri:NSURL,title:String,metadataETag:String) -> ClientInlineEntity
//  private func createODataInlineEntity(inlineEntity: Entity ,uri:NSURL,title:String,metadataETag:String) -> ClientInlineEntity {
//    var res:ResWrap<Entity>?
//    if let baseURI = inlineEntity.getBaseURI() {
//      res = ResWrap<Entity>(baseURI, metadataETag,inlineEntity)
//    }
//    return ClientInlineEntity(uri, ClientLinkType.ENTITY_NAVIGATION, title,getODataEntity(res))
//  }
  
  // TODO: func createODataInlineEntitySet(inlineEntitySet: final EntityCollection ,uri: NSURL,title:String,metadataETag:String) -> ClientInlineEntitySet
//  private func createODataInlineEntitySet(inlineEntitySet: final EntityCollection ,uri: NSURL,title:String,metadataETag:String) -> ClientInlineEntitySet  {
//    var res:ResWrap<EntityCollection>?
//    if let baseURI = inlineEntity.getBaseURI() {
//      res = ResWrap<EntityCollection>(baseURI, metadataETag,inlineEntity)
//    }
//    return ClientInlineEntity(uri, ClientLinkType.ENTITY_SET_NAVIGATION, title,getODataEntitySet(res))
//  }
  
  
  // TODO: func findEntityType(entitySetOrSingletonOrType:String,container:EdmEntityContainer) -> EdmEntityType
//  private func findEntityType(entitySetOrSingletonOrType:String,container:EdmEntityContainer) -> EdmEntityType {
//    
//    let type:EdmEntityType?
//    let firstToken = StringUtils.substringBefore(entitySetOrSingletonOrType, "/")
//    let bindingTarget = container.getEntitySet(firstToken)
//    if (bindingTarget == nil) {
//      bindingTarget = container.getSingleton(firstToken)
//    }
//    if (bindingTarget != nil) {
//      type = bindingTarget.getEntityType()
//    }
//    
//    if (entitySetOrSingletonOrType.containsString("/")) {
//      let splitted = entitySetOrSingletonOrType.split("/")
//      if (splitted.length > 1) {
//        for i in 1...splitted.length {
//          if type != nil {
//            let navProp = type.getNavigationProperty(splitted[i-1])
//            if (navProp == nil) {
//              type = nil
//            }
//            else {
//              type = navProp.getType()
//            }
//          }
//        }
//      }
//    }
//    return type
//  }
  
  
  //TODO: func createLinkFromNavigationProperty(property:Property,propertyTypeName:String,count:Int) -> ClientLink
//  private func createLinkFromNavigationProperty(property:Property,propertyTypeName:String,count:Int) -> ClientLink  {
//    if (property.isCollection()) {
//      let inlineEntitySet = EntityCollection()
//      for inlined in property.asCollection() {
//        let inlineEntity = Entity()
//        inlineEntity.setType(propertyTypeName)
//        inlineEntity.properties.addAll(( inlined as ComplexValue).getValue())
//        copyAnnotations(inlineEntity, inlined as ComplexValue)
//        inlineEntitySet.getEntities().add(inlineEntity)
//      }
//      if (count != nil) {
//        inlineEntitySet.setCount(count)
//      }
//      return createODataInlineEntitySet(inlineEntitySet, nil, property.getName(), nil)
//  }
//  else {
//      let inlineEntity = Entity()
//      inlineEntity.setType(propertyTypeName)
//      inlineEntity.properties.addAll(property.asComplex().getValue())
//      copyAnnotations(inlineEntity, property.asComplex())
//      return createODataInlineEntity(inlineEntity, nil, property.getName(), nil)
//    }
//  }
  
  // TODO: func copyAnnotations(inlineEntity:Entity , complex:ComplexValue )
//  private func copyAnnotations(inlineEntity:Entity , complex:ComplexValue ) {
//    for (annotation in complex.getAnnotations()) {
//      if (annotation.getTerm().equals(JSON_TYPE.substring(1))){
//        inlineEntity.setType((String)annotation.asPrimitive())
//      }
//      else if (annotation.getTerm().equals(Constants.JSON_ID.substring(1))){
//        inlineEntity.setId(URI.create((String)annotation.asPrimitive()))
//      }
//      else if (annotation.getTerm().equals(Constants.JSON_ETAG.substring(1))){
//        inlineEntity.setETag((String)annotation.asPrimitive())
//      }
//    }
//  }
  
  
  //TODO: func createLinkFromEmptyNavigationProperty(propertyName:String,count:Int) -> ClientLink
//  private func createLinkFromEmptyNavigationProperty(propertyName:String,count:Int) -> ClientLink {
//    let inlineEntitySet = EntityCollection()
//    if (count != nil) {
//      inlineEntitySet.setCount(count)
//    }
//    return createODataInlineEntitySet(inlineEntitySet, nil, propertyName, nil)
//  }
  
  
  
  //TODO: func getODataDelta(resource: ResWrap<Delta> ) -> ClientDelta
//  public func getODataDelta(resource: ResWrap<Delta> ) -> ClientDelta {
//    if let baseURI = resource.contextURL {
//      let base = ContextURLParser.parse(resource.contextURL).getServiceRoot()
//    }
//    else {
//      let base = resource.contextURL == resource.payload.getBaseURI()
//    }
//    
//    if let next = resource.payload.getNext() {
//      let delta = client.getObjectFactory().newDelta(URIUtils.getURI(base, next.toASCIIString()))
//    }
//    else {
//      let delta = client.getObjectFactory().newDelta()
//    }
//
//    if (resource.payload.getCount() != nil) {
//      delta.setCount(resource.payload.getCount())
//    }
//    
//    if (resource.payload.getDeltaLink() != nil) {
//      delta.setDeltaLink(URIUtils.getURI(base, resource.payload.getDeltaLink()))
//    }
//    
//    for (entityResource in resource.payload.getEntities()) {
//      add(delta, getODataEntity(ResWrap<Entity>(resource.contextURL, resource.metadataETag, entityResource)))
//    }
//    for (deletedEntity in resource.payload.getDeletedEntities()) {
//      let impl = ClientDeletedEntityImpl()
//      impl.setId(URIUtils.getURI(base, deletedEntity.getId()))
//      impl.setReason(Reason.valueOf(deletedEntity.getReason().name()))
//      delta.getDeletedEntities().add(impl)
//    }
//    
//    odataAnnotations(resource.payload, delta)    
//    for (link in resource.payload.getAddedLinks()) {
//      let impl = ClientDeltaLinkImpl()
//      impl.setRelationship(link.getRelationship())
//      impl.setSource(URIUtils.getURI(base, link.getSource()))
//      impl.setTarget(URIUtils.getURI(base, link.getTarget()))
//      odataAnnotations(link, impl)
//      delta.getAddedLinks().add(impl)
//    }
//    for (link in resource.payload.getDeletedLinks()) {
//      let impl = ClientDeltaLinkImpl()
//      impl.setRelationship(link.getRelationship())
//      impl.setSource(URIUtils.getURI(base, link.getSource()))
//      impl.setTarget(URIUtils.getURI(base, link.getTarget()))
//      odataAnnotations(link, impl)      
//      delta.getDeletedLinks().add(impl)
//    }
//    
//    return delta
//  }
 
 

 
}
