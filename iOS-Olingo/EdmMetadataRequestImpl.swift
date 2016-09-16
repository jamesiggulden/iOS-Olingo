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
public class EdmMetadataRequestImpl:AbstractODataRequest, EdmMetadataRequest {
  
  // MARK: - Properties
  
  var theQueryURL: NSURL
  
  // MARK: - Init
  
  /// Initializer.
  /// - parameters:
  ///   - odataClient the OdataClient
  ///   - query: the base URL to the OData service
  /// - returns: nil
  /// - throws: No error conditions are expected
  init(odataClient:ODataClient, query:NSURL) {
    theQueryURL = query
    let myUrlString = query.scheme + "://" + query.host! + query.path!
    
    if (myUrlString.rangeOfString(METADATA) == nil) {
      if (!myUrlString.hasSuffix("/")) {
        theQueryURL = NSURL(string: myUrlString + "/" + METADATA)!
      }
      else {
        theQueryURL = NSURL(string: myUrlString + METADATA)!
      }
    }
    
    super.init(odataClient: odataClient,method: HttpMethod.GET, uri: theQueryURL)
  }
  
  // MARK: - Methods
  
  /// Return the XML metadata
  /// - parameters:
  ///   - none
  /// - returns: nil
  /// - throws: No error conditions are expected
  ///func getXMLMetadata() -> XMLMetadata
  
  /// Request execute, return an OData response
  /// - parameters:
  ///   - none
  /// - returns: ODataRetrieveResponse
  /// - throws: ODataException
  public func execute() throws -> ODataRetrieveResponse! {
    var myResponse: EdmMetadataResponseImpl
    do {
      let myResult = try doExecute()
      myResponse = EdmMetadataResponseImpl(odataClient: odataClient,res: myResult)
    }
    catch {
      throw ODataException.DataProviderException
    }
    return myResponse
  }
  
  public override func getDefaultFormat() -> ContentType {
    return ContentType.APPLICATION_XML!
  }
  
}
