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
//  Entity Data Model implementation.
//
//  Created by EnergySys on 02/08/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * Entity Data Model (EDM) implementation.
 * <br/>
 */
public class EdmProviderImpl: Edm {
  
  var theSchemas = [String: EdmSchema]()
  public var theRawXmlData: NSData?
  
  public func getSchemas() -> [EdmSchema]{
    return Array(theSchemas.values)
  }
  
  public func setSchemas(someSchemas: [String: EdmSchema]) {
    theSchemas = someSchemas
  }
  
  /**
   * Get schema by namespace.
   *
   * @param namespace must not be null
   * @return {@link EdmSchema}
   */
  public func getSchema(namespace:String) -> EdmSchema {
    return theSchemas[namespace]!
  }
  
  /**
   * Get main entity container.
   * <br/>
   * See {@link EdmEntityContainer} for more information.
   *
   * @return {@link EdmEntityContainer}
   */
  public func getEntityContainer() -> EdmEntityContainer {
    fatalError("Unsupported Operation")
  }
  
  /**
   * Get entity container by full qualified name.
   * <br/>
   * See {@link EdmEntityContainer} for more information.
   *
   * @param name full qualified name of entity container
   * @return {@link EdmEntityContainer}
   */
  public func getEntityContainer(name: FullQualifiedName ) -> EdmEntityContainer {
    fatalError("Unsupported Operation")
  }
  
  /**
   * Get enum type by full qualified name.
   * <br/>
   * See {@link EdmEnumType} for more information
   *
   * @param name full qualified name of enum type
   * @return {@link EdmEnumType}
   */
  public func getEnumType(name:FullQualifiedName ) -> EdmEnumType? {
    fatalError("Unsupported Operation")
  }
  
  /**
   * Get a type definition by full qualified name.
   * <br/>
   * See {@link EdmTypeDefinition} for more information
   *
   * @param name full qualified name of type definition
   * @return {@link EdmTypeDefinition}
   */
  public func getTypeDefinition(name:FullQualifiedName ) -> EdmTypeDefinition {
    fatalError("Unsupported Operation")
  }
  
  /**
   * Get entity type by full qualified name.
   * <br/>
   * See {@link EdmEntityType} for more information.
   *
   * @param name full qualified name of entity type
   * @return {@link EdmEntityType}
   */
  public func getEntityType(name:FullQualifiedName ) -> EdmEntityType? {
    let myEntityName = name.name
    let myEntityTypes = theSchemas[name.namespace]?.getEntityTypes()
    for myEntityType in myEntityTypes! {
      if (myEntityName == myEntityType.name) {
        return myEntityType
      }
    }
    return nil
  }
  
  /**
   * Get complex type by full qualified name..
   * <br/>
   * See {@link EdmComplexType} for more information.
   *
   * @param name full qualified name of complex type
   * @return {@link EdmComplexType}
   */
  public func getComplexType(name:FullQualifiedName ) -> EdmComplexType {
    fatalError("Unsupported Operation")
  }
  
  /**
   * Get unbound Action by full qualified name.
   *
   * @param actionName must not be null
   * @return {@link EdmAction}
   */
  public func  getUnboundAction(actionName:FullQualifiedName ) -> EdmAction {
    fatalError("Unsupported Operation")
  }
  
  /**
   * Get Action by full qualified name and binding parameter type.
   *
   * @param actionName must not be null
   * @param bindingParameterTypeName must not be null
   * @param isBindingParameterCollection may be null
   * @return {@link EdmAction}
   */
  public func getBoundAction(actionName:FullQualifiedName , bindingParameterTypeName:FullQualifiedName, isBindingParameterCollection:Bool) -> EdmAction {
    fatalError("Unsupported Operation")
  }
  
  /**
   * Get Function by full qualified name.
   *
   * @param functionName must not be null
   * @return {@link EdmFunction}
   */
  public func getUnboundFunctions(functionName:FullQualifiedName) -> [EdmFunction] {
    fatalError("Unsupported Operation")
  }
  
  /**
   * Get Function by full qualified name.
   *
   * @param functionName must not be null
   * @param parameterNames may be null: in this case it is considered as empty
   * @return {@link EdmFunction}
   */
  public func getUnboundFunction(functionName:FullQualifiedName,parameterNames:[String]) -> EdmFunction {
    fatalError("Unsupported Operation")
  }
  
  /**
   * Get Function by full qualified name and binding parameter type and binding parameter names.
   *
   * @param functionName must not be null
   * @param bindingParameterTypeName must not be null
   * @param isBindingParameterCollection may be null
   * @param parameterNames may be null: in this case it is considered as empty
   * @return {@link EdmFunction}
   */
  public func getBoundFunction(functionName:FullQualifiedName,bindingParameterTypeName:FullQualifiedName,isBindingParameterCollection:Bool,  parameterNames:[String]) -> EdmFunction {
    fatalError("Unsupported Operation")
  }
  
  /**
   * Get Term full by qualified name.
   *
   * @param termName must not be null
   * @return {@link EdmTerm}
   */
  public func getTerm(termName:FullQualifiedName ) -> EdmTerm {
    fatalError("Unsupported Operation")
  }
  
  /**
   * Get {@link EdmAnnotations} by target.
   *
   * @param targetName <tt>edm:Annotations</tt> target
   * @param qualifier for the target. Can be <code>NULL</code>
   * @return {@link EdmAnnotations}
   */
  // TODO: Annotations
  //func getAnnotationGroup(targetName:FullQualifiedName ,qualifier:String) -> EdmAnnotations
}
