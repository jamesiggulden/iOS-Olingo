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

/// A referential constraint of a navigation property
public class EdmReferentialConstraintImpl: EdmReferentialConstraint  { //TODO:  EdmAnnotatable {

  /// return property name of the property inside this entity type or complex type
  public var propertyName: String
  
  /// return property name of the referenced entity type or complex type
  public var referencedPropertyName: String
  
  init(aPropertyName: String, aRefPropertyName: String) {
    propertyName = aPropertyName
    referencedPropertyName = aRefPropertyName
  }
  
}