//
//  PersonLog.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation

open class FinancialTransaction : Comparable
{
    // function for custom operator ==
    public static func ==(lhs: FinancialTransaction, rhs: FinancialTransaction) -> Bool {
        //...
        return false
    }
    // function for custom operator <
    public static func <(lhs: FinancialTransaction, rhs: FinancialTransaction) -> Bool {
        //...
        return false
    }
    
    open var TransactionComment = String()
    open var TransactionId = String()
    open var AccountId = String()
    open var InvoiceNumber = String()
    open var TransactionDate = Date()
    open var TransactionAmount = Double()
    open var TransactionType = String()
    open var DatePaymentHitAccount = Date()
    
    init (){}
    
}
