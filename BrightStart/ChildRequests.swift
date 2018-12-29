//
//  ChildRequests.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Alamofire

//typealias ServiceResponse = (JSON, NSError?) -> Void

class ChildRequests: NSObject {
    
    static let sharedInstance = ChildRequests()
    let baseURL = ApiInformation.ApiURL
    var nurserySchoolId = "";
    
    /*!
     @brief Retrieves a list of logins.
     */
    func GetAllEnrolledChilren(onCompletion: @escaping (JSON) -> Void) {
        
        //UserDefaults.standard.synchronize()
        
        let defaults = UserDefaults.standard
        
        print(defaults)
        
        let test = UserDefaults.standard.string(forKey: "NurserySchoolId") ?? ""
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/ChildLogic/SelectAllCurrentlyEnrolledChildren?nurserySchoolId=" + test
        
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
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
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: targetDate as Date)

        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/BillingLogic/GetAllChildrenWhoHaveExtraMinutesForGivenDay?targetDate=" + dateString + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func GetChild(childId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/ChildLogic/GetChildObjectByChildId?ChildId=" + childId + "&nurserySchoolId=" + nurserySchoolId
        
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
}
