//
//  ODataClientFactory.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 23/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation
public final class ODataClientFactory {
  
  func getClient() -> ODataClient {
    
    let client:ODataClient = ODataClientImp()
    return client
  }
  
}