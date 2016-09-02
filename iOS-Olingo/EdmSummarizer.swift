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

//  Entity Data Model summary.
//  Created by EnergySys on 02/08/2016.
//  Copyright © 2016 EnergySys. All rights reserved.

import Foundation

// Entity Data Model (EDM) summarizer.
public final class EdmSummarizer {
  
  // MARK: - Properties
  let theEdm: Edm
  private let BREADCRUMB = "-> "
  private let NEW_LINE = "\n"
  
  // MARK: - Init
  init(anEdm: Edm) {
    theEdm = anEdm
  }
  
  // MARK: - Methods
  // Generates the Edm summary.
  // - parameters:
  //   - none
  // - returns: String summary
  // - throws: No error conditions are expected
  public func getSummary() -> String {
    var mySummary = "Nothing to summarize."
    mySummary = generateSummary()
    return mySummary
  }
  
  private func generateSummary() -> String {
    var mySummary = String()
    let mySchemas = theEdm.getSchemas()
    for mySchema in mySchemas {
      mySummary += "Schema namespace: " + mySchema.getNamespace() + NEW_LINE
      //Entity Sets
      let myEntityContainer = mySchema.getEntityContainer()
      mySummary += BREADCRUMB + "Entity Container:" + NEW_LINE
      if (myEntityContainer != nil) {
        mySummary += BREADCRUMB + "name: " + myEntityContainer!.name + NEW_LINE
        mySummary += BREADCRUMB + "Entity Sets:" + NEW_LINE
        let myEntitySets = myEntityContainer!.entitySets
        for myEntitySet in myEntitySets! {
          mySummary += BREADCRUMB + BREADCRUMB + "name: " + myEntitySet.name
          mySummary += ", Entity Type: " + String(myEntitySet.getEntityType()!.name)
          mySummary += NEW_LINE
          let myNavigationProprtyBindings = myEntitySet.getNavigationPropertyBindings()
          mySummary += BREADCRUMB + BREADCRUMB + BREADCRUMB + "NavigationPropertyBindings:"
          mySummary += NEW_LINE
          for myNavPropBinding in myNavigationProprtyBindings {
            mySummary += BREADCRUMB + BREADCRUMB + BREADCRUMB + "Path: " + myNavPropBinding.path
            mySummary += ", Target: " + myNavPropBinding.target
            mySummary += NEW_LINE
          }
        }
      }
      //Entities
      let myEntities = mySchema.getEntityTypes()
      mySummary += BREADCRUMB + "Entities:" + NEW_LINE
      for myEntity in myEntities {
        mySummary += BREADCRUMB + "name: " + myEntity.name + NEW_LINE
        mySummary += BREADCRUMB + BREADCRUMB + "Properties:" + NEW_LINE
        let myKeyPropertyRefs = myEntity.getKeyPropertyRefs()
        for myKeyPropertyRef in myKeyPropertyRefs {
          mySummary += BREADCRUMB + BREADCRUMB + "name: " + myKeyPropertyRef.name
          mySummary += ", Edm class: " + myKeyPropertyRef.property.type.debugDescription
          mySummary += ", isPrimitive: " + String(myKeyPropertyRef.property.isPrimitive)
          mySummary += ", isNullable: " + String(myKeyPropertyRef.property.isNilable)
          mySummary += ", maxLength: " + String(myKeyPropertyRef.property.maxLength)
          mySummary += NEW_LINE
        }
        mySummary += BREADCRUMB + BREADCRUMB + "Navigation Properties:" + NEW_LINE
        let myNavigationProperties = myEntity.theNavigationProperties
        if (myNavigationProperties != nil) {
          for myNavigationProperty in myNavigationProperties! {
            mySummary += BREADCRUMB + BREADCRUMB + "name: " + myNavigationProperty.name
            mySummary += ", isNullable: " + String(myNavigationProperty.isNullable)
            mySummary += ", containsTarget: " + String(myNavigationProperty.containsTarget)
            mySummary += ", isCollection: " + String(myNavigationProperty.isCollection)
            mySummary += ", type: " + String(myNavigationProperty.type?.name)
            mySummary += ", partner: " + String(myNavigationProperty.partner?.name)
            mySummary += NEW_LINE
            let myReferenceConstraints = myNavigationProperty.referentialConstraints
            mySummary += BREADCRUMB + BREADCRUMB + BREADCRUMB + "Reference Constraints:" + NEW_LINE
            for myReferenceConstraint in myReferenceConstraints {
              mySummary += BREADCRUMB + BREADCRUMB + BREADCRUMB + "property name: " + myReferenceConstraint.propertyName
              mySummary += ", ref property name: " + myReferenceConstraint.referencedPropertyName
              mySummary += NEW_LINE
            }
          }
        }
      }
    }
    log.info(mySummary)
    return mySummary
  }

}