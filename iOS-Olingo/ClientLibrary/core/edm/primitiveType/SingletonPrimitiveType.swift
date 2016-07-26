/*
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with this work for additional information
  regarding copyright ownership.  The ASF licenses this file
  to you under the Apache License, Version 2.0 (the
  "License") you may not use this file except in compliance
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
//  SingletonPrimitiveType.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 19/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// Abstract singleton implementation of the EDM primitive-type interface.
public class SingletonPrimitiveType: AbstractPrimitiveType {
  
  
  public func equals(obj:AnyObject) -> Bool {
    return self === obj // TODO: || obj != nil && getClass() == obj.getClass()
  }
  
  // TODO:
  /*
  public int hashCode() {
    return getClass().hashCode()
  }
  
  
  public var namespace:String {
    return EDM_NAMESPACE
  }
  
  
  public func getName() -> String {
    return getClass().getSimpleName().substring(3)
  }
 */
  
  
  public func getKind() -> EdmTypeKind {
    return EdmTypeKind.PRIMITIVE
  }
}