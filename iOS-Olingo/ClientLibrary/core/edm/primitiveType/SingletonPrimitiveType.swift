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

// Implementation based on Olingo's original java V4 implmentation.  Further details can be found at http://olingo.apache.org

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
  
  // MARK: - Stored Properties
  
  
  // MARK: - Computed Properties
  
  public override var kind:EdmTypeKind {
    return EdmTypeKind.PRIMITIVE
  }
  
  public override var namespace:String {
    return EDM_NAMESPACE
  }
  
  
  public override var name: String {
    
    let className = String(self.self)
    return className.substringFromIndex(className.startIndex.advancedBy(3))
    //return getClass().getSimpleName().substring(3)
  }

  // MARK: - Init

  // MARK: - Methods

  public func equals(obj:AnyObject) -> Bool {
    if self === obj {
      return true
    }
    else {
      return self.dynamicType == obj.dynamicType
    }
  }
  
  // TODO:
  /*
  public int hashCode() {
    return getClass().hashCode()
  }
  
  

 */
  
  

}