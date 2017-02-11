//
//  AuthyRequests.swift
//  BrightStart
//
//  Created by Colleen Caddow on 30/01/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Foundation


class RegistrationRequests: NSObject {
    
    static let sharedInstance = RegistrationRequests()
    let baseURL = "https://microsoft-apiappce8388460f4f40a6bdcea26f938e44fb.azurewebsites.net/"
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
