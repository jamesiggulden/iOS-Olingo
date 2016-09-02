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

//  EdmSchemaImpl.
//  Created by EnergySys on 28/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.

import Foundation

// A csdl schema element
public class EdmSchemaImpl: EdmSchema {
  
  // MARK: - Properties
  let theNamespace: String
  var theEntityTypes = [EdmEntityType]()
  public var theEntityContainer: EdmEntityContainer?
  public var theNavigationProperties = [String: [EdmNavigationProperty]]()
  
  // MARK: - Init
  public init(aNamespace: String){
    theNamespace = aNamespace
  }
  
  // MARK: - Functions
  // Get the namespace for this schema.
  public func getNamespace() -> String {
    return theNamespace
  }
  
  // Get the alias for this schema. May be null.
  public func getAlias() -> String {
    fatalError("Unsupported Operation")
  }
  
  // Get all enum types for this schema.
  public func getEnumTypes() -> [EdmEnumType] {
    fatalError("Unsupported Operation")
  }
  
  // Get all entity types for this schema.
  public func getEntityTypes() -> [EdmEntityType] {
    return theEntityTypes
  }
  
  // Get all complex types for this schema.
  public func getComplexTypes() -> [EdmComplexType] {
    fatalError("Unsupported Operation")
  }
  
  // Get all actions for this schema.
  public func getActions() -> [EdmAction] {
    fatalError("Unsupported Operation")
  }
  
  // Get all functions for this schema.
  public func getFunctions() -> [EdmFunction] {
    fatalError("Unsupported Operation")
  }
  
  // Get all {@link EdmTypeDefinition} for this schema.
  public func getTypeDefinitions() -> [EdmTypeDefinition] {
    fatalError("Unsupported Operation")
  }
  
  // Get all {@link EdmTerm} for this schema.
  public func getTerms() -> [EdmTerm] {
    fatalError("Unsupported Operation")
  }
  
  // Get all {@link EdmAnnotations} for this schema.
  // func getAnnotationGroups() -> [EdmAnnotations]
  
  // Get the entity container for this schema. May be null.
  public func getEntityContainer() -> EdmEntityContainer? {
    return theEntityContainer
  }
  
  // Get the navigation properties for this schema
  // - parameters:
  //   - none
  // - returns: Dict of key: entity type name and value: list of navigation properties
  // - throws: No error conditions are expected
  public func getNavigationProperties() -> [String: [EdmNavigationProperty]] {
    return theNavigationProperties
  }
  
}

