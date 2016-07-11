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
//  PreferenceNameE.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 04/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

enum PreferenceName:String {
  case ALLOW_ENTITY_REFERENCES = "odata.allow-entityreferences"
  case CALLBACK = "odata.callback"
  case CONTINUE_ON_ERROR = "odata.continue-on-error"
  case INCLUDE_ANNOTATIONS = "odata.include-annotations"
  case MAX_PAGE_SIZE = "odata.maxpagesize"
  case TRACK_CHANGES = "odata.track-changes"
  case RETURN = "return"
  case RESPOND_ASYNC = "respond-async"
  case WAIT = "wait"
  case RETURN_CONTENT = "return-content"
  case RETURN_NO_CONTENT = "return-no-content"
  case KEY_AS_SEGMENT = "KeyAsSegment"
}
