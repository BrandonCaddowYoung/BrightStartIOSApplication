//
//  RegistrationHoursRequests
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation


//typealias ServiceResponse = (JSON, NSError?) -> Void

class RegistrationHoursRequests: NSObject {
    
    static let sharedInstance = RegistrationHoursRequests()
    let baseURL = "https://microsoft-apiappce8388460f4f40a6bdcea26f938e44fb.azurewebsites.net/"
    var nurserySchoolId = "";
    
    /*!
     @brief Retrieves a list of logins.
     */
    func GetRegisterdHoursyDateAndID(personId: String, DateTime: NSDate, onCompletion: @escaping (JSON) -> Void) {
        
        var id = personId
        id = id.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let DateInFormat:String = dateFormatter.string(from: DateTime as Date)
        
        let route = baseURL + "api/RegisteredHoursLogic/GetRegisterdHoursyDateAndID?personId="+id + "&DateTime=" + DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func UpdateRegisteredHours(id: String, newStartDate: NSDate, newEndDate: NSDate, onCompletion: @escaping (JSON) -> Void) {
        
        let newId = id.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        
        let startDateInFormat:String = dateFormatter.string(from: newStartDate as Date)
        let endDateInFormat:String = dateFormatter.string(from: newEndDate as Date)
        
        let route = baseURL + "api/RegisteredHoursLogic/UpdateRegisteredHours?id="+newId + "&newStartDate=" + startDateInFormat + "&newEndDate=" + endDateInFormat + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    
    
    func CreateRegisteredHours(personId: String,startTime: NSDate,finishTime: NSDate, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let startTimeInFormat:String = dateFormatter.string(from: startTime as Date)
        let finishTimeInFormat:String = dateFormatter.string(from: finishTime as Date)
        
        let route = baseURL + "api/RegisteredHoursLogic/CreateRegisteredHours2?personId="+personId + "&startTime=" + startTimeInFormat + "&finishTime=" + finishTimeInFormat + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func DeleteRegisteredHours(personId: String,dateToDelete: NSDate, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let DateInFormat:String = dateFormatter.string(from: dateToDelete as Date)
        
        let route = baseURL + "api/RegisteredHoursLogic/DeleteRegisteredHours?personId="+personId + "&dateToDelete=" + DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        makeHTTPDeleteRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
}
