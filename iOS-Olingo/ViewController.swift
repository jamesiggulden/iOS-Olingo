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
  
  @IBOutlet weak var Northwind: UILabel!
  
  @IBOutlet weak var TripPin: UILabel!
  
  @IBOutlet weak var Status: UILabel!
  
  @IBOutlet weak var Console: UITextView!
  
  
  @IBAction func ClearConsole(sender: AnyObject) {
    Console.text = ""
  }
  
  @IBAction func SubmitNorthwind(sender: AnyObject) {
//    guard let root = Northwind.text else {
//      return
//    }
    odataLibrarySubmit("http://services.odata.org/V4/Northwind/Northwind.svc")

  }
  

  @IBAction func SubmitTripPin(sender: AnyObject) {
    
//    guard let root = TripPin.text else {
//      return
//    }
    odataLibrarySubmit("http://services.odata.org/v4/TripPinServiceRW")
    
  }

  
  @IBAction func testProps(sender: AnyObject) {
      }
  
  
  
  @IBAction func submit(sender: AnyObject) {
    
    guard let root = serviceRootField.text else {
      return
    }
    odataLibrarySubmit(root)
    
    
//    guard let uri:NSURL = NSURL(string:"http://services.odata.org/V4/Northwind/Northwind.svc/Orders")! else {
//      return
//    }
    

  }
  
  
//  @IBAction func SubmitNorthwind(sender: AnyObject) {
//    guard let root = Northwind.text else {
//      return
//    }
//    odataLibrarySubmit(root)
//  }
//  
//  
//  @IBAction func SubmitTripPin(sender: AnyObject) {
//    guard let root = TripPin.text else {
//      return
//    }
//    odataLibrarySubmit(root)
//  }
  
  
  func testClientFactory(sender: AnyObject) {
    
//    let odataRequest = AbstractODataRequest(odataClient: client,method: HttpMethod.GET,uri: uri)
//    
//    do {
//      //try odataRequest.doExecute()
//      let odataResult = try odataRequest.doExecute()
//      print (odataResult.data.length)
//
//    }
//    catch {
//      
//    }

//    let response = client.retrieveRequestFactory.getEntityRequest(uri).execute()
//    let body = response.getBody()
//    

  }
  
  
  func odataLibrarySubmit(root:String) {
    let client:ODataClient = ODataClientFactory().getClient()
    log.logMode = Log.LogMode.DEBUG
  
    var urlString = root
  
    if let entitySet = entitySetField.text{
      urlString += "/"+entitySet
      let uri:NSURL = NSURL(string:urlString)!
      if entitySet.containsString("$metadata"){
        // request metadata
      }
      else {
        // request entity set (at present) will expand as functionality increases (option picker?)
        ResetConsole("Retrieve Request Factory")
        log.debug("Retrieve Request Factory")
        let retriveRequestFactory = client.retrieveRequestFactory
        AppendToConsole("Build Entity Set Request")
        log.debug("Build Entity Set Request")
        let entitySetRequest = retriveRequestFactory.entitySetRequest(uri)
        AppendToConsole("Execute Built Request")
        log.debug("Execute Built Request")
        let response = entitySetRequest.execute()
        AppendToConsole("Response Status Code: \(response.statusCode)")
        log.info ("Response Status Code: \(response.statusCode)")
        Status.text = "Response Status Code: \(response.statusCode)"
        
        let headerNames = response.headerNames
        let headers = response.headers
        AppendToConsole("Headers :")
        for (name,value) in headers {
          log.debug ("Header Name: \(name) : Value: \(value)")
          // AppendToConsole("Header Name: \(name) : Value: \(value)")
          AppendToConsole("Name: \(name) : Value: \(value)")
        }
        
        AppendToConsole("Header Names :")
        for name in headerNames {
          AppendToConsole(name)
          log.debug ("Header Name: \(name)")
        }
        
        if let dataString = NSString(data:response.res.data!,encoding: NSUTF8StringEncoding) {
          log.debug(String(dataString))
          AppendToConsole("Data:")
          AppendToConsole(String(dataString))
        }
        else {
          AppendToConsole("No data returned")
          log.warn("No data returned")
        }
        
        let body = response.getBody()
        
      }
    }
    else {
      // submit the root only
      let uri:NSURL = NSURL(string:urlString)!
    }

  }
  
  func AppendToConsole(msg: String) {
      Console.text = Console.text + "\n" + msg
  }
  func ResetConsole(msg:String) {
    Console.text = msg
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
//    let responseController = segue.destinationViewController as! ResponseViewController
//    
//    guard ((serviceRootField.text?.isEmpty) != nil) else {
//      responseController.URIData = "Invalid URL"
//      return
//    }
//    guard ((entitySetField.text?.isEmpty) != nil) else {
//      responseController.URIData = "Invalid URL"
//      return
//    }
//    
//    let URIData = serviceRootField.text! + "/" + entitySetField.text!
//    
//    responseController.URIData = URIData
    
    
    
    
    

    
  }
  
  
  
  
  
  


}

