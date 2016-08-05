/*
 * Copyright 2015 EnergySys Limited. All Rights Reserved.
 *
 * This software is the proprietary information of EnergySys Limited.
 * Use is subject to licence terms.
 * This software is not designed or supplied to be used in circumstances where
 * personal injury, death or loss of or damage to property could result from any
 * defect in the software.
 * In no event shall the developers or owners be liable for personal injury,
 * death or loss or damage to property, loss of business, revenue, profits, use,
 * data or other economic advantage or for any indirect, punitive, special,
 * incidental, consequential or exemplary loss or damage resulting from the use
 * of the software or documentation.
 * Developer and owner make no warranties, representations or undertakings of
 * any nature in relation to the software and documentation.
 */

//
//  This class defines a metadata query request.
//
//  Created by EnergySys on 28/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

// MARK: - Class

public class EdmMetadataResponseImpl: AbstractODataResponse, ODataRetrieveResponse {
  
  // MARK: - Methods
  
  // MARK: - Properties
  let theOdataClient: ODataClient = ODataClientFactory.getClient()
  
  /// Get the body of the returned response
  /// - parameters:
  ///   - none
  /// - returns: Edm object
  /// - throws: No error conditions are expected
  public func getBody() -> Any {
    var myEdm: Edm?
    do {
      try myEdm = theOdataClient.getReader().readMetadata(res.data)
    }
    catch {
      log.error("An error occurred during deserialization of the metadata.")
    }
    return myEdm
    //return String(data: res.data, encoding: NSUTF8StringEncoding)
  }

}