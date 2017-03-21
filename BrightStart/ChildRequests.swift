//
//  ChildRequests.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation

//typealias ServiceResponse = (JSON, NSError?) -> Void

class ChildRequests: NSObject {
    
    static let sharedInstance = ChildRequests()
    let baseURL = "https://brightstartwebapi126.azurewebsites.net/"
    var nurserySchoolId = "";
    
    /*!
     @brief Retrieves a list of logins.
     */
    func GetAllEnrolledChilren(onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/ChildLogic/GetAllEnrolledChilren?nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    /*!
     @brief Retrieves a list of logins.
     */
    func GetAllChildrenWhoHaveExtraMinutesForGivenDay(targetDate: NSDate, onCompletion: @escaping (JSON) -> Void) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let dateString = dateFormatter.string(from: targetDate as Date)

        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/BillingLogic/GetAllChildrenWhoHaveExtraMinutesForGivenDay?targetDate=" + dateString + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
}
