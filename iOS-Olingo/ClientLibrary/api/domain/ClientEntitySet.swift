
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

//
//  ClientEntitySet.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 13/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// OData entity collection. If pagination was used to get this instance, forward page navigation URI will be available
public protocol ClientEntitySet{ // extends  ClientAnnotatable {
  
  /// Link to the next page
  var next:NSURL?  {get}
  
  /// Number of ODataEntities contained in this entity set
  var count:Int {get set}
  
  // TODO: Delta
  /// delta link
  //var deltaLink:NSURL {get set}
  
  /// array of contained entities
  var entities: [ClientEntity]  {get set}
  
}
