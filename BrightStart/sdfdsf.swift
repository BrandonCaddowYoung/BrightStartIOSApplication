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

class BillingRequests: NSObject {
    
    static let sharedInstance = BillingRequests()
    let baseURL = ApiInformation.ApiURL
    var nurserySchoolId = "";
    
    func SendInvoice(invoiceId: Int, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/EmailLogic/SendInvoiceInEmail?invoiceId=" + String(invoiceId) + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
        
    }
    
    
    
    
}
