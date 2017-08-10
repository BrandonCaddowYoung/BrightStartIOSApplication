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
    
}
