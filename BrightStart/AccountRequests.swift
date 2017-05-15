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
   
    func CreateAccount(mothersEmail: String, fathersEmail: String, mothersName: String, fathersName: String,
                       houseNumber: String? = "",
                       road: String? = "",
                       town: String? = "",
                       county: String? = "",
                       postCode: String? = "",
                       homePhoneNumber: String? = "",
                       motherWorkPhoneNumber: String? = "",
                       fatherWorkPhoneNumber: String? = "",
                       payPalEmailAddress: String? = "",
                       motherMobile: String? = "",
                       fatherMobile: String? = "",
                       motherOccupation: String? = "",
                       fatherOccupation: String? = "",
                       existingAccountBalance: String? = "",
                       accountDetails: String? = "",
                       dateOpened: String? = "",
                    onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let parameters: Parameters = [
                "AccountId": "",
                "AccountName": mothersName + " - " + fathersName,
                "DateOpened": dateOpened ?? "",
                "AccountDetails": accountDetails ?? "",
                "HouseNumber": houseNumber ?? "",
                "Road": road ?? "",
                "Town": road ?? "",
                "County": county ?? "",
                "PostCode": postCode ?? "",
                "HomePhoneNumber": homePhoneNumber ?? "",
                "MotherWorkPhoneNumber": motherWorkPhoneNumber ?? "",
                "FatherWorkPhoneNumber": fatherWorkPhoneNumber ?? "",
                "MotherBillingEmailAddress": mothersEmail,
                "FatherBillingEmailAddress": fathersEmail,
                "PayPalEmailAddress": payPalEmailAddress ?? "",
                "MotherMobile": motherMobile ?? "",
                "FatherMobile": fatherMobile ?? "",
                "FatherPayPercentage": "50",
                "MotherPayPercentage": "50",
                "MotherOccupation": motherOccupation ?? "",
                "FatherOccupation": fatherOccupation ?? "",
                "MotherName": mothersName,
                "FatherName": fathersName,
                "ExistingAccountBalance": existingAccountBalance ?? "",
        ]
        
        let route = baseURL + "api/AccountLogic/CreateAccount?nurserySchoolId=" + nurserySchoolId
        makeHTTPPost(encode: false, path: route, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
}
