//
//  ODataClientImp.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 23/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class ODataClientImp: ODataClient {
  
  let retrieveReqFact:RetrieveRequestFactory = RetrieveRequestFactoryImpl();

  func retrieveRequestFactory() -> RetrieveRequestFactory {
    
     return retrieveReqFact;
    
  }
  
}

