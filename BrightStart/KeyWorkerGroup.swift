//
//  PersonStatusRequests
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation


//typealias ServiceResponse = (JSON, NSError?) -> Void

class KeyWorkedGroupRequests: NSObject {
    
    static let sharedInstance = KeyWorkedGroupRequests()
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
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    
    
}
