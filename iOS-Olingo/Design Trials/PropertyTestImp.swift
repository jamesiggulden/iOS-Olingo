//
//  PropertyTestImp.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 23/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

class PropertyTestImp : PropertyTest{
  var p1 = 1
  var p2 = 2
  var p6 = 6
  
  //var p3 = 3
  
  private var _p3 = 33
  
  var p3: Int {
    get{
      return _p3
    }
    set{
      _p3 = newValue
    }
  }
  var p4: Int = 4 {
    willSet(newVal){
      NSLog("The current value of p4 is \(p4) and will be updated to \(newVal)")
    }
    didSet{
      NSLog("The current value of p4 is \(p4) and was previously \(oldValue)")
    }
  }
  
  
  var p5: Int {
    get{
      return(p1+p2)
    }
    set{
      p6=newValue
    }
    
  }
  
  
}
