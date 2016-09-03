//
//  RestApiManager.swift
//  BrightStart
//
//  Created by dev on 05/04/2016.
//  Copyright © 2016 dev. All rights reserved.
//

//TBD: Need to add arguments to each method here.

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    
    static let sharedInstance = RestApiManager()
    
    let baseURL = "https://microsoft-apiappce8388460f4f40a6bdcea26f938e44fb.azurewebsites.net/"
    
    var nurserySchoolId = "";
    
    func getPeople(onCompletion: (JSON) -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let id = defaults.stringForKey("NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        
        //Change the following stored procedure to return the last login and logout.
        
        let route = baseURL + "api/FilteredChildLogic/SelectAllChildrenForFrontPage?targetDate="+DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(false, path: route, onCompletion:
            {
                json, err in
            onCompletion(json as JSON)
        })
    }
    
    func signIn(personId: String, timeOfSignIn: NSDate, onCompletion: () -> Void) {
       
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let id = defaults.stringForKey("NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let dateString = dateFormatter.stringFromDate(timeOfSignIn)
        
        let route = baseURL + "api/GeneralHelper/SignPersonIn?personId="+personId+"&targetStamp="+dateString+"&nurserySchoolId=" + nurserySchoolId
       
        makeHTTPGetRequest(false, path: route, onCompletion: { json, err in
            onCompletion()
        })
        
    }
    
    func signOut(personId: String, timeOfSignOut: NSDate, onCompletion: () -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let id = defaults.stringForKey("NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let dateString = dateFormatter.stringFromDate(timeOfSignOut)
        
        let route = baseURL + "api/GeneralHelper/SignPersonOut?personId="+personId+"&targetStamp="+dateString+"&nurserySchoolId=" + nurserySchoolId
        
        makeHTTPGetRequest(false, path: route, onCompletion: { json, err in
            onCompletion()
        })
    }
   
    func SelectChildrenCountsForTargetDate(targetDate: NSDate, onCompletion: (JSON) -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let id = defaults.stringForKey("NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let DateInFormat:String = dateFormatter.stringFromDate(targetDate)
        
        let route = baseURL + "api/DayCountLogic/SelectChildrenCountsForTargetDate?targetDate="+DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        
         print("Id is: " + nurserySchoolId)
        
        makeHTTPGetRequest(true, path: route, onCompletion: { json, err in
            
            onCompletion(json as JSON)
            
        })
        
    }
    
    func SelectStaffCountsForTargetDate(targetDate: NSDate, onCompletion: (JSON) -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let id = defaults.stringForKey("NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let DateInFormat:String = dateFormatter.stringFromDate(targetDate)
        
        let route = baseURL + "api/DayCountLogic/SelectStaffCountsForTargetDate?targetDate="+DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        
        makeHTTPGetRequest(true, path: route, onCompletion: { json, err in
            
            print(err!.code)
            
            onCompletion(json as JSON)
            
        })
        
    }
    
    func GetNumberOfChildrenWithRegisteredHoursAtSpecificTime(targetDate: NSDate, onCompletion: (JSON) -> Void) {
       
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let id = defaults.stringForKey("NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let DateInFormat:String = dateFormatter.stringFromDate(targetDate)
        
        let route = baseURL + "api/RegisteredCountLogic/GetNumberOfChildrenWithRegisteredHoursAtSpecificTime?targetDate="+DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(true, path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func GetNumberOfStaffWithRegisteredHoursAtSpecificTime(targetDate: NSDate, onCompletion: (JSON) -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let id = defaults.stringForKey("NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let DateInFormat:String = dateFormatter.stringFromDate(targetDate)
        
        let route = baseURL + "api/RegisteredCountLogic/GetNumberOfStaffWithRegisteredHoursAtSpecificTime?targetDate="+DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(true, path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func GetNumberOfChildrenWithRegisteredHoursForEntireDay(year: String, month: String, day:String, onCompletion: (JSON) -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let id = defaults.stringForKey("NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let route = baseURL + "api/RegisteredCountLogic/GetNumberOfChildrenWithRegisteredHoursForEntireDay?year="+year+"&month="+month+"&day=" + day + "&nurserySchoolId=" + nurserySchoolId
        
        makeHTTPGetRequest(true, path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
        
    }
    
    
    func GetNumberOfStaffWithRegisteredHoursForEntireDay(year: String, month: String, day:String, onCompletion: (JSON) -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let id = defaults.stringForKey("NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let route = baseURL + "api/RegisteredCountLogic/GetNumberOfStaffWithRegisteredHoursForEntireDay?year="+year+"&month="+month+"&day=" + day + "&nurserySchoolId=" + nurserySchoolId
        
        
        makeHTTPGetRequest(true, path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
        
    }
    
    func makeHTTPGetRequest(encode: Bool, path: String, onCompletion: ServiceResponse) {
        
        //print("Making a call to: " + path)
        
        // set up the base64-encoded credentials
        let username = "byoung"
        let password = "P@ssw0rd.1"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        var URL = NSURL()
        
        if(encode==true){
            URL = NSURL(string: path.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        }
        else
        {
            URL = NSURL(string: path)!
        }
        
        let request = NSMutableURLRequest(URL:URL)
        
        //Setting the basic auth credentials
       request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let json:JSON = JSON(data: data!)
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                //Here we are checking the response code, its its not a code starting with 2 then something has gone wrong.
                let remaining = httpResponse.statusCode % 200
                let hundredStatusCode = httpResponse.statusCode - remaining
                
                if(hundredStatusCode != 200)
                {
                    //If the status code is something other than 2xx then we should recall.
                    
                    //This happens as azure goes to sleep and needs waking up sometimes.
                    
                    let task2 = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                        
                        let json:JSON = JSON(data: data!)
                        
                        onCompletion(json, error)
                        
                    })
                    
                     task2.resume()
                }
                else
                {
                    onCompletion(json, error)
                }
                
            }
        })
        
        task.resume()
        
    }
    
    
    //This is not being used!
    func makeHTTPPostRequest(path: String, body: [String: AnyObject], onCompletion: ServiceResponse) {
        var err: NSError?
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to POST
        request.HTTPMethod = "POST"
        
        do {
        // Set the POST body for the request
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(body, options: [])
    }
        catch
    {
    
    request.HTTPBody = nil
    }
    
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            onCompletion(json, err)
        })
        task.resume()
    }
}
