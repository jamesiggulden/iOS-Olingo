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
//  ServiceDocumentItemImpl.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 07/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public final class ServiceDocumentItemImpl: ServiceDocumentItem {
  
  // MARK: - Stored Properties

  public var name:String = ""
  public var url:String = ""
  public var title:String = ""
  
  // MARK: - Computed Properties
  
  
  // MARK: - Init


  // MARK: - Methods

  // TODO: func hashCode() -> Int
//  public func hashCode() -> Int {
//    final int prime = 31
//    int result = 1
//    result = prime * result + ((name == null) ? 0 : name.hashCode())
//    result = prime * result + ((title == null) ? 0 : title.hashCode())
//    result = prime * result + ((url == null) ? 0 : url.hashCode())
//    return result
//  }
  
  // TODO: func equals(Object obj) -> Bool
//  public func equals(Object obj) -> Bool {
//    if (this == obj) {
//      return true
//    }
//    if (obj == null) {
//      return false
//    }
//    if (!(obj instanceof ServiceDocumentItemImpl)) {
//      return false
//    }
//    ServiceDocumentItemImpl other = (ServiceDocumentItemImpl) obj
//    if (name == null) {
//      if (other.name != null) {
//        return false
//      }
//    } else if (!name.equals(other.name)) {
//      return false
//    }
//    if (title == null) {
//      if (other.title != null) {
//        return false
//      }
//    } else if (!title.equals(other.title)) {
//      return false
//    }
//    if (url == null) {
//      if (other.url != null) {
//        return false
//      }
//    } else if (!url.equals(other.url)) {
//      return false
//    }
//    return true
//  }
  

  public func toString() -> String {
    return "ServiceDocumentItemImpl{name='\(name)', url='\(url)', title='\(title)'}"
  }
}
