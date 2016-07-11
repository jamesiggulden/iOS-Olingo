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

//
//  HttpHeader.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 28/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

/// HTTP Header constants
enum HttpHeader:String {
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1)
  case ACCEPT = "Accept"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.2)
  case ACCEPT_CHARSET = "Accept-Charset"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.3)
  case ACCEPT_ENCODING = "Accept-Encoding"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4)
  case ACCEPT_LANGUAGE = "Accept-Language"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.7)
  case ALLOW = "Allow"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.8)
  case AUTHORIZATION = "Authorization"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9)
  case CACHE_CONTROL = "Cache-Control"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11)
  case CONTENT_ENCODING = "Content-Encoding"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.12)
  case CONTENT_LANGUAGE = "Content-Language"
  
   ///See <a href="http://www.rfc-editor.org/rfc/rfc2392.txt">RFC 2392</a>
  case CONTENT_ID = "Content-ID"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.13)
  case CONTENT_LENGTH = "Content-Length"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.14)
  case CONTENT_LOCATION = "Content-Location"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.17)
  case CONTENT_TYPE = "Content-Type"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.18)
  case DATE = "Date"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.19)
  case ETAG = "ETag"
  
   ///See <a href="http://www.rfc-editor.org/rfc/rfc7231.txt">RFC 7231</a>
  case EXPECT = "Expect"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.21)
  case EXPIRES = "Expires"
  
   /// See <a href="http://www.rfc-editor.org/rfc/rfc7231.txt">RFC 7231</a>
  case FROM = "From"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.23)
  case HOST = "Host"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.24)
  case IF_MATCH = "If-Match"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.25)
  case IF_MODIFIED_SINCE = "If-Modified-Since"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.26)
  case IF_NONE_MATCH = "If-None-Match"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.28)
  case IF_UNMODIFIED_SINCE = "If-Unmodified-Since"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.29)
  case LAST_MODIFIED = "Last-Modified"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.30)
  case LOCATION = "Location"
  
   /// See [OData protocol HTTP/1.1 documentation](http://tools.ietf.org/html/rfc5988#page-6">Web Linking (IETF RFC-5988) documentation</a>}
  case LINK = "Link"
  
   /// See <a href="http://www.rfc-editor.org/rfc/rfc7231.txt">RFC 7231</a>
  case MAX_FORWARDS = "Max-Forwards"
  
   /// OData Prefer Header.
   /// See [OData Version 4.0 Part 1: Protocol](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part1-protocol.html#_Toc406398233) and [RFC 7240](https://www.ietf.org/rfc/rfc7240.txt)
  case PREFER = "Prefer"
  
   /// OData Preference-Applied Header.
   /// See [OData Version 4.0 Part 1: Protocol](http://docs.oasis-open.org/odata/odata/v4.0/odata-v4.0-part1-protocol.html#_Toc406398247) and [RFC 7240](https://www.ietf.org/rfc/rfc7240.txt)
  case PREFERENCE_APPLIED = "Preference-Applied"
  
  /// See [RFC 7233](http://www.rfc-editor.org/rfc/rfc7233.txt)
  case RANGE = "Range"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.37)
  case RETRY_AFTER = "Retry-After"
  
  /// See [RFC 7230](http://www.rfc-editor.org/rfc/rfc7230.txt)
  case TE = "TE"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43)
  case USER_AGENT = "User-Agent"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.44)
  case VARY = "Vary"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.47)
  case WWW_AUTHENTICATE = "WWW-Authenticate"
  
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.ietf.org/rfc/rfc2109.txt">IETF RFC 2109</a>}
  case COOKIE = "Cookie"
  
   /// See [OData protocol HTTP/1.1 documentation](http://www.ietf.org/rfc/rfc2109.txt">IETF RFC 2109</a>}
  case SET_COOKIE = "Set-Cookie"
  
  /// Non standard header
  case X_HTTP_METHOD = "X-HTTP-Method"
  
  /// Non standard header
  case X_HTTP_METHOD_OVERRIDE = "X-HTTP-Method-Override"
  
  /// Custom Header defined in the OData standard
  case ODATA_VERSION = "OData-Version"
  
  /// Custom Header defined in the OData standard
  case ODATA_MAX_VERSION = "OData-MaxVersion"
  
  /// Custom Header defined in the OData standard
  case ODATA_ENTITY_ID = "OData-EntityID"
  
  /// Custom Header defined in the OData standard
  case ODATA_ISOLATION = "OData-Isolation"

}