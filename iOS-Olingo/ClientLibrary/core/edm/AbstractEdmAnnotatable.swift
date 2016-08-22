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
//  AbstractEdmAnnotatable.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 14/07/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public class AbstractEdmAnnotatable: EdmAnnotatable {
  
  // MARK: - Stored Properties

  // TODO: Annotations
  private final let  annotatable:CsdlAnnotatable
  //private  let annotations:[EdmAnnotation]
  final let edm:Edm
  
  // MARK: - Computed Properties

  
  // MARK: - Init

  init(edm:Edm, annotatable:CsdlAnnotatable ) {
    self.edm = edm
    self.annotatable = annotatable
  }
  
  // MARK: - Methods
  
  // TODO: Annotations
  /*
  public func getAnnotation(term:EdmTerm , qualifier:String) -> EdmAnnotation {
    var result: EdmAnnotation ?
    for annotation in getAnnotations() {
      if (term.getFullQualifiedName() == annotation.getTerm().getFullQualifiedName()) {
        if (qualifierEqual(qualifier, annotation.getQualifier())) {
          result = annotation
          break
        }
      }
    }
    return result
  }
  
  private func qualifierEqual(qualifier:String?, annotationQualifier:String?) -> Bool {
    return (qualifier == nil && annotationQualifier == nil) || (qualifier != nil && qualifier ==  annotationQualifier)
  }
  
  
  public func getAnnotations() -> [EdmAnnotation]? {
    guard let annotations = annotations else {
      var annotationsLocal = [EdmAnnotation]()
      if let  annotatable = annotatable {
        for annotation in annotatable.getAnnotations()) {
          annotationsLocal.append(EdmAnnotationImpl(edm, annotation))
        }
        
        annotations = annotationsLocal
      }
      return annotations
    }
    return nil
  }
 */
}
