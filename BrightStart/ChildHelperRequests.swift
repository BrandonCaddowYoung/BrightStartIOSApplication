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

class ChildHelperRequests: NSObject {
    
    static let sharedInstance = ChildHelperRequests()
    let baseURL = ApiInformation.ApiURL
    var nurserySchoolId = "";
   
    func CreateChild(childFirstName: String, childMiddleName: String,childLastName : String, dob : NSDate, accountId: String,
                      medicalConditions: String? = "",
                       gPsDetails: String? = "",
                        emergencyName: String? = "",
                          emergencyRelation: String? = "",
                           emergencyHomeNumber: String? = "",
                            emergencyMobileNumber: String? = "",
                             emergencyWorkNumber: String? = "",
                             keyWorkerId: String? = "",
                             everNoteAccessToken: String? = "",
                             otherNotes: String? = "",
                     onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        let childsDateOfBirth = dateFormatter.string(from: dob as Date)
        
        let parameters: Parameters = [
                    "ChildId": "",
                    "AccountId": accountId,
                    "ChildFirstName": childFirstName,
                    "ChildMiddleName": childMiddleName,
                    "ChildLastName": childLastName,
                    "ChildDOB": childsDateOfBirth,
                    "ChildFullName": childFirstName + " " + childMiddleName + " " + childLastName,
                    "MedicalConditions": medicalConditions ?? "",
                    "GPsDetails": gPsDetails ?? "",
                    "EmergencyName": emergencyName ?? "",
                    "EmergencyRelation": emergencyRelation ?? "",
                    "EmergencyHomeNumber": emergencyHomeNumber ?? "",
                    "EmergencyMobileNumber": emergencyMobileNumber ?? "",
                    "EmergencyWorkNumber": emergencyWorkNumber ?? "",
                    "KeyWorkerId": keyWorkerId ?? "",
                    "EverNoteAccessToken": everNoteAccessToken ?? "",
                    "OtherNotes": otherNotes ?? ""
        ]
        
        let route = baseURL + "api/ChildHelperLogic/CreateChildAndOtherNeccesaryObjects?nurserySchoolId=" + nurserySchoolId
        makeHTTPPost(encode: false, path: route, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func UpdateChild(childFirstName: String, childMiddleName: String,childLastName : String, dob : NSDate, accountId: String,
                     medicalConditions: String? = "",
                     gPsDetails: String? = "",
                     emergencyName: String? = "",
                     emergencyRelation: String? = "",
                     emergencyHomeNumber: String? = "",
                     emergencyMobileNumber: String? = "",
                     emergencyWorkNumber: String? = "",
                     keyWorkerId: String? = "",
                     everNoteAccessToken: String? = "",
                     otherNotes: String? = "",
                     onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        let childsDateOfBirth = dateFormatter.string(from: dob as Date)
        
        let parameters: Parameters = [
            "ChildId": "",
            "AccountId": accountId,
            "ChildFirstName": childFirstName,
            "ChildMiddleName": childMiddleName,
            "ChildLastName": childLastName,
            "ChildDOB": childsDateOfBirth,
            "ChildFullName": childFirstName + " " + childMiddleName + " " + childLastName,
            "MedicalConditions": medicalConditions ?? "",
            "GPsDetails": gPsDetails ?? "",
            "EmergencyName": emergencyName ?? "",
            "EmergencyRelation": emergencyRelation ?? "",
            "EmergencyHomeNumber": emergencyHomeNumber ?? "",
            "EmergencyMobileNumber": emergencyMobileNumber ?? "",
            "EmergencyWorkNumber": emergencyWorkNumber ?? "",
            "KeyWorkerId": keyWorkerId ?? "",
            "EverNoteAccessToken": everNoteAccessToken ?? "",
            "OtherNotes": otherNotes ?? ""
        ]
        
        let route = baseURL + "api/ChildLogic/UpdateChild?nurserySchoolId=" + nurserySchoolId
        makeHTTPPut(encode: false, path: route, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
}
