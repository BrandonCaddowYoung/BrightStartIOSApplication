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

class AccountRequests: NSObject {
    
    static let sharedInstance = AccountRequests()
    let baseURL = ApiInformation.ApiURL
    var nurserySchoolId = "";
   
    func CreateAccount(mothersEmail: String, fathersEmail: String, mothersName: String, fathersName: String,onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let parameters: Parameters = [
                "AccountId": "",
                "AccountName": mothersName + " - " + fathersName,
                "DateOpened": "",
                "AccountDetails": "",
                "HouseNumber": "",
                "Road": "",
                "County": "",
                "PostCode": "",
                "HomePhoneNumber": "",
                "MotherWorkPhoneNumber": "",
                "FatherWorkPhoneNumber": "",
                "MotherBillingEmailAddress": mothersEmail,
                "FatherBillingEmailAddress": fathersEmail,
                "PayPalEmailAddress": "",
                "MotherMobile": "",
                "FatherMobile": "",
                "FatherPayPercentage": "50",
                "MotherPayPercentage": "50",
                "MotherOccupation": "",
                "FatherOccupation": "",
                "MotherName": mothersName,
                "FatherName": fathersName,
                "ExistingAccountBalance": ""
        ]
        
        let route = baseURL + "api/AccountLogic/CreateAccount?nurserySchoolId=" + nurserySchoolId
        makeHTTPPost(encode: false, path: route, params: parameters, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
}
