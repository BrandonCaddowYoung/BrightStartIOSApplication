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

class StaffHelperRequests: NSObject {
    
    static let sharedInstance = StaffHelperRequests()
    let baseURL = ApiInformation.ApiURL
    var nurserySchoolId = "";
    
    func CreateStaff(staffMemberId: String,
                     firstName: String,
                     middleName : String,
                     lastName : String,
                     dOB : Date,
                     road: String,
                     county: String? = "",
                     homePhoneNumber: String? = "",
                     postcode: String? = "",
                     mobileNumber: String? = "",
                     emailAddress: String? = "",
                     houseNumber: String? = "",
                     town: String? = "",
                     medicalConditions: String? = "",
                     gPsDetails: String? = "",
                     otherNotes: String? = "",
                     emergencyName: String? = "",
                     emergencyRelation: String? = "",
                     emergencyHomeNumber: String? = "",
                     emergencyMobileNumber: String? = "",
                     emergencyWorkNumber: String? = "",
                     password: String? = "",
                     keyWorkerGroupId: String? = "",
                    
                     onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        let StaffsDateOfBirth = dateFormatter.string(from: dOB as Date)
        
        var parameters = [String : AnyObject]()
        
        parameters["StaffMemberId"] = staffMemberId as AnyObject?
        parameters["FirstName"] = firstName as AnyObject?
        parameters["MiddleName"] = middleName as AnyObject?
        parameters["LastName"] = lastName as AnyObject?
        parameters["FullName"] = firstName + " " + middleName + " " + lastName as AnyObject? as AnyObject?
        parameters["DOB"] = StaffsDateOfBirth as AnyObject?
        parameters["Road"] = road as AnyObject?
        parameters["County"] = county as AnyObject?
        parameters["HomePhoneNumber"] = homePhoneNumber as AnyObject?
        parameters["Postcode"] = postcode as AnyObject?
        parameters["MobileNumber"] = mobileNumber as AnyObject?
        parameters["EmailAddress"] = emailAddress as AnyObject?
        parameters["HouseNumber"] = houseNumber as AnyObject?
        parameters["Town"] = town as AnyObject?
        parameters["MedicalConditions"] = medicalConditions as AnyObject?
        parameters["GPsDetails"] = gPsDetails as AnyObject?
        parameters["OtherNotes"] = otherNotes as AnyObject?
        parameters["EmergencyName"] = emergencyName as AnyObject?
        parameters["EmergencyRelation"] = emergencyRelation as AnyObject?
        parameters["EmergencyHomeNumber"] = emergencyHomeNumber as AnyObject?
        parameters["EmergencyMobileNumber"] = emergencyMobileNumber as AnyObject?
        parameters["EmergencyWorkNumber"] = emergencyWorkNumber as AnyObject?
        parameters["Password"] = password as AnyObject?
        parameters["KeyWorkerGroupId"] = keyWorkerGroupId as AnyObject?
        parameters["NurserySchoolId"] = nurserySchoolId as AnyObject?
      
        let route = baseURL + "api/StaffMemberLogic/CreateStaffMember?nurserySchoolId=" + nurserySchoolId
        makeHTTPPost(encode: false, path: route, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func UpdateStaff(staffMemberId: String,
                     firstName: String,
                     middleName : String,
                     lastName : String,
                     dOB : Date,
                     road: String,
                     county: String? = "",
                     homePhoneNumber: String? = "",
                     postcode: String? = "",
                     mobileNumber: String? = "",
                     emailAddress: String? = "",
                     houseNumber: String? = "",
                     town: String? = "",
                     medicalConditions: String? = "",
                     gPsDetails: String? = "",
                     otherNotes: String? = "",
                     emergencyName: String? = "",
                     emergencyRelation: String? = "",
                     emergencyHomeNumber: String? = "",
                     emergencyMobileNumber: String? = "",
                     emergencyWorkNumber: String? = "",
                     password: String? = "",
                     keyWorkerGroupId: String? = "",
                    
                     onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        let StaffsDateOfBirth = dateFormatter.string(from: dOB as Date)
        
        var parameters = [String : AnyObject]()
        
        parameters["StaffMemberId"] = staffMemberId as AnyObject?
        parameters["FirstName"] = firstName as AnyObject?
        parameters["MiddleName"] = middleName as AnyObject?
        parameters["LastName"] = lastName as AnyObject?
        parameters["FullName"] = firstName + " " + middleName + " " + lastName as AnyObject? as AnyObject?
        parameters["DOB"] = StaffsDateOfBirth as AnyObject?
        parameters["Road"] = road as AnyObject?
        parameters["County"] = county as AnyObject?
        parameters["HomePhoneNumber"] = homePhoneNumber as AnyObject?
        parameters["Postcode"] = postcode as AnyObject?
        parameters["MobileNumber"] = mobileNumber as AnyObject?
        parameters["EmailAddress"] = emailAddress as AnyObject?
        parameters["HouseNumber"] = houseNumber as AnyObject?
        parameters["Town"] = town as AnyObject?
        parameters["MedicalConditions"] = medicalConditions as AnyObject?
        parameters["GPsDetails"] = gPsDetails as AnyObject?
        parameters["OtherNotes"] = otherNotes as AnyObject?
        parameters["EmergencyName"] = emergencyName as AnyObject?
        parameters["EmergencyRelation"] = emergencyRelation as AnyObject?
        parameters["EmergencyHomeNumber"] = emergencyHomeNumber as AnyObject?
        parameters["EmergencyMobileNumber"] = emergencyMobileNumber as AnyObject?
        parameters["EmergencyWorkNumber"] = emergencyWorkNumber as AnyObject?
        parameters["Password"] = password as AnyObject?
        parameters["KeyWorkerGroupId"] = keyWorkerGroupId as AnyObject?
        parameters["NurserySchoolId"] = nurserySchoolId as AnyObject?
        
        let route = baseURL + "api/StaffMemberLogic/UpdateStaffMember?nurserySchoolId=" + nurserySchoolId
        makeHTTPPut(encode: false, path: route, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
}
