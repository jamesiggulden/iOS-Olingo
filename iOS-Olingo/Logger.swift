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

// Implementation based on Olingo's original java V4 implmentation.  Further details can be found at http://olingo.apache.org

//
//  Logger.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 11/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//


import Foundation

// Simple logging mechanism to wrap NSLog
public struct Log {
  // MARK: - Stored Properties

  public enum LogMode : Int {
    case DEBUG = 1
    case INFO = 2
    case WARNING = 3
    case ERROR = 4
    case NONE = 5
  }
  
  public var logMode = LogMode(rawValue: 4)
  
  // MARK: - Computed Properties

  public var isDebug:Bool {
    get {
      return logMode == LogMode.DEBUG
    }
  }
  
  // MARK: - Methods
   
  /// write message to log if logging mode is debug or info
  /// - parameters:
  ///   - logMsg: message to log
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  func info (logMsg:String) {
    if logMode?.rawValue <= LogMode.INFO.rawValue {
      let msg = "INFO: \(logMsg)"
      NSLog(msg)
    }
  }
  
  /// write message to log if logging mode is debug,info or warning
  /// - parameters:
  ///   - logMsg: message to log
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  func warn (logMsg:String) {
    if logMode?.rawValue <= LogMode.WARNING.rawValue {
      let msg = "WARNING: \(logMsg)"
      NSLog(msg)
    }
  }
  
  /// write message to log if logging mode is debug,info, warning or error
  /// - parameters:
  ///   - logMsg: message to log
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  func error (logMsg:String) {
    if logMode?.rawValue <= LogMode.ERROR.rawValue {
      let msg = "ERROR: \(logMsg)"
      NSLog(msg)
    }
  }
  
  /// write message to log if logging mode is debug
  /// - parameters:
  ///   - logMsg: message to log
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  func debug (logMsg:String) {
    if logMode?.rawValue <= LogMode.DEBUG.rawValue {
      let msg = "DEBUG: \(logMsg)"
      NSLog(msg)
    }
  }
  
}


var log = Log()


