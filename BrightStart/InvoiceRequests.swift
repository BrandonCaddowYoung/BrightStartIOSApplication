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
    
    //NEED TO CHECK THE DETAILS OF THIS!
    func GetInvoice(invoiceId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/InvoiceLogic/GetInvoice?invoiceId=" + invoiceId + "&nurserySchoolId=" + nurserySchoolId
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
        
        let route = baseURL + "api/InvoiceLogic/DeleteInvoiceById?InvoiceId=" + String(invoiceId) + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
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
        
        let parameters: Parameters = [
            "InvoiceNumber": invoiceNumber,
            "IssueDate": issueDate ,
            "Start_Date": startDate ,
            "End_Date": endDate ,
            "DueDate": dueDate ?? "",
            "Notes": notes ?? "",
            "ChildId": childId ?? "",
            "Early_Time_Minutes": earlyTimeMinutes ?? "",
            "Late_Time_Minutes": lateTimeMinutes ?? "",
            "Registered_Time_Minutes": registeredTimeMinutes ?? "",
            "NonRegistered_Time_Minutes": nonRegisteredTimeMinutes ?? "",
            "InvoiceTotal": invoiceTotal,
            "EnforcePartTime": enforcePartTime,
            "EnforceFullTime": enforceFullTime ?? "",
            "RegisteredStartDate": registeredStartDate ?? "",
            "RegisteredFinishDate": registeredFinishDate ?? "",
            "NonRegisteredStartDate": nonRegisteredStartDate ?? Date(),
            "NonRegisteredFinishDate": nonRegisteredFinishDate ?? Date(),
            "ExtraStartDate": extraStartDate ?? "",
            "ExtraFinishDate": extraFinishDate ?? "",
            "NumberOfFullDays": numberOfFullDays ?? Date(),
            "NumberOfFullHalfDays": numberOfFullHalfDays,
            "UsingPartTime": usingFullTime ?? "",
            "UsingFullTime": usingFullTime ?? "",
            "NumberOfBusinessDays": numberOfBusinessDays ?? "",
            "NurserySchoolId": nurserySchoolId ,
            ]
        
        let route = baseURL + "api/AccountLogic/CreateAccount?nurserySchoolId=" + nurserySchoolId
        makeHTTPPut(encode: false, path: route, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }

    
    
    
}
