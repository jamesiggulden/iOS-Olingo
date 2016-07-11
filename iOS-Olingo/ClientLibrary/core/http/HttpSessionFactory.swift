//
//  HttpSessionFactory.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 05/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


public protocol HttpSessionFactory {
  
  // TODO:
  
  func create() -> NSURLSession
  func close(httpSession:NSURLSession)
  
}
