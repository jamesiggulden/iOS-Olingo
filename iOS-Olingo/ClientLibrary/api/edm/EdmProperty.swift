//
//  EdmProperty.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/**
 * A CSDL Property element.
 * <br/>
 * EdmProperty defines a simple type or a complex type.
 */
public protocol EdmProperty : EdmElement { //, EdmMappable  { // TODO: EdmAnnotatable {
  
  /**
   * Gets the related MIME type for the property.
   *
   * @return MIME type as String
   */
  var mimeType: String? {get}
  
  /**
   * Gets the info if the property is a primitive property.
   *
   * @return true, if it is a primitive property
   */
  var isPrimitive: Bool {get}
  
  /**
   * @return true if nilable or not specified
   */
  var isNilable: Bool {get}
  
  /**
   * @return the maximum length as an Int or nil if not specified
   */
  var maxLength: Int {get}
  
  /**
   * @return the precision as an Int or nil if not specified
   */
  var precision: Int {get}
  
  /**
   * @return the scale as an Int or nil if not specified
   */
  var scale: Int {get}
  
  /**
   * @return a non-negative Int or the special value <tt>variable</tt>
   */
  var srid: SRID? {get}
  
  /**
   * @return true if unicode or not specified
   */
  var unicode: Bool {get}
  
  /**
   * @return the default value as a String or nil if not specified
   */
  var defaultValue: String? {get}
}

