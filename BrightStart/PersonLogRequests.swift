//
//  PersonLogRequests.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation


//typealias ServiceResponse = (JSON, NSError?) -> Void

class PersonLogRequests: NSObject {
    
    static let sharedInstance = PersonLogRequests()
    let baseURL = "https://microsoft-apiappce8388460f4f40a6bdcea26f938e44fb.azurewebsites.net/"
    var nurserySchoolId = "";
    
    /*!
     @brief Retrieves a list of logins.
     */
    func GetLogByDateAndId(personId: String, targetDate: NSDate, onCompletion: @escaping (JSON) -> Void) {
        
        var id = personId
        id = id.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
       
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let DateInFormat:String = dateFormatter.string(from: targetDate as Date)
       
        let route = baseURL + "api/PersonLogLogic/GetLogByDateAndId?personId="+id + "&stamp=" + DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    
    func GetLogins(personId: String,targetDate: NSDate, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
       
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let DateInFormat:String = dateFormatter.string(from: targetDate as Date)
        
        let route = baseURL + "api/PersonLogLogic/GetLoginLogsByDateAndId?personId="+personId + "&stamp=" + DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func GetLogouts(personId: String,targetDate: NSDate, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let DateInFormat:String = dateFormatter.string(from: targetDate as Date)
        
        let route = baseURL + "api/PersonLogLogic/GetLogoutLogsByDateAnId?personId="+personId + "&stamp=" + DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func DeletePersonLog(logId: String, onCompletion: @escaping (JSON) -> Void) {
    
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
       
        let route = baseURL + "api/PersonLogLogic/DeleteLogsById?Id=" + logId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
        
    }
    
}
