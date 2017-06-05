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
    
    let _CommonHelper = CommonHelper()
    
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
    
    //Removes all registered hours found on any bank holidays that occure between the three date ranges.
    func RemoveBankHolidayRegisteredHours(registeredHoursStartDate: Date, registeredHoursEndDate: Date, extraHoursStartDate: Date, extraHoursEndDate: Date,  nonRegisteredHoursStartDate: Date, nonRegisteredHoursEndDate: Date, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/BillingLogic/RemoveRegisteredHours?regiistrationHoursFrom=" + _CommonHelper.DateToEncodedString(targetDate: registeredHoursStartDate) + "&registatoinHoursTo=" + _CommonHelper.DateToEncodedString(targetDate: registeredHoursEndDate) + "&nonRegiistrationHoursFrom=" + _CommonHelper.DateToEncodedString(targetDate: nonRegisteredHoursStartDate) + "&nonRegistatoinHoursTo=" + _CommonHelper.DateToEncodedString(targetDate: nonRegisteredHoursEndDate) + "&nurserySchoolId=" + nurserySchoolId
        
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func CreateInvoices(targetChildren: [String], registeredHoursStartDate: Date, registeredHoursEndDate: Date, extraHoursStartDate: Date, extraHoursEndDate: Date,  nonRegisteredHoursStartDate: Date, nonRegisteredHoursEndDate: Date, dueDate: Date, onCompletion: @escaping () -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
         let route = baseURL + "api/BillingLogic/CreateInvoices?regiistrationHoursFrom=" + _CommonHelper.DateToEncodedString(targetDate: registeredHoursStartDate) + "&registatoinHoursTo=" + _CommonHelper.DateToEncodedString(targetDate: registeredHoursEndDate) + "&nonRegiistrationHoursFrom=" + _CommonHelper.DateToEncodedString(targetDate: nonRegisteredHoursStartDate) + "&nonRegistatoinHoursTo=" + _CommonHelper.DateToEncodedString(targetDate: nonRegisteredHoursEndDate) + "&extraHoursFrom=" + _CommonHelper.DateToEncodedString(targetDate: extraHoursStartDate) + "&extraHoursTo=" + _CommonHelper.DateToEncodedString(targetDate: extraHoursEndDate) + "&dueDate=" + _CommonHelper.DateToEncodedString(targetDate: dueDate) + "&enforcePartTime=false&enforceFullTime=false&shouldEmail=false&removeBankHolRegHours=false&nurserySchoolId=" + nurserySchoolId
        
        makeHTTPPost(encode: false, path: route, params: targetChildren.asParameters(), encoding: ArrayEncoding(), onCompletion:
            {_,_ in
                onCompletion()
        })
        
    }
    
    func IsInvoiceFullTime(invoiceId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/BillingLogic/IsInvoiceFullTime?invoiceId=" + invoiceId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
}
