//
//  PersonStatusRequests
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Alamofire

//typealias ServiceResponse = (JSON, NSError?) -> Void

class PersonStatusRequests: NSObject {
    
    static let sharedInstance = PersonStatusRequests()
    let baseURL = ApiInformation.ApiURL
    var nurserySchoolId = "";
    
    func GetStatusById(personStatusId: String, onCompletion: @escaping (JSON) -> Void) {
        
        var id = personStatusId
        id = id.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/PersonStatusLogic/GetStatusById?PersonStatusId="+id + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func UpdatePersonStatus(personStatusId: String, leaver: String, CurrentlySignedIn: String,
                       onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let parameters: Parameters = [
            "ChildId": "",
            ]
      
        let route = baseURL + "api/PersonStatusLogic/UpdateStatus?PersonStatusId=" + personStatusId + "&Leaver=" + leaver + "&CurrentlySignedIn=" + CurrentlySignedIn + "&nurserySchoolId= " + nurserySchoolId
        
        
        
        
        
        
        makeHTTPRequest(encode: false, path: route, method: .put, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
        
    }

    
    
    
    
    

    
}
