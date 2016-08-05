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
//  EdmKeyPropertyRefImpl.swift.
//
//  Created by EnergySys on 28/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

//
//  EdmKeyPropertyRefImpl.swift
//  iOS-Olingo
//

import Foundation

/// A key property reference element
public class EdmKeyPropertyRefImpl: EdmKeyPropertyRef {
  
  let theLocalName: String
  let theLocalAlias: String
  let theLocalEdmProperty: EdmProperty
  
  public init(aName: String, anAlias: String, anEdmProperty: EdmProperty) {
    theLocalName = aName
    theLocalAlias = anAlias
    theLocalEdmProperty = anEdmProperty
  }
  
  /// return name of the key predicate. Can be a path in case the alias is set
  public var name:String {
    return theLocalName
  }
  
  /**
   * @return alias of this reference or null if not set
   */
  public var alias:String {
    return theLocalAlias
  }
  
  /**
   * @return the property this property ref points to
   */
  public var property:EdmProperty {
    return theLocalEdmProperty
  }
  
}
