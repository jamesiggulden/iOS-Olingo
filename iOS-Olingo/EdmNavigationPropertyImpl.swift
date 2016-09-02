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

//
//  EdmReferentialConstraintImpl.
//
//  Created by EnergySys on 28/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * A CSDL NavigationProperty element
 * <br/>
 * EdmNavigationProperty allows navigation from one entity type to another via a relationship.
 */
public class EdmNavigationPropertyImpl: EdmNavigationProperty { // TODO: EdmAnnotatable {
  
  public var theRefConstraints: [EdmReferentialConstraint]?
  public let name: String
  let theEntityTypeName: String
  let theRawTypeName: String
  let theIsNil: Bool
  let theIsContainsTarget: Bool
  let thePartnerName: String
  let theSchema: EdmSchema
  
  init(aName: String, anEntityTypeName: String, isNullable: Bool, isContainsTarget: Bool, aPartnerName: String, aSchema: EdmSchema) {
    name = aName
    theEntityTypeName = EdmNavigationPropertyImpl.extractTypeFromString(anEntityTypeName)
    theRawTypeName = anEntityTypeName
    theIsNil = isNullable
    theIsContainsTarget = isContainsTarget
    thePartnerName = aPartnerName
    theSchema = aSchema
  }
  
  /// Extracts type name from a String i.e. removes the surrounding "Collection( )"
  class func extractTypeFromString(aRawTypeDesc: String) -> String {
    var myExtractedType = aRawTypeDesc
    if (aRawTypeDesc.startsWith("Collection")) {
      myExtractedType = myExtractedType.substringBetweenStrings("Collection(", end: ")")!
    }
    return myExtractedType
  }
  
  /// return true if nullable or not specified
  public var isNullable:Bool {
    get {
      return theIsNil
    }
  }
  
  /// return true if containsTarget
  public var containsTarget: Bool {
    get {
      return theIsContainsTarget
    }
  }
  
  /// return the partner navigation property
  public var partner: EdmNavigationProperty? {
    get {
      let myName = type?.name
      let myNavigationProperties = theSchema.getNavigationProperties()
      let myTypeBasedNavProperties = myNavigationProperties[myName!]
      if (myTypeBasedNavProperties != nil) {
        for myNavigationProperty in myTypeBasedNavProperties! {
          if (myNavigationProperty.name == thePartnerName)
          {
            return myNavigationProperty
          }
        }
      }
      return nil
    }
  }
  
  
  /// Get property name for referenced property
  /// - parameters:
  ///   - referencedPropertyName: name of referenced property
  /// - returns: propertyName for this referenced property
  /// - throws: No error conditions are expected
  public func getReferencingPropertyName(referencedPropertyName:String) -> String {
    fatalError("Unsupported Operation")
  }
  
  /// return all referential constraints for this navigation property
  public var referentialConstraints:[EdmReferentialConstraint] {
    get {
      return theRefConstraints!
    }
    set(someRefConstraints) {
      theRefConstraints = someRefConstraints
    }
  }
  
  public var type: EdmType? {
    get {
      var myFQName: FullQualifiedName?
      do {
        myFQName = try FullQualifiedName(namespaceAndName: theEntityTypeName)
      }
      catch {
        log.error("Error constructing Full Qualified Name using: " + theEntityTypeName)
      }
      let myEntityTypes = theSchema.getEntityTypes()
      for myEntityType in myEntityTypes {
        if (myEntityType.name == myFQName?.name) {
          return myEntityType
        }
      }
      return nil
    }
  }
  
  public var isCollection:Bool {
    get {
      return theRawTypeName.startsWith("Collection")
    }
  }
  
}
