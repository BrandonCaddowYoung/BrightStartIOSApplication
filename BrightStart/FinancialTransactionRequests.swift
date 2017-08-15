//
//  FinancialTransactionRequests.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Alamofire

//typealias ServiceResponse = (JSON, NSError?) -> Void

class FinancialTransactionRequests: NSObject {
    
    static let sharedInstance = FinancialTransactionRequests()
    let baseURL = ApiInformation.ApiURL
    var nurserySchoolId = "";
    
    func CreateFinancialTransaction(accountId: String, invoiceNumber: String,transactionDate : String, transactionAmount : String, transactionType: String, transactionComment: String, datePaymentHitAccount: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        var parameters = [String : AnyObject]()
        
        parameters["TransactionId"] = "0" as AnyObject?
        parameters["AccountId"] = accountId as AnyObject?
        parameters["InvoiceNumber"] = invoiceNumber as AnyObject?
        parameters["TransactionDate"] = transactionDate as AnyObject?
        parameters["TransactionAmount"] = transactionAmount as AnyObject?
        parameters["TransactionType"] = transactionType as AnyObject?
        parameters["TransactionComment"] = transactionComment as AnyObject?
        parameters["DatePaymentHitAccount"] = datePaymentHitAccount as AnyObject?
        parameters["NurserySchoolId"] = nurserySchoolId as AnyObject?
        
        let route = baseURL + "api/financialTransactionsLogic/CreateFinancialTransaction?nurserySchoolId=" + nurserySchoolId
        makeHTTPPost(encode: false, path: route, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func GetListOfAllTransactionsBelongingToAccount(accountId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/financialTransactionsLogic/GetListOfAllTransactionsBelongingToAccount?accountId=" + accountId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func GetPayment(PaymentId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/PaymentLogic/GetPayment?PaymentId=" + PaymentId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func DeletePayment(PaymentId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/PaymentLogic/DeletePaymentById?PaymentId=" + PaymentId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
        
    }
    
    func UpdatePayment(PaymentNumber: String,
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
                       PaymentTotal: String? = "",
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
        
        parameters["PaymentNumber"] = PaymentNumber as AnyObject?
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
        parameters["PaymentTotal"] = PaymentTotal as AnyObject?
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
        
        let route = baseURL + "api/PaymentLogic/UpdatePayment?nurserySchoolId=" + nurserySchoolId
        makeHTTPPut(encode: false, path: route, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    
    
    
    
    
    
    
    
    
    
}
