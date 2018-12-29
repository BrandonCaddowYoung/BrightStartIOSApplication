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
   
    func GetAccount(accountId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/AccountLogic/GetAccountById?accountId=" + accountId + "&nurserySchoolId=" + nurserySchoolId
        
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
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
        
        var parameters = [String : AnyObject]()
        
        parameters["AccountId"] = "" as AnyObject?
        parameters["AccountName"] = mothersName + " - " + fathersName as AnyObject?
        parameters["DateOpened"] = dateOpened as AnyObject?
        parameters["AccountDetails"] = accountDetails as AnyObject?
        parameters["HouseNumber"] = houseNumber as AnyObject?
        parameters["Road"] = road as AnyObject?
        parameters["Town"] = town as AnyObject?
        parameters["County"] = county as AnyObject?
        parameters["PostCode"] = postCode as AnyObject?
        parameters["HomePhoneNumber"] = homePhoneNumber as AnyObject?
        parameters["MotherWorkPhoneNumber"] = motherWorkPhoneNumber as AnyObject?
        parameters["FatherWorkPhoneNumber"] = fatherWorkPhoneNumber as AnyObject?
        parameters["MotherBillingEmailAddress"] = mothersEmail as AnyObject?
        parameters["FatherBillingEmailAddress"] = fathersEmail as AnyObject?
        parameters["PayPalEmailAddress"] = payPalEmailAddress as AnyObject?
        parameters["MotherMobile"] = motherMobile as AnyObject?
        parameters["FatherMobile"] = fatherMobile as AnyObject?
        parameters["FatherPayPercentage"] = "50" as AnyObject?
        parameters["MotherPayPercentage"] = "50" as AnyObject?
        parameters["MotherOccupation"] = motherOccupation as AnyObject?
        parameters["FatherOccupation"] = fatherOccupation as AnyObject?
        parameters["MotherName"] = mothersName as AnyObject?
        parameters["FatherName"] = fathersName as AnyObject?
        parameters["ExistingAccountBalance"] = existingAccountBalance as AnyObject?
 
        let route = baseURL + "api/AccountLogic/CreateAccount?nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .post, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    
    
    func UpdateAccount(accountId: String, mothersEmail: String, fathersEmail: String, mothersName: String, fathersName: String,
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
        
        var parameters = [String : AnyObject]()
        
        parameters["AccountId"] = accountId as AnyObject?
        parameters["AccountName"] = mothersName + " - " + fathersName as AnyObject?
        parameters["DateOpened"] = dateOpened as AnyObject?
        parameters["AccountDetails"] = accountDetails as AnyObject?
        parameters["HouseNumber"] = houseNumber as AnyObject?
        parameters["Road"] = road as AnyObject?
        parameters["Town"] = town as AnyObject?
        parameters["County"] = county as AnyObject?
        parameters["PostCode"] = postCode as AnyObject?
        parameters["HomePhoneNumber"] = homePhoneNumber as AnyObject?
        parameters["MotherWorkPhoneNumber"] = motherWorkPhoneNumber as AnyObject?
        parameters["FatherWorkPhoneNumber"] = fatherWorkPhoneNumber as AnyObject?
        parameters["MotherBillingEmailAddress"] = mothersEmail as AnyObject?
        parameters["FatherBillingEmailAddress"] = fathersEmail as AnyObject?
        parameters["PayPalEmailAddress"] = payPalEmailAddress as AnyObject?
        parameters["MotherMobile"] = motherMobile as AnyObject?
        parameters["FatherMobile"] = fatherMobile as AnyObject?
        parameters["FatherPayPercentage"] = "50" as AnyObject?
        parameters["MotherPayPercentage"] = "50" as AnyObject?
        parameters["MotherOccupation"] = motherOccupation as AnyObject?
        parameters["FatherOccupation"] = fatherOccupation as AnyObject?
        parameters["MotherName"] = mothersName as AnyObject?
        parameters["FatherName"] = fathersName as AnyObject?
        parameters["ExistingAccountBalance"] = existingAccountBalance as AnyObject?

        let route = baseURL + "api/AccountLogic/UpdateAccount?nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .put, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    
    
    
    
}
