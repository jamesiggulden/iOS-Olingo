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
  
  
  @IBAction func submit(sender: AnyObject) {
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

