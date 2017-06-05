//
//  PersonLog.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation

open class Invoice
{
    open var ChildId: Int = 0
    
    open var Early_Time_Minutes: Int = 0
    open var Late_Time_Minutes: Int = 0
    open var Registered_Time_Minutes: Int = 0
    open var NonRegistered_Time_Minutes: Int = 0
   
    open var InvoiceNumber: Int = 0
    open var InvoiceTotal: Double = 0
    open var InvoiceBalance: Double = 0
    
    open var NumberOfBusinessDays: Int = 0
    open var NumberOfFullDays: Int = 0
    open var NumberOfFullHalfDays: Int = 0
    
    open var Notes = String()
    
    open var DueDate = Date()
    open var IssueDate = Date()
    
    open var Start_Date = Date()
    open var End_Date = Date()
    
    open var NonRegisteredFinishDate = Date()
    open var NonRegisteredStartDate = Date()

    open var RegisteredFinishDate = Date()
    open var RegisteredStartDate = Date()
    
    open var ExtraFinishDate = Date()
    open var ExtraStartDate = Date()
    
    open var IsFullTime: Bool = false
    
    open var UsingFullTime: Bool = false
    open var UsingPartTime: Bool = false
   
    open var EnforceFullTime: Bool = false
    open var EnforcePartTime:  Bool = false
    
    init (){}
    
}
