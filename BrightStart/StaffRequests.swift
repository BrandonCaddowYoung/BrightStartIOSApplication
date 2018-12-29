//
//  StaffRequests.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Alamofire

//typealias ServiceResponse = (JSON, NSError?) -> Void

class StaffRequests: NSObject {
    
    static let sharedInstance = StaffRequests()
    let baseURL = ApiInformation.ApiURL
    var nurserySchoolId = "";
    
    
    func GetAllStaff(onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/StaffMemberLogic/GetAllStaffMembers?nurserySchoolId=" + nurserySchoolId
        
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    /*!
     @brief Retrieves a list of logins.
     */
    func GetAllStaffrenWhoHaveExtraMinutesForGivenDay(targetDate: NSDate, onCompletion: @escaping (JSON) -> Void) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: targetDate as Date)
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/BillingLogic/GetAllStaffrenWhoHaveExtraMinutesForGivenDay?targetDate=" + dateString + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func GetStaff(StaffId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
     
        let route = baseURL + "api/StaffMemberLogic/GetStaffMemerObjectByStaffMemberId?StaffMemberId=" + StaffId + "&nurserySchoolId=" + nurserySchoolId
        
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
}
