//
//  ODataClient.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 23/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

protocol ODataClient {
  var retrieveReqFact:RetrieveRequestFactory {get}
  func retrieveRequestFactory()-> RetrieveRequestFactory
}
