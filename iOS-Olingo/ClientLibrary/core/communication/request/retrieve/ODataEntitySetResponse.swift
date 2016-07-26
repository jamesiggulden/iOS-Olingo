//
/*
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with this work for additional information
  regarding copyright ownership.  The ASF licenses this file
  to you under the Apache License, Version 2.0 (the
  "License"); you may not use this file except in compliance
  with the License.  You may obtain a copy of the License at
 
    http://www.apache.org/licenses/LICENSE-2.0
 
  Unless required by applicable law or agreed to in writing,
  software distributed under the License is distributed on an
  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  KIND, either express or implied.  See the License for the
  specific language governing permissions and limitations
  under the License.
 */


//  ODataEntitySetResponse.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 11/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Response class about an ODataEntitySetRequest
public class ODataEntitySetResponse : AbstractODataResponse, ODataRetrieveResponse  {
  
  // MARK: - Stored Properties

  // MARK: - Computed Properties
  
  // MARK: - Init
  
  override init (odataClient: ODataClient,
                         res: HttpResponseContent ) {
    
    super.init(odataClient: odataClient, res: res)
  }
  
  // MARK: - Methods
  
  /// Get the body of the returned response
  /// - parameters:
  ///   - none
  /// - returns: Entity
  /// - throws: No error conditions are expected
  public func getBody() {
    
  }
  
  /*
  public func getBody2(entityCollection :EntityCollection? = nil) throws -> EntityCollection? {
    var _entityCollection = entityCollection
    if (_entityCollection == nil) {
    do {
      let contentType = ContentType.parse(self.contentType)!
      let  x = odataClient.getDeserializer(contentType)
      let resource = try x.toEntitySet(self.res.data)
      // let resource = try x.toEntitySet(self.getRawResponse())
          
      let binder = odataClient.binder
      if let resource = resource {
        _entityCollection = binder.getODataEntitySet(resource)
        // let entityCollection = odataClient.getBinder().getODataEntitySet(resource)
      }
    }
    catch  {
      throw IllegalArgumentException.InvalidFormat
    }
      defer {
        self.close()
  }
        }
        return entityCollection
      }
 */

}


