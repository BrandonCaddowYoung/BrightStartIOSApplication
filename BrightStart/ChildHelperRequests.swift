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
        
        
        var parameters = [String : AnyObject]()
        
        parameters["ChildId"] = "" as AnyObject?
        parameters["AccountId"] = accountId as AnyObject?
        parameters["ChildFirstName"] = childFirstName as AnyObject?
        parameters["ChildMiddleName"] = childMiddleName as AnyObject?
        parameters["ChildLastName"] = childLastName as AnyObject?
        parameters["ChildDOB"] = childsDateOfBirth as AnyObject?
        parameters["ChildFullName"] = childFirstName + " " + childMiddleName + " " + childLastName as AnyObject?
        parameters["MedicalConditions"] = medicalConditions as AnyObject?
        parameters["GPsDetails"] = gPsDetails as AnyObject?
        parameters["EmergencyName"] = emergencyName as AnyObject?
        parameters["EmergencyRelation"] = emergencyRelation as AnyObject?
        parameters["EmergencyHomeNumber"] = emergencyHomeNumber as AnyObject?
        parameters["EmergencyMobileNumber"] = emergencyMobileNumber as AnyObject?
        parameters["EmergencyWorkNumber"] = emergencyWorkNumber as AnyObject?
        parameters["KeyWorkerId"] = keyWorkerId as AnyObject?
        parameters["EverNoteAccessToken"] = everNoteAccessToken as AnyObject?
        parameters["OtherNotes"] = otherNotes as AnyObject?
    
        let route = baseURL + "api/ChildHelperLogic/CreateChildAndOtherNeccesaryObjects?nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .post, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func UpdateChild(childId: String, childFirstName: String, childMiddleName: String,childLastName : String, dob : NSDate, accountId: String,
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
        
        
        
        var parameters = [String : AnyObject]()
        
        parameters["ChildId"] = childId as AnyObject?
        parameters["AccountId"] = accountId as AnyObject?
        parameters["ChildFirstName"] = childFirstName as AnyObject?
        parameters["ChildMiddleName"] = childMiddleName as AnyObject?
        parameters["ChildLastName"] = childLastName as AnyObject?
        parameters["ChildDOB"] = childsDateOfBirth as AnyObject?
        parameters["ChildFullName"] = childFirstName + " " + childMiddleName + " " + childLastName as AnyObject?
        parameters["MedicalConditions"] = medicalConditions as AnyObject?
        parameters["GPsDetails"] = gPsDetails as AnyObject?
        parameters["EmergencyName"] = emergencyName as AnyObject?
        parameters["EmergencyRelation"] = emergencyRelation as AnyObject?
        parameters["EmergencyHomeNumber"] = emergencyHomeNumber as AnyObject?
        parameters["EmergencyMobileNumber"] = emergencyMobileNumber as AnyObject?
        parameters["EmergencyWorkNumber"] = emergencyWorkNumber as AnyObject?
        parameters["KeyWorkerId"] = keyWorkerId as AnyObject?
        parameters["EverNoteAccessToken"] = everNoteAccessToken as AnyObject?
        parameters["OtherNotes"] = otherNotes as AnyObject?

                let route = baseURL + "api/ChildLogic/UpdateChild?nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .put, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
}
