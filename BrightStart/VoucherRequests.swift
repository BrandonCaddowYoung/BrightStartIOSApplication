//
//  VoucherRequests
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Alamofire

//typealias ServiceResponse = (JSON, NSError?) -> Void

class VoucherRequests: NSObject {
    
    static let sharedInstance = VoucherRequests()
    let baseURL = ApiInformation.ApiURL
    var nurserySchoolId = "";
    
    func GetAllVouchersForComboBox(onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/VoucherLogic/GetAllVouchersForComboBox?nurserySchoolId=" + nurserySchoolId
        
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
}
