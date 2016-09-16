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
//  AbstractHttpClientFactory.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 01/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class AbstractHttpClientFactory {
  
  static let USER_AGENT:String = ""
  
  // TODO:
//  static {
//    final StringBuilder userAgent = new StringBuilder("Apache-Olingo");
//    
//    final InputStream input = AbstractHttpClientFactory.class.getResourceAsStream("/client.properties");
//    try {
//      final Properties prop = new Properties();
//      prop.load(input);
//      userAgent.append('/').append(prop.getProperty("version"));
//    }
//  catch (Exception e) {
//      LOG.warn("Could not get Apache Olingo version", e);
//    } finally {
//      IOUtils.closeQuietly(input);
//    }
//    
//    USER_AGENT = userAgent.toString();
//  }
}
