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
  
  @IBOutlet weak var StatusConsole: UITextView!
  
  @IBOutlet weak var RawConsole: UITextView!
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

  
    if var entitySet = entitySetField.text{
      if entitySet.isEmpty || entitySet == "entity set" {
        // request service document
        ResetStatusConsole("No request provided")
        AppendToStatusConsole("Stub for service document request")
        ResetConsole("")
        ResetRawConsole("")
        return
      }
      if entitySet.containsString("\"") {
        entitySet = entitySet.stringByReplacingOccurrencesOfString("\"", withString: "'")
      }
      urlString += "/"+entitySet
      guard let uri:NSURL = NSURL(string:urlString)! else {
        AppendToStatusConsole("Invalid URL format")
      }
      if entitySet.containsString("$metadata"){
        // request metadata
        ResetStatusConsole("No request provided")
        AppendToStatusConsole("Stub for metadata request")
        ResetConsole("")
        ResetRawConsole("")
      }
      else {
        // request entity set (at present) will expand as functionality increases (option picker?)
        ResetStatusConsole("Retrieve Request Factory")
        log.debug("Retrieve Request Factory")
        let retriveRequestFactory = client.retrieveRequestFactory
        
        if entitySet.containsString("(") {
          processEntity(retriveRequestFactory,uri: uri)
        }
        else {
          processEntitySet(retriveRequestFactory,uri: uri)
        }
      }
    }
    else {
      // submit the root only
      let uri:NSURL = NSURL(string:urlString)!
    }

  }
  
  func processEntitySet(retriveRequestFactory:RetrieveRequestFactory,uri:NSURL) {
    
    var startTime:NSDate
    var endTime:NSDate
    var duration:Double
    var consoleOutput:String = ""
    
    AppendToStatusConsole("Build Entity Set Request")
    log.debug("Build Entity Set Request")
    startTime = NSDate()
    let entitySetRequest = retriveRequestFactory.entitySetRequest(uri)
    AppendToStatusConsole("Execute Built Request")
    
    log.debug("Execute Built Request")
    guard let response = entitySetRequest.execute() else {
      AppendToConsole("Nil returned from execute request")
      return
    }
    endTime = NSDate()
    duration = endTime.timeIntervalSinceDate(startTime)
    AppendToStatusConsole("Time to execute build request: \(round(duration*100)/100) secs")
    
    AppendToStatusConsole("Response Status Code: \(response.statusCode)")
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
      AppendToRawConsole("Data:")
      AppendToRawConsole(String(dataString))
    }
    else {
      AppendToConsole("No data returned")
      log.warn("No data returned")
    }
    startTime = NSDate()
    do {
      AppendToStatusConsole("Get Body")
      guard let entitySet = try response.getBody() else {
        AppendToConsole("No data in body")
        return
      }
      endTime = NSDate()
      duration = endTime.timeIntervalSinceDate(startTime)
      AppendToStatusConsole("Time to extract returned response: \(round(duration*100)/100) secs")
      
      AppendToConsole("")
      AppendToConsole("Body Content")
      AppendToConsole("Number of Entiites returned (info from service): \(entitySet.count)")
      AppendToConsole("Next URL: \(entitySet.next.debugDescription)")
      AppendToStatusConsole("Number of Entiites returned (calculated): \(entitySet.entities.count)")
      
      let entityList = entitySet.entities
      startTime = NSDate()
      for entity in entityList {
        if let name = entity.id?.absoluteString {
          consoleOutput += "\n"
          consoleOutput += "\n \(name)"
        }
        for property in entity.properties {
          var name:String = ""
          var val:String = ""
          var typeKind:String = ""
          
          if let propertyValue = property.value.asPrimitive {
            if let propertyValueValue = propertyValue.value {
              name = String(property.name)
              val = String(propertyValueValue)
              if let tk = propertyValue.typeKind?.toString() {
                typeKind = tk
              }
            }
            consoleOutput += "\n    \(name) : \(val)  : (\(typeKind))"
          }
        }
        
      }
      AppendToConsole(consoleOutput)
      endTime = NSDate()
      duration = endTime.timeIntervalSinceDate(startTime)
      AppendToStatusConsole("Time to extract returned response: \(round(duration*100)/100) secs")
    }
    catch {
      AppendToConsole("No content returned")
    }
  }
  
  func processEntity(retriveRequestFactory:RetrieveRequestFactory,uri:NSURL) {
    
    var startTime:NSDate
    var endTime:NSDate
    var duration:Double
    var consoleOutput:String = ""
    
    AppendToStatusConsole("Build Entity Set Request")
    log.debug("Build Entity Set Request")
    startTime = NSDate()
    let entityRequest = retriveRequestFactory.entityRequest(uri)
    AppendToStatusConsole("Execute Built Request")
    
    log.debug("Execute Built Request")
    guard let response = entityRequest.execute() else {
      AppendToConsole("Nil returned from execute request")
      return
    }
    endTime = NSDate()
    duration = endTime.timeIntervalSinceDate(startTime)
    AppendToStatusConsole("Time to execute build request: \(round(duration*100)/100) secs")
    
    AppendToStatusConsole("Response Status Code: \(response.statusCode)")
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
      AppendToRawConsole("Data:")
      AppendToRawConsole(String(dataString))
    }
    else {
      AppendToConsole("No data returned")
      log.warn("No data returned")
    }
    startTime = NSDate()
    do {
      AppendToStatusConsole("Get Body")
      guard let entity = try response.getBody() else {
        AppendToConsole("No data in body")
        AppendToStatusConsole("No data in body")
        
        return
      }
      endTime = NSDate()
      duration = endTime.timeIntervalSinceDate(startTime)
      AppendToStatusConsole("Time to extract returned response: \(round(duration*100)/100) secs")
      
      AppendToConsole("Body Content")

      startTime = NSDate()
      
      if let name = entity.id?.absoluteString {
        consoleOutput += "\n"
        consoleOutput += "\n \(name)"
      }
      for property in entity.properties {
        var name:String = ""
        var val:String = ""
        var typeKind:String = ""
        
        if let propertyValue = property.value.asPrimitive {
          if let propertyValueValue = propertyValue.value {
            name = String(property.name)
            val = String(propertyValueValue)
            if let tk = propertyValue.typeKind?.toString() {
              typeKind = tk
            }
          }
          consoleOutput += "\n  \(name) : \(val)  : (\(typeKind))"
        }
      }
      
      
      AppendToConsole(consoleOutput)
      endTime = NSDate()
      duration = endTime.timeIntervalSinceDate(startTime)
      AppendToStatusConsole("Time to extract returned response: \(round(duration*100)/100) secs")
    }
    catch {
      AppendToConsole("No content returned")
      AppendToStatusConsole("No content returned")
    }
  }

  
  func AppendToConsole(msg: String) {
      Console.text = Console.text + "\n" + msg
      Console.scrollRangeToVisible(NSRange(location: Console.text.characters.count,length: 1))
  }
  
  func AppendToRawConsole(msg: String) {
    RawConsole.text = RawConsole.text + "\n" + msg
    RawConsole.scrollRangeToVisible(NSRange(location: RawConsole.text.characters.count,length: 1))
  }
  
  func AppendToStatusConsole(msg: String) {
    StatusConsole.text = StatusConsole.text + "\n" + msg
    StatusConsole.scrollRangeToVisible(NSRange(location: StatusConsole.text.characters.count,length: 1))
  }
  
  
  func ResetConsole(msg:String) {
    Console.text = msg
  }
  
  func ResetRawConsole(msg:String) {
    RawConsole.text = msg
  }
  
  func ResetStatusConsole(msg:String) {
    StatusConsole.text = msg
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

