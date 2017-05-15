//
//  RegistrationHoursRequests
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Alamofire

//typealias ServiceResponse = (JSON, NSError?) -> Void

class RegistrationHoursRequests: NSObject {
    
    static let sharedInstance = RegistrationHoursRequests()
    let baseURL = ApiInformation.ApiURL
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
    
    func CreateRegisteredHours(personId: String,startTime: Date,finishTime: Date, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        let startTimeInFormat:String = dateFormatter.string(from: startTime)
        let finishTimeInFormat:String = dateFormatter.string(from: finishTime)
        
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
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let DateInFormat:String = dateFormatter.string(from: dateToDelete as Date)
        
        let route = baseURL + "api/RegisteredHoursLogic/DeleteRegisteredHours?personId="+personId + "&dateToDelete=" + DateInFormat+"&nurserySchoolId=" + nurserySchoolId
        makeHTTPDeleteRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func SetWeeklyRegisteredHours(targetChildren: [String], chosenYear: String, chosenMonth: String,mondayStartTime : String, mondayEndTime : String,tuesdayStartTime : String, tuesdayEndTime : String,wednesdayStartTime : String, wednesdayEndTime : String, thursdayStartTime : String, thursdayEndTime : String,fridayStartTime : String, fridayEndTime : String, saturdayStartTime : String, saturdayEndTime : String, sundayStartTime : String, sundayEndTime : String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
       
        let route = baseURL + "api/RegisteredHoursLogic/SetWeeklyRegisteredHours?chosenYear=" + chosenYear + "&chosenMonth=" + chosenMonth + "&mondayStartTime=" + mondayStartTime + "&mondayEndTime=" + mondayEndTime + "&tuesdayStartTime=" +  tuesdayStartTime + "&tuesdayEndTime=" +  tuesdayEndTime + "&wednesdayStartTime=" + wednesdayStartTime + "&wednesdayEndTime=" +  wednesdayEndTime + "&thursdayStartTime=" +  thursdayStartTime + "&thursdayEndTime=" + thursdayEndTime + "&fridayStartTime=" +  fridayStartTime + "&fridayEndTime=" +  fridayEndTime + "&saturdayStartTime=" +  saturdayStartTime + "&saturdayEndTime=" +  saturdayEndTime + "&sundayStartTime=" + sundayStartTime  + "&sundayEndTime=" + sundayEndTime + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPPost(encode: false, path: route, params: targetChildren.asParameters(), encoding: ArrayEncoding(), onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func RollOverRegisteredHours(targetChildren: [String], targetYear: String, targetMonth: String, destinationYear: String, destinationMonth: String, onCompletion: @escaping () -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
       
        let route = baseURL + "api/RegisteredHoursLogic/RollOver?targetYear=" + targetYear + "&targetMonth=" + targetMonth + "&destinationYear=" + destinationYear + "&destinationMonth=" + destinationMonth + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPPost(encode: false, path: route, params: targetChildren.asParameters(), encoding: ArrayEncoding(), onCompletion:
            {_,_ in 
                onCompletion()
        })
        
    }
    
}

private let arrayParametersKey = "arrayParametersKey"

/// Extenstion that allows an array be sent as a request parameters
extension Array {
    /// Convert the receiver array to a `Parameters` object.
    func asParameters() -> Parameters {
        return [arrayParametersKey: self]
    }
}


/// Convert the parameters into a json array, and it is added as the request body.
/// The array must be sent as parameters using its `asParameters` method.
public struct ArrayEncoding: ParameterEncoding {
    
    /// The options for writing the parameters as JSON data.
    public let options: JSONSerialization.WritingOptions
    
    
    /// Creates a new instance of the encoding using the given options
    ///
    /// - parameter options: The options used to encode the json. Default is `[]`
    ///
    /// - returns: The new instance
    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters,
            let array = parameters[arrayParametersKey] else {
                return urlRequest
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: options)
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = data
            
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        
        return urlRequest
    }
}
