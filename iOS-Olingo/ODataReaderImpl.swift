/*
 * Copyright 2015 EnergySys Limited. All Rights Reserved.
 *
 * This software is the proprietary information of EnergySys Limited.
 * Use is subject to licence terms.
 * This software is not designed or supplied to be used in circumstances where
 * personal injury, death or loss of or damage to property could result from any
 * defect in the software.
 * In no event shall the developers or owners be liable for personal injury,
 * death or loss or damage to property, loss of business, revenue, profits, use,
 * data or other economic advantage or for any indirect, punitive, special,
 * incidental, consequential or exemplary loss or damage resulting from the use
 * of the software or documentation.
 * Developer and owner make no warranties, representations or undertakings of
 * any nature in relation to the software and documentation.
 */

//  Use this class to de-serialize an OData response body.
//  Created by EnergySys on 28/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.

import Foundation

// MARK: - Class
public class ODataReaderImpl: NSObject, ODataReader, NSXMLParserDelegate {
  
  // MARK: - Properties
  let SCHEMA_ELEMENT_NAME = "Schema"
  let ROOT_ELEMENT_NAME = "edmx:Edmx"
  let ENTITY_TYPE_NAME = "EntityType"
  let PROPERTY_ELEMENT_NAME = "Property"
  let NAVIGATION_PROPERTY_ELEMENT_NAME = "NavigationProperty"
  let REFERENTIAL_CONSTRAINT_ELEMENT_NAME = "ReferentialConstraint"
  let ENTITY_CONTAINER_ELEMENT_NAME = "EntityContainer"
  let ENTITY_SET_ELEMENT_NAME = "EntitySet"
  let NAVIGATION_PROPERTY_BINDING_ELEMENT_NAME = "NavigationPropertyBinding"
  
  var theParser: NSXMLParser?
  var theCurrentSchema: EdmSchemaImpl?
  var theCurrentEntityType: EdmEntityTypeImpl?
  var theEntityTypes = [EdmEntityType]()
  var thePropertyRefs = [String: EdmKeyPropertyRef]()
  var theCurrentNavigationProperties = [EdmNavigationProperty]()
  var theCurrentNavigationProperty: EdmNavigationProperty?
  var theCurrentReferentialConstraints = [EdmReferentialConstraint]()
  var theNavigationProperties = [String: [EdmNavigationProperty]]()
  var theSchemas = [String: EdmSchema]()
  var theEdm = EdmProviderImpl()
  var theCurrentEntitySetName: String?
  var theCurrentEntitySetType: String?
  var theCurrentEntitySet: EdmEntitySet?
  var theCurrentEntitySets = [EdmEntitySet]()
  var theCurrentNavPropertyBindings = [CsdlNavigationPropertyBinding]()
  var theCurrentEntityContainer: EdmEntityContainerImpl?
  
  // MARK: - Methods
  // Read the XML metadata into an Edm
  // - parameters:
  //   - NSData: raw XML data to be parsed.
  // - returns: Edm
  // - throws: ODataDeserializerException
  public func readMetadata(someRawXmlMetaData: NSData) throws -> Edm {
    theParser = NSXMLParser(data: someRawXmlMetaData)
    theParser?.delegate = self
    let mySuccess:Bool = (theParser?.parse())!
    if (!mySuccess) {
      throw ODataDeserializerException.InvalidFormat
    }
    theEdm.theRawXmlData = someRawXmlMetaData
    return theEdm
  }
  
  // Callback method for NSXMLParser.
  public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    if (SCHEMA_ELEMENT_NAME == elementName) {
      let myNamespaceAtt = attributeDict["Namespace"]
      log.info("Creating new Schema with Namespace: " + myNamespaceAtt!)
      theCurrentSchema = EdmSchemaImpl(aNamespace: myNamespaceAtt!)
    }
    if (ENTITY_TYPE_NAME == elementName) {
      let myEntityName = attributeDict["Name"]
      log.info("Creating new entity with name: " + myEntityName!)
      theCurrentEntityType = EdmEntityTypeImpl(edm: theEdm, typeName: FullQualifiedName(namespace: (theCurrentSchema?.getNamespace())!, name: myEntityName!), kind: EdmTypeKind.ENTITY, structuredType: CsdlEntityType())
    }
    if (PROPERTY_ELEMENT_NAME == elementName) {
      // Create EdmKeyPropertyRef and add to the list
      let myEdmKeyPropertyRef = createEdmKeyPropertyRef(attributeDict)
      let myName = attributeDict["Name"]
      log.info("Adding property to array: " + myName!)
      thePropertyRefs[myName!] = myEdmKeyPropertyRef
    }
    if (NAVIGATION_PROPERTY_ELEMENT_NAME == elementName) {
      let myName = attributeDict["Name"]
      let myNullableString = attributeDict["Nullable"]
      let myIsNillable = !("false" == myNullableString)
      var myPartner = attributeDict["Partner"]
      if (myPartner == nil) {
        myPartner = ""
      }
      let myType = attributeDict["Type"]
      theCurrentNavigationProperty = EdmNavigationPropertyImpl(aName: myName!, anEntityTypeName: myType!, isNullable: myIsNillable, isContainsTarget: false, aPartnerName: myPartner!, aSchema: theCurrentSchema!)
    }
    if (REFERENTIAL_CONSTRAINT_ELEMENT_NAME == elementName) {
      let myPropertyName = attributeDict["Property"]
      let myRefProperty = attributeDict["ReferencedProperty"]
      let myRefConstraint = EdmReferentialConstraintImpl(aPropertyName: myPropertyName!, aRefPropertyName: myRefProperty!)
      theCurrentReferentialConstraints.append(myRefConstraint)
    }
    if (ENTITY_CONTAINER_ELEMENT_NAME == elementName) {
      let myName = attributeDict["Name"]
      theCurrentEntityContainer = EdmEntityContainerImpl(anEdm: theEdm, aName: myName!)
    }
    if (ENTITY_SET_ELEMENT_NAME == elementName) {
      theCurrentEntitySetName = attributeDict["Name"]
      theCurrentEntitySetType = attributeDict["EntityType"]
    }
    if (NAVIGATION_PROPERTY_BINDING_ELEMENT_NAME == elementName) {
      let myPath = attributeDict["Path"]
      let myTarget = attributeDict["Target"]
      let myNavPropBinding = CsdlNavigationPropertyBinding(aPath: myPath!, aTarget: myTarget!)
      theCurrentNavPropertyBindings.append(myNavPropBinding)
    }
  }
  
  // Callback method for NSXMLParser.
  public func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if (ROOT_ELEMENT_NAME == elementName) {
      log.info("Updating the Edm object with the schemas found")
      theEdm.setSchemas(theSchemas)
    }
    if (SCHEMA_ELEMENT_NAME == elementName) {
      log.info("Finished processing schema")
      // Add list of entities to current schema
      theCurrentSchema?.theEntityTypes = theEntityTypes
      theEntityTypes.removeAll()
      // Add current schema to the list
      theSchemas[theCurrentSchema!.getNamespace()] = theCurrentSchema!
      // Add the navigation properties to the schema
      theCurrentSchema?.theNavigationProperties = theNavigationProperties
    }
    if (ENTITY_TYPE_NAME == elementName) {
      // Add any property refs to the current entity
      theCurrentEntityType?.theKeyPropertyRefs = thePropertyRefs
      thePropertyRefs.removeAll()
      // Add the current entity type to the list
      theEntityTypes.append(theCurrentEntityType!)
      // Add the navigation properties to the dict and to the entity
      if (theCurrentNavigationProperties.count > 0) {
        theNavigationProperties[(theCurrentEntityType?.name)!] = theCurrentNavigationProperties
        theCurrentEntityType?.theNavigationProperties = theCurrentNavigationProperties
        theCurrentNavigationProperties.removeAll()
      }
    }
    if (NAVIGATION_PROPERTY_ELEMENT_NAME == elementName) {
      theCurrentNavigationProperty?.referentialConstraints = theCurrentReferentialConstraints
      theCurrentReferentialConstraints.removeAll()
      theCurrentNavigationProperties.append(theCurrentNavigationProperty!)
    }
    if (ENTITY_SET_ELEMENT_NAME == elementName) {
      do {
        let myCsdlEntitySet = try CsdlEntitySet(aName: theCurrentEntitySetName!, aTitle: theCurrentEntitySetType!, aType: FullQualifiedName(namespaceAndName: theCurrentEntitySetType!)!)
        myCsdlEntitySet.navigationPropertyBindings = theCurrentNavPropertyBindings
        let myCurrentEntitySet = EdmEntitySetImpl(anEdm: theEdm, aContainer: theCurrentEntityContainer!, anEntitySet: myCsdlEntitySet)
        theCurrentEntitySets.append(myCurrentEntitySet)
        // Reset values
        theCurrentNavPropertyBindings.removeAll()
      }
      catch {
        log.error("Could not parse metadata")
      }
    }
    if (ENTITY_CONTAINER_ELEMENT_NAME == elementName) {
      theCurrentEntityContainer?.entitySets = theCurrentEntitySets
      theCurrentSchema?.theEntityContainer = theCurrentEntityContainer
    }
  }
  
  // Callback method for NSXMLParser.
  public func parser(parser: NSXMLParser, foundCharacters string: String) {
  }
  
  // Callback method for NSXMLParser.
  public func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
  }
  
  private func createEdmKeyPropertyRef(anAttributeDict: [String: String]) -> EdmKeyPropertyRef {
    let myName = anAttributeDict["Name"]
    let myType = anAttributeDict["Type"]
    let myNullableString = anAttributeDict["Nullable"]
    var myMaxLength = -1
    
    let myMaxLengthExists = anAttributeDict["MaxLength"] != nil
    if (myMaxLengthExists) {
      if (Int(anAttributeDict["MaxLength"]!) != nil) {
        myMaxLength = Int(anAttributeDict["MaxLength"]!)!
      }
    }
    
    // Create the CsdlProperty
    let myCsdlProperty = CsdlProperty()
    myCsdlProperty.setName(String: myName!)
    myCsdlProperty.setType(myType!)
    if ("false" == myNullableString) {
      myCsdlProperty.setNilable(Bool: false)
    }
    else {
      myCsdlProperty.setNilable(Bool: true)
    }
    if (myMaxLengthExists && (Int(anAttributeDict["MaxLength"]!) != nil)) {
      myCsdlProperty.setMaxLength(myMaxLength)
    }
    
    // Create the EdmProperty
    let myEdmProperty = EdmPropertyImpl(edm: theEdm, property: myCsdlProperty)
    
    // Create the EdmKeyPropertyRef
    let myEdmKeyPropertyRef = EdmKeyPropertyRefImpl(aName: myName!, anAlias: myName!, anEdmProperty: myEdmProperty)
    return myEdmKeyPropertyRef
  }

}
