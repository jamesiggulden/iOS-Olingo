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
//  Extensions.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 06/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


extension NSURLSession {
  
  /// Wrapper to send synchronous requests
  /// - parameters:
  ///   - request: NSURL request to be sent
  ///   - completionHandler: closure expression to perform request & repsonse
  /// - returns: No return value (void)
  /// - throws: No error conditions are expected
  func sendSynchronousRequest(request: NSURLRequest, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
    let semaphore = dispatch_semaphore_create(0)
    let task = self.dataTaskWithRequest(request) { data, response, error in
      completionHandler(data, response, error)
      dispatch_semaphore_signal(semaphore)
    }
    
    task.resume()
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
  }
   
  /// Wrapper to send asynchronous requests
  /// - parameters:
  ///   - request: NSURL request to be sent
  ///   - completionHandler: closure expression to perform request & repsonse
  /// - returns: session data task of type NSURLSessionDataTask
  /// - throws: No error conditions are expected
  func sendAsynchronousRequest(request: NSURLRequest, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
    let task = self.dataTaskWithRequest(request) { data, response, error in
      completionHandler(data, response, error)
    }
    
    task.resume()
    return task
  }
} 

extension String {
  
  /// return string between 2 provided string values
  /// - parameters:
  ///   - start: string to compare from
  ///   - end: string to compare to
  /// - returns: string between the passed in values otherwise return nil
  /// - throws: No error conditions are expected
  func substringBetweenStrings (start:String, end:String) -> String?{
    guard var idx = self.rangeOfString(start) else {
      return nil
    }
    guard let endIdx = self.rangeOfString(end, options: .BackwardsSearch)?.startIndex else {
      return nil
    }
    idx.startIndex = idx.startIndex.advancedBy(start.characters.count)
    idx.endIndex = endIdx
    return self.substringWithRange(idx)
  }
  
  /// check if string starts with string parameter
  /// - parameters:
  ///   - checkFor: string to check for
  /// - returns: true if string found at start of string, otherwise return false
  /// - throws: No error conditions are expected
  func startsWith(checkFor:String) -> Bool {
    let idx = self.rangeOfString(checkFor)?.startIndex
    if idx == self.startIndex {
      return true
    }
    else {
      return false
    }
  }
   
  /// check if string ends with string parameter
  /// - parameters:
  ///   - checkFor: string to check for
  /// - returns: true if string found at end of string, otherwise return false
  /// - throws: No error conditions are expected
  func endsWith(checkFor:String) -> Bool {
    let idx = self.rangeOfString(checkFor, options: .BackwardsSearch)?.endIndex
    if idx == self.endIndex {
      return true
    }
    else {
      return false
    }
  }
}