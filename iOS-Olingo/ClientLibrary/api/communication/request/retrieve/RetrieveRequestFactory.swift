//
//  RetrieveRequestFactory.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 23/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//



import Foundation

/// Interface for a factory to create the various types of OData request entities

protocol RetrieveRequestFactory {
  
  /// Gets a uri request returning a set of one or more sets of OData entities
  func entitySetIteratorRequest(uri:String)
  
  /// Gets a uri request returning a set of one or more OData entities
  func entitySetRequest(uri:String)
}
