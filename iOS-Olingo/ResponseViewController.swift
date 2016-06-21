//
//  ResponseViewController.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 21/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import UIKit

class ResponseViewController: UIViewController {

  @IBOutlet weak var URILabel: UILabel!
  
  @IBOutlet weak var responseStatusLabel: UILabel!
  
  @IBOutlet weak var tableView: UITableView!
  
  
  let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
  //let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
  
  
  var dataTask: NSURLSessionDataTask?
  
  var searchResults = [Customer]()
  
  
  var URIData: String?
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      URILabel.text = URIData
      tableView.tableFooterView = UIView()
      
      
      let expectedCharSet = NSCharacterSet.URLQueryAllowedCharacterSet()
      let urlTerm = URIData!.stringByAddingPercentEncodingWithAllowedCharacters(expectedCharSet)!
//      // 4
//      // let url = NSURL(string: "https://itunes.apple.com/search?media=music&entity=song&term=\(searchTerm)")
//      let url = NSURL(string: "http://services.odata.org/V4/Northwind/Northwind.svc/\(searchTerm)")
//      
      let url = NSURL(string:urlTerm)
      NSLog("URLString: %@",url!)
      
      // 5
      dataTask = defaultSession.dataTaskWithURL(url!)
      {
        data, response, error in
        // 6
        dispatch_async(dispatch_get_main_queue())
        {
          UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        // 7
        if let error = error
        {
          print(error.localizedDescription)
          NSLog("Error: %@",error.localizedDescription)
          self.responseStatusLabel.text = error.localizedDescription
          
        }
        else if let httpResponse = response as? NSHTTPURLResponse
        {
          if httpResponse.statusCode == 200
          {
            self.updateSearchResults(data)
          }
          else
          {
            self.responseStatusLabel.text = "Error : /(httpResponse.statusCode)"
          }
        }
      }
      // 8
      dataTask?.resume()
      
      
    }
  
  // MARK: Handling HTTP Response
  
  // This helper method helps parse response JSON NSData into an array of customer objects.
  func updateSearchResults(data: NSData?) {
    searchResults.removeAll()
    do {
      if let data = data, response = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(rawValue:0)) as? [String: AnyObject] {
        
        // Get the results array
        if let array: AnyObject = response["value"]
        {
          for entitySetDictonary in array as! [AnyObject]
          {
            if let entitySetDictonary = entitySetDictonary as? [String: AnyObject], customerID = entitySetDictonary["CustomerID"] as? String
            {
              // Parse the search result
              let companyName = entitySetDictonary["CompanyName"] as? String
              let contactName = entitySetDictonary["ContactName"] as? String
              searchResults.append(Customer(companyName: companyName, contactName: contactName, customerID: customerID))
            }
            else
            {
//              print("Not a dictionary")
              self.responseStatusLabel.text = "Not a dictionary"
            }
          }
        } else {
          print("Value key not found in dictionary")
          self.responseStatusLabel.text = "Value key not found in dictionary"
        }
      } else {
        print("JSON Error")
        self.responseStatusLabel.text = "JSON Error"
      }
    } catch let error as NSError {
      print("Error parsing results: \(error.localizedDescription)")
      self.responseStatusLabel.text = "Error parsing results: \(error.localizedDescription)"
    }
    
    dispatch_async(dispatch_get_main_queue()) {
      self.responseStatusLabel.text = "Success"
//      self.tableView.reloadData()
//      self.tableView.setContentOffset(CGPointZero, animated: false)
    }
  }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
