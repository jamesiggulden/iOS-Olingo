//
//  ViewController.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 10/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var serviceRootField: UITextField!
  
  @IBOutlet weak var entitySetField: UITextField!
  
  
  @IBAction func testProps(sender: AnyObject) {
    
    var pt:PropertyTest = PropertyTestImp()
    NSLog("Test prop1: \(pt.p1)")
    NSLog("Test prop2: \(pt.p2)")
    NSLog("Test prop3: \(pt.p3)")
    NSLog("Test prop4: \(pt.p4)")
    NSLog("Test prop5: \(pt.p5)")
    NSLog("Test prop6: \(pt.p6)")
    pt.p1=11
    NSLog("Set prop1 to 11")
    NSLog("Test prop1: \(pt.p1)")
    //pt.p2=22
    NSLog("Test prop2: \(pt.p2)")
    NSLog("Set prop3 to 333")
    pt.p3=333
    NSLog("Test prop3: \(pt.p3)")
    NSLog("Set prop4 to 44")
    pt.p4=44
    NSLog("Test prop4: \(pt.p4)")
    pt.p5=55
    NSLog("Set prop5 to 55")
    NSLog("Test prop5: \(pt.p5)")
    NSLog("Test prop6: \(pt.p6)")
    
  }
  
  
  @IBAction func submit(sender: AnyObject) {
  }
  
  
  @IBAction func testClientFactory(sender: AnyObject) {
    
    //let oDataClientFac:ODataClientFactory = ODataClientFactory()
    
    //let client:ODataClient = oDataClientFac.getClient()
    
    let client:ODataClient = ODataClientFactory().getClient()
    
  }
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view, typically from a nib...
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let responseController = segue.destinationViewController as! ResponseViewController
    
    guard ((serviceRootField.text?.isEmpty) != nil) else {
      responseController.URIData = "Invalid URL"
      return
    }
    guard ((entitySetField.text?.isEmpty) != nil) else {
      responseController.URIData = "Invalid URL"
      return
    }
    
    let URIData = serviceRootField.text! + "/" + entitySetField.text!
    
    responseController.URIData = URIData
    
    
    
    
    

    
  }
  
  
  
  
  
  


}

