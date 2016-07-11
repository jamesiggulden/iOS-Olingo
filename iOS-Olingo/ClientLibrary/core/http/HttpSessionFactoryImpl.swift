//
//  DefaultHttpSessionFactory.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 05/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


///  Default implementation returning HttpSession with default parameters.

public class HttpSessionFactoryImpl: HttpSessionFactory {
  
  // TODO:
  
  public func create() -> NSURLSession {
  
    // start with the simplest default method to start with
    let session = NSURLSession.sharedSession()

    return session
  }
  
  
  public func close(httpSession:NSURLSession) {
    
    // need to add ability to close session down cleanly
   
  }
  
}
