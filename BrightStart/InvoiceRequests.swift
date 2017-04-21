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

class InvoiceRequests: NSObject {
    
    static let sharedInstance = InvoiceRequests()
    let baseURL = ApiInformation.ApiURL
    var nurserySchoolId = "";
    
    /*!
     @brief Retrieves a list of logins.
     */
    func GetAllInvoicesBelongingToChild(childId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/InvoiceLogic/GetAllInvoicesBelongingToChild?childId=" + childId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    
    func DeleteInvoice(invoiceId: Int, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/InvoiceLogic/DeleteInvoice?InvoiceId=" + String(invoiceId) + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
        
    }

    
    
    
}
