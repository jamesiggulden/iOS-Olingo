/*
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with this work for additional information
  regarding copyright ownership.  The ASF licenses this file
  to you under the Apache License, Version 2.0 (the
  "License") you may not use this file except in compliance
  with the License.  You may obtain a copy of the License at
 
    http://www.apache.org/licenses/LICENSE-2.0
 
  Unless required by applicable law or agreed to in writing,
  software distributed under the License is distributed on an
  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  KIND, either express or implied.  See the License for the
  specific language governing permissions and limitations
  under the License.
 */

// Implementation based on Olingo's original java V4 implmentation.  Further details can be found at http://olingo.apache.org

//
//  Constants.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 07/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


/// Constant values related to the OData protocol.
/// Created as global variables as they are lazy loaded and only instantiated when requested


  let EDM_NAMESPACE = "Edm"
  
  // Other stuff
  let UTF8:String = "UTF-8"
  let METADATA:String = "$metadata"
  let DEFAULT_PRECISION: Int = 40
  let DEFAULT_SCALE: Int = 25
  
  // Common Namespaces
  let NS_BASE:String = "http://docs.oasis-open.org/odata/ns/"
  let NS_DATASERVICES:String = "http://docs.oasis-open.org/odata/ns/data"
  let NS_METADATA:String = "http://docs.oasis-open.org/odata/ns/metadata"
  let NS_SCHEME:String = "http://docs.oasis-open.org/odata/ns/scheme"
  let NS_NAVIGATION_LINK_REL:String = "http://docs.oasis-open.org/odata/ns/related/"
  let NS_ASSOCIATION_LINK_REL:String = "http://docs.oasis-open.org/odata/ns/relatedlinks/"
  let NS_MEDIA_EDIT_LINK_REL:String = "http://docs.oasis-open.org/odata/ns/edit-media/"
  let NS_DELTA_LINK_REL:String = "http://docs.oasis-open.org/odata/ns/delta"
  
  // XML namespaces and prefixes
  let NS_ATOM:String = "http://www.w3.org/2005/Atom"
  let NS_GEORSS:String = "http://www.georss.org/georss"
  let NS_GML:String = "http://www.opengis.net/gml"
  let NS_ATOM_TOMBSTONE:String = "http://purl.org/atompub/tombstones/1.0"
  let PREFIX_DATASERVICES:String = "d"
  let PREFIX_METADATA:String = "m"
  let PREFIX_GEORSS:String = "georss"
  let PREFIX_GML:String = "gml"
  let SRS_URLPREFIX:String = "http://www.opengis.net/def/crs/EPSG/0/"
  
  // Link rel(s)
  let EDIT_LINK_REL:String = "edit"
  let SELF_LINK_REL:String = "self"
  let EDITMEDIA_LINK_REL:String = "edit-media"
  let NEXT_LINK_REL:String = "next"
  
  // XML elements and attributes
  let PROPERTIES:String = "properties"
  let ELEM_ELEMENT:String = "element"
  let ATTR_TYPE:String = "type"
  let ATTR_NULL:String = "null"
  let ATTR_XML_BASE:String = "base"
  let CONTEXT:String = "context"
  let ATTR_REL:String = "rel"
  let ATTR_TITLE:String = "title"
  let ATTR_METADATA:String = "metadata"
  let ATTR_HREF:String = "href"
  let ATTR_NAME:String = "name"
  let ATTR_REF:String = "ref"
  let ATTR_TARGET:String = "target"
  let ATTR_SRSNAME:String = "srsName"

  let ELEM_POINT:String = "Point"
  let ELEM_MULTIPOINT:String = "MultiPoint"
  let ELEM_POINTMEMBERS:String = "pointMembers"
  let ELEM_LINESTRING:String = "LineString"
  let ELEM_MULTILINESTRING:String = "MultiCurve"
  let ELEM_LINESTRINGMEMBERS:String = "curveMembers"
  let ELEM_POLYGON:String = "Polygon"
  let ELEM_POLYGON_EXTERIOR:String = "exterior"
  let ELEM_POLYGON_INTERIOR:String = "interior"
  let ELEM_POLYGON_LINEARRING:String = "LinearRing"
  let ELEM_MULTIPOLYGON:String = "MultiSurface"
  let ELEM_SURFACEMEMBERS:String = "surfaceMembers"
  let ELEM_GEOCOLLECTION:String = "MultiGeometry"
  let ELEM_GEOMEMBERS:String = "geometryMembers"
  let ELEM_POS:String = "pos"
  let ELEM_PROPERTY:String = "property"
  let ELEM_LINKS:String = "links"
  let ELEM_URI:String = "uri"
  let ELEM_REASON:String = "reason"
  let ELEM_DEletED_LINK:String = "deleted-link"
  let ATTR_SOURCE:String = "source"
  let ATTR_RELATIONSHIP:String = "relationship"
  let ANNOTATION:String = "annotation"
  
  // JSON
  let JSON_METADATA:String = "odata.metadata"
  let JSON_TYPE:String = "@odata.type"
  let JSON_ID:String = "@odata.id"
  let JSON_READ_LINK:String = "@odata.readLink"
  let JSON_EDIT_LINK:String = "@odata.editLink"
  let JSON_CONTEXT:String = "@odata.context"
  let JSON_ETAG:String = "@odata.etag"
  let JSON_MEDIA_ETAG:String = "@odata.mediaEtag"
  let JSON_MEDIA_CONTENT_TYPE:String = "@odata.mediaContentType"
  let JSON_MEDIA_READ_LINK:String = "@odata.mediaReadLink"
  let JSON_MEDIA_EDIT_LINK:String = "@odata.mediaEditLink"
  let JSON_METADATA_ETAG:String = "@odata.metadataEtag"
  let JSON_BIND_LINK_SUFFIX:String = "@odata.bind"
  let JSON_ASSOCIATION_LINK:String = "@odata.associationLink"
  let JSON_NAVIGATION_LINK:String = "@odata.navigationLink"
  let JSON_COUNT:String = "@odata.count"
  let JSON_NEXT_LINK:String = "@odata.nextLink"
  let JSON_DELTA_LINK:String = "@odata.deltaLink"
  let JSON_ERROR:String = "error"
  let JSON_NULL:String = "odata.null"
  let VALUE:String = "value"
  let JSON_URL:String = "url"
  let JSON_TITLE:String = "title"
  let JSON_COORDINATES:String = "coordinates"
  let JSON_GEOMETRIES:String = "geometries"
  let JSON_CRS:String = "crs"
  let JSON_NAME:String = "name"
  
  // Atom
  let ATOM_ELEM_ENTRY:String = "entry"
  let ATOM_ELEM_ENTRY_REF:String = "ref"
  let ATOM_ATTR_ID:String = "id"
  let ATOM_ELEM_FEED:String = "feed"
  let ATOM_ELEM_CATEGORY:String = "category"
  let ATOM_ELEM_COUNT:String = "count"
  let ATOM_ELEM_ID:String = "id"
  let ATOM_ELEM_TITLE:String = "title"
  let ATOM_ELEM_SUMMARY:String = "summary"
  let ATOM_ELEM_UPDATED:String = "updated"
  let ATOM_ELEM_LINK:String = "link"
  let ATOM_ELEM_CONTENT:String = "content"
  let ATOM_ELEM_ACTION:String = "action"
  let ATOM_ELEM_INLINE:String = "inline"
  let ATOM_ATTR_TERM:String = "term"
  let ATOM_ATTR_SCHEME:String = "scheme"
  let ATOM_ATTR_SRC:String = "src"
  let ATOM_ATTR_ETAG:String = "etag"
  let ATOM_ATTR_METADATAETAG:String = "metadata-etag"
  let ATOM_ELEM_DEletED_ENTRY:String = "deleted-entry"
  
  // error management
  let ERROR_CODE:String = "code"
  let ERROR_MESSAGE:String = "message"
  let ERROR_TARGET:String = "target"
  let ERROR_DETAILS:String = "details"
  let ERROR_INNERERROR:String = "innererror"
  
  // canonical functions to be applied via dynamic annotation <tt>Apply</tt>
  let CANONICAL_FUNCTION_CONCAT:String = "odata.concat"
  let CANONICAL_FUNCTION_FILLURITEMPLATE:String = "odata.fillUriTemplate"
  let CANONICAL_FUNCTION_URIENCODE:String = "odata.uriEncode"
  let MEDIA_EDIT_LINK_TYPE:String = "*/*"
  let ENTITY_NAVIGATION_LINK_TYPE:String = ContentType.APPLICATION_ATOM_XML_ENTRY!.toContentTypeString()
  let ENTITY_SET_NAVIGATION_LINK_TYPE:String = ContentType.APPLICATION_ATOM_XML_FEED!.toContentTypeString()
  let ASSOCIATION_LINK_TYPE:String = ContentType.APPLICATION_XML!.toContentTypeString()
  let ENTITY_COLLECTION_BINDING_LINK_TYPE:String = ContentType.APPLICATION_XML!.toContentTypeString()
  let ENTITY_BINDING_LINK_TYPE:String = ContentType.APPLICATION_XML!.toContentTypeString()
  
  // TODO: Qname
//  let QNAME_ATTR_XML_BASE:QName = QName(XMLConstants.XML_NS_URI, ATTR_XML_BASE)
//  let QNAME_ATTR_SRSNAME:QName = QName(NS_GML, ATTR_SRSNAME)
//  let QNAME_POINTMEMBERS:QName = QName(NS_GML, ELEM_POINTMEMBERS)
//  let QNAME_LINESTRING:QName = QName(NS_GML, ELEM_LINESTRING)
//  let QNAME_POLYGON:QName = QName(NS_GML, ELEM_POLYGON)
//  let QNAME_POLYGON_EXTERIOR:QName = QName(NS_GML, ELEM_POLYGON_EXTERIOR)
//  let QNAME_POLYGON_INTERIOR:QName = QName(NS_GML, ELEM_POLYGON_INTERIOR)
//  let QNAME_GEOMEMBERS:QName = QName(NS_GML, ELEM_GEOMEMBERS)
//  let QNAME_ATOM_ELEM_ENTRY:QName = QName(NS_ATOM, ATOM_ELEM_ENTRY)
//  let QNAME_ATOM_ATTR_ID:QName = QName(ATOM_ATTR_ID)
//  let QNAME_ATOM_ELEM_FEED:QName = QName(NS_ATOM, ATOM_ELEM_FEED)
//  let QNAME_ATOM_ELEM_CATEGORY:QName = QName(NS_ATOM, ATOM_ELEM_CATEGORY)
//  let QNAME_ATOM_ELEM_ID:QName = QName(NS_ATOM, ATOM_ELEM_ID)
//  let QNAME_ATOM_ELEM_TITLE:QName = QName(NS_ATOM, ATOM_ELEM_TITLE)
//  let QNAME_ATOM_ELEM_SUMMARY:QName = QName(NS_ATOM, ATOM_ELEM_SUMMARY)
//  let QNAME_ATOM_ELEM_UPDATED:QName = QName(NS_ATOM, ATOM_ELEM_UPDATED)
//  let QNAME_ATOM_ELEM_LINK:QName = QName(NS_ATOM, ATOM_ELEM_LINK)
//  let QNAME_ATOM_ELEM_CONTENT:QName = QName(NS_ATOM, ATOM_ELEM_CONTENT)


