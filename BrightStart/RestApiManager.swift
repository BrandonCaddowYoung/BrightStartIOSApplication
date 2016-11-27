//
//  RestApiManager.swift
//  BrightStart
//
//  Created by dev on 05/04/2016.
//  Copyright © 2016 dev. All rights reserved.
//

//TBD: Need to add arguments to each method here.

import Foundation

import Alamofire

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    
    static let sharedInstance = RestApiManager()
    
    let baseURL = "https://microsoft-apiappce8388460f4f40a6bdcea26f938e44fb.azurewebsites.net/"
    
    var nurserySchoolId = "";
    
    func getPeople(onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let todaysDate:NSDate = NSDate()
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let DateInFormat:String = dateFormatter.string(from: todaysDate as Date)
        
        //Change the following stored procedure to return the last login and logout.
        
        let route = baseURL + "api/FilteredChildLogic/SelectAllChildrenForFrontPage?targetDate="+DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
            onCompletion(json as JSON)
        })
    }
    
    func signIn(personId: String, timeOfSignIn: NSDate, onCompletion: @escaping () -> Void) {
       
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let dateString = dateFormatter.string(from: timeOfSignIn as Date)
        
        let route = baseURL + "api/GeneralHelper/SignPersonIn?personId="+personId+"&targetStamp="+dateString+"&nurserySchoolId=" + nurserySchoolId
       
        makeHTTPGetRequest(encode: false, path: route, onCompletion: { json, err in
            onCompletion()
        })
        
    }
    
    func signOut(personId: String, timeOfSignOut: NSDate, onCompletion: @escaping () -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let dateString = dateFormatter.string(from: timeOfSignOut as Date)
        
        let route = baseURL + "api/GeneralHelper/SignPersonOut?personId="+personId+"&targetStamp="+dateString+"&nurserySchoolId=" + nurserySchoolId
        
        makeHTTPGetRequest(encode: false, path: route, onCompletion: { json, err in
            onCompletion()
        })
    }
   
    func SelectChildrenCountsForTargetDate(targetDate: NSDate, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let DateInFormat:String = dateFormatter.string(from: targetDate as Date)
        
        let route = baseURL + "api/DayCountLogic/SelectChildrenCountsForTargetDate?targetDate="+DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        
         print("Id is: " + nurserySchoolId)
        
        makeHTTPGetRequest(encode: true, path: route, onCompletion: { json, err in
            
            onCompletion(json as JSON)
            
        })
        
    }
    
    func SelectStaffCountsForTargetDate(targetDate: NSDate, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let DateInFormat:String = dateFormatter.string(from: targetDate as Date)
        
        let route = baseURL + "api/DayCountLogic/SelectStaffCountsForTargetDate?targetDate="+DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        
        makeHTTPGetRequest(encode: true, path: route, onCompletion: { json, err in
            
            print(err!.code)
            
            onCompletion(json as JSON)
            
        })
        
    }
    
    func GetNumberOfChildrenWithRegisteredHoursAtSpecificTime(targetDate: NSDate, onCompletion: @escaping (JSON) -> Void) {
       
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let DateInFormat:String = dateFormatter.string(from: targetDate as Date)
        
        let route = baseURL + "api/RegisteredCountLogic/GetNumberOfChildrenWithRegisteredHoursAtSpecificTime?targetDate="+DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: true, path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func GetNumberOfStaffWithRegisteredHoursAtSpecificTime(targetDate: NSDate, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let DateInFormat:String = dateFormatter.string(from: targetDate as Date)
        
        let route = baseURL + "api/RegisteredCountLogic/GetNumberOfStaffWithRegisteredHoursAtSpecificTime?targetDate="+DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: true, path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func GetNumberOfChildrenWithRegisteredHoursForEntireDay(year: String, month: String, day:String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let route = baseURL + "api/RegisteredCountLogic/GetNumberOfChildrenWithRegisteredHoursForEntireDay?year="+year+"&month="+month+"&day=" + day + "&nurserySchoolId=" + nurserySchoolId
        
        makeHTTPGetRequest(encode: true, path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
        
    }
    
    
    func GetNumberOfStaffWithRegisteredHoursForEntireDay(year: String, month: String, day:String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let route = baseURL + "api/RegisteredCountLogic/GetNumberOfStaffWithRegisteredHoursForEntireDay?year="+year+"&month="+month+"&day=" + day + "&nurserySchoolId=" + nurserySchoolId
        
        
        makeHTTPGetRequest(encode: true, path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
        
    }
 
    func getMyIP()
    {
        let username = "byoung"
        let password = "P@ssw0rd.1"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8.rawValue)!
        let base64LoginString = loginData.base64EncodedData()
        
        let url:URL = URL(string: "https://microsoft-apiappce8388460f4f40a6bdcea26f938e44fb.azurewebsites.net/api/FilteredChildLogic/SelectAllChildrenForFrontPage?targetDate=2016-11-27%2018:40:10&nurserySchoolId=5BFFDA7E-05A8-43C2-BD98-BAC4652419A1")!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        
       // let paramString = "data=Hello"
        // request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let data = data, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            
            let dataString =  String(data: data, encoding: String.Encoding.utf8)
            print(dataString)
            
        }
        
        task.resume()
    
    }
    
    
    func makeHTTPGetRequest(encode: Bool, path: String, onCompletion: @escaping ServiceResponse) {
        
        let user = "byoung"
        let password = "P@ssw0rd.1"
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        var error: NSError?
        
        Alamofire.request(path, headers: headers)
            .responseJSON { response in
                
                let json = JSON(response)
                
               //onCompletion(json, error)
        }
        
        Alamofire.request(path, headers: headers)
            .responseJSON { response in
           
                switch response.result {
            
                case .success(let data):
                
                    let json = JSON(data)
                onCompletion(json, error)
           
                case .failure(let error):
                print("Request failed with error: \(error)")
                    
            }
        }
        
        return;
        
        // getMyIP()
        
        // set up the base64-encoded credentials
        let username1 = "byoung"
        let password1 = "P@ssw0rd.1"
        let loginString = NSString(format: "%@:%@", username1, password1)
        let loginData = loginString.data(using: String.Encoding.utf8.rawValue)!
        let base64LoginString = loginData.base64EncodedData()
        
        let URL = NSURL(string: path)!
        
        var request = URLRequest(url:URL as URL)
        
        //Setting the basic auth credentials
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        
        
        
        
        
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        
        
        
        
        
        
        
        
        
        
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            let json:JSON = JSON(data: data!)
            
            print(data)
            print(response)
            print(error)
            print(json)

            
                if let httpResponse = response as? HTTPURLResponse {
                    
                    //Here we are checking the response code, its its not a code starting with 2 then something has gone wrong.
                    let remaining = httpResponse.statusCode % 200
                    let hundredStatusCode = httpResponse.statusCode - remaining
                    
                    if(hundredStatusCode != 200)
                    {
                        //If the status code is something other than 2xx then we should recall.
                        
                        //This happens as azure goes to sleep and needs waking up sometimes.
                        
                        let task2 = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                            
                            let json:JSON = JSON(data: data!)
                            
                            onCompletion(json, error as NSError?)
                            
                        })
                        
                        task2.resume()
                    }
                    else
                    {
                        onCompletion(json , error as NSError?)
                    }
                    
                }
                
            
            
            
            
           
        })
        
        task.resume()
        
    }
    
    
   }
