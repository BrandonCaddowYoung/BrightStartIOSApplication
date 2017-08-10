//
//  AuthyRequests.swift
//  BrightStart
//
//  Created by Brandon Young on 30/01/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Foundation


class RegistrationRequests: NSObject {
    
    static let sharedInstance = RegistrationRequests()
    let baseURL = ApiInformation.ApiURL
    var nurserySchoolId = "";
    
    /*!
     @brief Registers a new nursery school.
     */
    func CreateNewNurserySchoolFromScratch(nurserySchoolName: String, managerName: String, nurserySchoolPhoneNumber: String, username: String, password: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/NewNurserySchool/CreateNewNurserySchoolFromScratch?nurserySchoolName=" + nurserySchoolName + "&managerName=" + managerName + "&nurserySchoolPhoneNumber=" + nurserySchoolPhoneNumber + "&username=" + username + "&password=" + password
        makeHTTPGetRequest(encode: true, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
}
