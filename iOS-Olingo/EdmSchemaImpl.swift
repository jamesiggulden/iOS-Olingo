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
//  EdmSchemaImpl.
//
//  Created by EnergySys on 28/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// A csdl schema element
public class EdmSchemaImpl: EdmSchema {
  
  let theNamespace: String
  var theEntityTypes = [EdmEntityType]()
  
  ///Initializer
  public init(aNamespace: String){
    theNamespace = aNamespace
  }
  
  /// get the namespace for this schema
  public func getNamespace() -> String {
    return theNamespace
  }
  
  
  /// get the alias for this schema. May be null.
  public func getAlias() -> String {
    fatalError("Unsupported Operation")
  }
  
  
  /// get all enum types for this schema
  public func getEnumTypes() -> [EdmEnumType] {
    fatalError("Unsupported Operation")
  }
  
  
  /// get all entity types for this schema
  public func getEntityTypes() -> [EdmEntityType] {
    return theEntityTypes
  }
  
  
  /// get all complex types for this schema
  public func getComplexTypes() -> [EdmComplexType] {
    fatalError("Unsupported Operation")
  }
  
  
  /// get all actions for this schema
  public func getActions() -> [EdmAction] {
    fatalError("Unsupported Operation")
  }
  
  
  /// get all functions for this schema
  public func getFunctions() -> [EdmFunction] {
    fatalError("Unsupported Operation")
  }
  
  
  /// get all {@link EdmTypeDefinition} for this schema.
  public func getTypeDefinitions() -> [EdmTypeDefinition] {
    fatalError("Unsupported Operation")
  }
  
  
  /// get all {@link EdmTerm} for this schema.
  public func getTerms() -> [EdmTerm] {
    fatalError("Unsupported Operation")
  }
  
  
  /// get all {@link EdmAnnotations} for this schema.
  // TODO: Annotations
  //func getAnnotationGroups() -> [EdmAnnotations]
  
  
  /// get the entity container for this schema. May be null.
  public func getEntityContainer() -> EdmEntityContainer {
    fatalError("Unsupported Operation")
  }
  
}

