//
//  ODataClientFactory.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 23/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Implementation of a factory to create an OData Client
public final class ODataClientFactory {
  
  
  /// create a new instance of an Odata client
/// - parameters:
///   - none
/// - returns: OData client
/// - throws: No error conditions are expected
  func getClient() -> ODataClient {
    
    let client:ODataClient = ODataClientImp()
    return client
  }
  
}