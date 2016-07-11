//
//  AbstractHttpClientFactory.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 01/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class AbstractHttpClientFactory {
  
  // redundent??
  //private static let Logger LOG = LoggerFactory.getLogger(AbstractHttpClientFactory.class);
  
  static let USER_AGENT:String = ""
  
  // TODO:
//  static {
//    final StringBuilder userAgent = new StringBuilder("Apache-Olingo");
//    
//    final InputStream input = AbstractHttpClientFactory.class.getResourceAsStream("/client.properties");
//    try {
//      final Properties prop = new Properties();
//      prop.load(input);
//      userAgent.append('/').append(prop.getProperty("version"));
//    }
//  catch (Exception e) {
//      LOG.warn("Could not get Apache Olingo version", e);
//    } finally {
//      IOUtils.closeQuietly(input);
//    }
//    
//    USER_AGENT = userAgent.toString();
//  }
}
