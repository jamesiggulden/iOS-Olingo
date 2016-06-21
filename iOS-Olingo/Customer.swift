//
//  Customer.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 21/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

class Customer {
  var customerID: String?
  var companyName: String?
  var contactName: String?
  
  init(companyName: String?, contactName: String?, customerID: String?) {
    self.companyName = companyName
    self.contactName = contactName
    self.customerID = customerID
  }
}
