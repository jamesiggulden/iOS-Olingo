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
  @IBOutlet weak var entityIDField: UITextField!

  
  @IBOutlet weak var numRecsSkipField: UITextField!
  @IBOutlet weak var numRecsToReturnField: UITextField!
  @IBOutlet weak var TripPin: UILabel!
  
  @IBOutlet weak var Status: UILabel!
  @IBOutlet weak var filterQueryField: UITextField!
  @IBOutlet weak var propertyFilterField: UITextField!
  @IBOutlet weak var orderByField: UITextField!
  @IBOutlet weak var urlLabel: UILabel!
  
  @IBOutlet weak var Console: UITextView!
  
  @IBOutlet weak var StatusConsole: UITextView!
  
  @IBOutlet weak var RawConsole: UITextView!
  
  
  @IBAction func ClearConsole(sender: AnyObject) {
    urlLabel.text = ""
    Status.text = ""
    StatusConsole.text = ""
    RawConsole.text = ""
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
    let client:ODataClient = ODataClientFactory.getClient()
    log.logMode = Log.LogMode.DEBUG
  
    var urlString = root
    var startTime:NSDate
    var endTime:NSDate
    var duration:Double
    var consoleOutput:String = ""
    var myEdm: Edm
    guard let uriBuilder = client.newURIBuilder(root) else {
      return
    }
    ResetRawConsole("")
  
    if let entitySet = entitySetField.text{
      if entitySet.isEmpty || entitySet == "entity set" {
        // request service document
        ResetStatusConsole("No request provided")
        AppendToStatusConsole("Stub for service document request")
        ResetConsole("")
        return
      }
      if entitySet.containsString("$metadata"){
        // request metadata
        urlString += "/"+entitySet
        let uri:NSURL = NSURL(string:urlString)!
        ResetStatusConsole("Requesting the metadata for the URL:")
        AppendToStatusConsole(uri.absoluteString)
        let myRetriveRequestFactory = client.retrieveRequestFactory
        let myEdmMetaRequest = myRetriveRequestFactory.getMetadataRequest(uri)
        do {
         let myResponse = try myEdmMetaRequest.execute()
         myEdm = (myResponse.getBody() as! EdmProviderImpl)
         AppendToStatusConsole("Number of schemas returned: " + String(myEdm.getSchemas().count))
         ResetRawConsole("Raw XML:")
         AppendToRawConsole(String(data: myEdm.theRawXmlData!, encoding: NSUTF8StringEncoding)!)
         //Create summarixer for main console output
         let myEdmSummarizer = EdmSummarizer(anEdm: myEdm)
         ResetConsole(myEdmSummarizer.getSummary())
        }
        catch {
          AppendToStatusConsole("Error occurred retrieving the metadata")
        }
        return
      }
      else {
        do {
          
          // request entity set (at present) will expand as functionality increases (option picker?)
          ResetStatusConsole("Retrieve Request Factory")
          log.debug("Retrieve Request Factory")
          let retriveRequestFactory = client.retrieveRequestFactory
          
          if let entityID = entityIDField.text {
            if entityID.isEmpty || entityID == "entity ID" {
              // Request entity set
              AppendToStatusConsole("Build URI")
              log.debug("Build URI")
              uriBuilder.appendEntitySetSegment(entitySet)
              uriBuilder.count(true)
              if let topAsText = numRecsToReturnField.text{
                if !topAsText.isEmpty && topAsText != "# recs" {
                  if let top = Int(topAsText) {
                    uriBuilder.top(top)
                  }
                }
              }

              if let skipAsText = numRecsSkipField.text{
                if !skipAsText.isEmpty && skipAsText != " @ rec" {
                  if let skip = Int(skipAsText) {
                    uriBuilder.skip(skip)
                  }
                }
              }
              
              if let orderBytext = orderByField.text {
                if !orderBytext.isEmpty && orderBytext != "order by (desc)" {
                  uriBuilder.orderBy(orderBytext)
                }
              }
              
              if let properties = propertyFilterField.text {
                if !properties.isEmpty && properties != "property filter" {
                  let filterArray = properties.componentsSeparatedByString(",")
                  uriBuilder.select(filterArray)
                }
              }
              
              if let filterQuery = filterQueryField.text {
                if !filterQuery.isEmpty && filterQuery != "filter query" {
                  uriBuilder.filter(filterQuery)
                }
              }
              let uri = try uriBuilder.build()
              urlLabel.text = uri.absoluteString
              
              processEntitySet(retriveRequestFactory,uri: uri)
            }
            else {
              // request specific entity by ID
              AppendToStatusConsole("Build URI")
              log.debug("Build URI")
              uriBuilder.appendEntitySetSegment(entitySet)
              uriBuilder.appendKeySegment(entityID)
              if let properties = propertyFilterField.text {
                if !properties.isEmpty && properties != "property filter" {
                  let filterArray = properties.componentsSeparatedByString(",")
                  uriBuilder.select(filterArray)
                }
              }
              let uri = try uriBuilder.build()
              urlLabel.text = uri.absoluteString
              
              processEntity(retriveRequestFactory,uri: uri)

            }
            
          }
        }
        catch {
          AppendToStatusConsole("Invalid URL format")
        }
      }
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
    
    //let headerNames = response.headerNames
    let headers = response.headers
    AppendToConsole("Headers :")
    for (name,value) in headers {
      log.debug ("Header Name: \(name) : Value: \(value)")
      // AppendToConsole("Header Name: \(name) : Value: \(value)")
      AppendToConsole("Name: \(name) : Value: \(value)")
    }
    
    /*
    AppendToConsole("Header Names :")
    for name in headerNames {
      AppendToConsole(name)
      log.debug ("Header Name: \(name)")
    }
     */
    
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
      AppendToConsole("Number of Entiites available: \(entitySet.count)")
      AppendToStatusConsole("Number of Entiites available: \(entitySet.count)")
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
    
    /*
    AppendToConsole("Header Names :")
    for name in headerNames {
      AppendToConsole(name)
      log.debug ("Header Name: \(name)")
    }
 */
    
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
      
      AppendToConsole("")
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
    Console.scrollEnabled = false
    Console.text = Console.text + "\n" + msg
    Console.scrollRangeToVisible(NSRange(location: Console.text.characters.count,length: 1))
    Console.scrollEnabled = true
  }
  
  func AppendToRawConsole(msg: String) {
    RawConsole.scrollEnabled = false
    RawConsole.text = RawConsole.text + "\n" + msg
    RawConsole.scrollRangeToVisible(NSRange(location: StatusConsole.text.characters.count,length: 1))
    RawConsole.scrollEnabled = true
  }
  
  func AppendToStatusConsole(msg: String) {
    StatusConsole.scrollEnabled = false
    StatusConsole.text = StatusConsole.text + "\n" + msg
    StatusConsole.scrollRangeToVisible(NSRange(location: StatusConsole.text.characters.count,length: 1))
    StatusConsole.scrollEnabled = true
  }
  
  func ResetConsole(msg:String) {
    Console.scrollEnabled = false
    Console.text = msg
    Console.scrollRangeToVisible(NSRange(location: StatusConsole.text.characters.count,length: 1))
    Console.scrollEnabled = true
  }
  
  func ResetRawConsole(msg:String) {
    RawConsole.scrollEnabled = false
    RawConsole.text = msg
    RawConsole.scrollRangeToVisible(NSRange(location: StatusConsole.text.characters.count,length: 1))
    RawConsole.scrollEnabled = true
  }
  
  func ResetStatusConsole(msg:String) {
    StatusConsole.scrollEnabled = false
    StatusConsole.text = msg
    StatusConsole.scrollRangeToVisible(NSRange(location: StatusConsole.text.characters.count,length: 1))
    StatusConsole.scrollEnabled = true
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

