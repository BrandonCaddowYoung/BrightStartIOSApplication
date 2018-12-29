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

class KeyWorkerGroupRequests: NSObject {
    
    static let sharedInstance = KeyWorkerGroupRequests()
    let baseURL = ApiInformation.ApiURL
    var nurserySchoolId = "";
    
    func GetkeyWorkerGroupById(keyWorkerId: String, onCompletion: @escaping (JSON) -> Void) {
        
        var id = keyWorkerId
        id = id.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/KeyWorkerGroupLogic/GetkeyWorkerGroupById?keyWorkerId="+keyWorkerId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    
    func GetAllKeyWorkerGroups(onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/KeyWorkerGroupLogic/getListOfKeyWorkerGroups?nurserySchoolId=" + nurserySchoolId
        
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    
    
}
