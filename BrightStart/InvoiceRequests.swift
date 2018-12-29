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
    
    func GetAllInvoicesBelongingToChild(childId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/BillingLogic/GetAllInvoicesBelongingToChildWithExtra?childId=" + childId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func GetInvoice(invoiceId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/InvoiceLogic/GetInvoice?invoiceId=" + invoiceId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
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
        
        let route = baseURL + "api/InvoiceLogic/DeleteInvoiceById?InvoiceId=" + String(invoiceId) + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
        
    }
    
    func UpdateInvoice(invoiceNumber: String,
                       issueDate: String,
                       startDate: String,
                       endDate: String,
                       dueDate: String? = "",
                       notes: String? = "",
                       childId: String? = "",
                       earlyTimeMinutes: String? = "",
                       lateTimeMinutes: String? = "",
                       registeredTimeMinutes: String? = "",
                       nonRegisteredTimeMinutes: String? = "",
                       invoiceTotal: String? = "",
                       enforcePartTime: String? = "",
                       enforceFullTime: String? = "",
                       registeredStartDate: String? = "",
                       registeredFinishDate: String? = "",
                       nonRegisteredStartDate: String? = "",
                       nonRegisteredFinishDate: String? = "",
                       extraStartDate: String? = "",
                       extraFinishDate: String? = "",
                       numberOfFullDays: String? = "",
                       numberOfFullHalfDays: String? = "",
                       usingPartTime: String? = "",
                       usingFullTime: String? = "",
                       numberOfBusinessDays: String? = "",
                       onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        var parameters = [String : AnyObject]()
        
        parameters["InvoiceNumber"] = invoiceNumber as AnyObject?
        parameters["IssueDate"] = issueDate as AnyObject?
        parameters["Start_Date"] = startDate as AnyObject?
        parameters["End_Date"] = endDate as AnyObject?
        parameters["DueDate"] = dueDate as AnyObject?
        parameters["Notes"] = notes as AnyObject?
        parameters["ChildId"] = childId as AnyObject?
        parameters["Early_Time_Minutes"] = earlyTimeMinutes as AnyObject?
        parameters["Late_Time_Minutes"] = lateTimeMinutes as AnyObject?
        parameters["Registered_Time_Minutes"] = registeredTimeMinutes as AnyObject?
        parameters["NonRegistered_Time_Minutes"] = nonRegisteredTimeMinutes as AnyObject?
        parameters["InvoiceTotal"] = invoiceTotal as AnyObject?
        parameters["EnforcePartTime"] = enforcePartTime as AnyObject?
        parameters["EnforceFullTime"] = enforceFullTime as AnyObject?
        parameters["RegisteredStartDate"] = registeredStartDate as AnyObject?
        parameters["RegisteredFinishDate"] = registeredFinishDate as AnyObject?
        parameters["NonRegisteredStartDate"] = nonRegisteredStartDate as AnyObject?
        parameters["NonRegisteredFinishDate"] = nonRegisteredFinishDate as AnyObject?
        parameters["ExtraStartDate"] = extraStartDate as AnyObject?
        parameters["ExtraFinishDate"] = extraFinishDate as AnyObject?
        parameters["NumberOfFullDays"] = numberOfFullDays as AnyObject?
        parameters["NumberOfFullHalfDays"] = numberOfFullHalfDays as AnyObject?
        parameters["UsingPartTime"] = usingPartTime as AnyObject?
        parameters["UsingFullTime"] = usingFullTime as AnyObject?
        parameters["NumberOfBusinessDays"] = numberOfBusinessDays as AnyObject?
        parameters["NurserySchoolId"] = nurserySchoolId as AnyObject?
        
        let route = baseURL + "api/InvoiceLogic/UpdateInvoice?nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .put, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
}
