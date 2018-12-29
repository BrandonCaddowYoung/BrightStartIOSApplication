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
        makeHTTPRequest(encode: false, path: route, method: .post, params: parameters, encoding: JSONEncoding.default, onCompletion:
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
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
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
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
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
        
        let route = baseURL + "api/financialTransactionsLogic/DeleteFinancialTransaction?FinancialTransactionId=" + PaymentId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .delete, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
        
    }
    
    func UpdatePayment(
                       transactionId: String,
                       accountId: String,
                       invoiceNumber: String,
                       transactionDate: String? = "",
                       transactionAmount: String? = "",
                       transactionType: String? = "",
                       transactionComment: String? = "",
                       datePaymentHitAccount: String? = "",
                       
                       onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        var parameters = [String : AnyObject]()
        
        parameters["TransactionId"] = transactionId as AnyObject?
        parameters["AccountId"] = accountId as AnyObject?
        parameters["InvoiceNumber"] = invoiceNumber as AnyObject?
        parameters["TransactionDate"] = transactionDate as AnyObject?
        parameters["TransactionAmount"] = transactionAmount as AnyObject?
        parameters["TransactionType"] = transactionType as AnyObject?
        parameters["TransactionComment"] = transactionComment as AnyObject?
        parameters["DatePaymentHitAccount"] = datePaymentHitAccount as AnyObject?
        parameters["NurserySchoolId"] = nurserySchoolId as AnyObject?
        
        let route = baseURL + "api/financialTransactionsLogic/UpdateFinancialTransaction?nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .put, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    
    
    
    
    
    
    
    
    
    
}
