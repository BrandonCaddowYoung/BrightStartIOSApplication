//
//  RestApiManager.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class CommonRequests: NSObject {
    
    static let sharedInstance = CommonRequests()
    let baseURL = "https://microsoft-apiappce8388460f4f40a6bdcea26f938e44fb.azurewebsites.net/"
    var nurserySchoolId = "";
    
    /*!
     @brief Retrieves a list of children that will be displayed to the user for signing in and out.
    */
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
    
    /*!
     @brief Signs in the selected person.
     */
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
    
    /*!
     @brief Signs out the selected person.
     */
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
    
    /*!
     @brief Updates a time stamp.
     */
    func updateTimeStamp(personId: String, action: String, stamp: NSDate, originalAction: String, originalTimeStamp: NSDate, onCompletion: @escaping () -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let stampAsString = dateFormatter.string(from: stamp as Date)
        let originalTimeStampAsString = dateFormatter.string(from: originalTimeStamp as Date)
        
        let route = baseURL + "api/PersonLogLogic/UpdatePersonLog?personId="+personId+"&action="+action+"&stamp=" + stampAsString + "&Original_Action="+originalAction+"&Original_Timestamp="+originalTimeStampAsString+"&nurserySchoolId=" + nurserySchoolId
        
        makeHTTPPutRequest(encode: false, path: route, onCompletion: { json, err in
            onCompletion()
        })
    }
    
    /*!
     @brief Delete a time stamp.
     */
    func deleteTimeStamp(personId: String, action: String, stamp: NSDate, onCompletion: @escaping () -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let stampAsString = dateFormatter.string(from: stamp as Date)
        
        let route = baseURL + "api/PersonLogLogic/DeletePersonLog?personId=" + personId + "&action=" + action + "&stamp=" + stampAsString + "&Original_Action=" + action + "&Original_Timestamp=" + stampAsString + "&nurserySchoolId=" + nurserySchoolId
        
        makeHTTPDeleteRequest(encode: false, path: route, onCompletion: { json, err in
            onCompletion()
        })
    }
    
    
    /*!
     @brief Returns various information relating to how many children are present for any given day.
     */
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
        
        makeHTTPGetRequest(encode: true, path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
        
    }
    
    /*!
     @brief Returns various information relating to how many staff members are present for any given day.
     */
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
            
            onCompletion(json as JSON)
            
        })
        
    }
    
    /*!
     @brief Returns the number of children whom have registered hours for any given specific time of any given day.
     */
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
    
    /*!
     @brief Returns the number of staff members whom have registered hours for any given specific time of any given day.

     */
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
    
    /*!
     @brief Returns the number of children whom have registered hours for any given day.
     */
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
    
    /*!
     @brief Returns the number of staff members whom have registered hours for any given day.
     */
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
    
    /*!
     @brief Given a username and password, retrieves a NurserySchoolId(if it exists).
     */
    func RetrieveNurserySchoolId(userName: String, passWord: String, onCompletion: @escaping (JSON) -> Void) {
        
        let route = baseURL + "api/OnlineLoginDetailsLogic/ValidateCreds?userName="+userName+"&password="+passWord
        
        makeHTTPGetRequest(encode: true, path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
        
    }
    
    
        
    
    
}
