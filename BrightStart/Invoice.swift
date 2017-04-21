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
    open var InvoiceId: Int = 0
    open var ChildId: Int = 0
    
    open var Total: Float = 0.0
    open var Balance: Float = 0.0
    
    open var RegisteredMinutes: Float = 0.0
    open var NonRegisteredMinutes: Float = 0.0
    open var LateMinutes: Float = 0.0
    open var EarlyMinutes: Float = 0.0
    
    open var Start = Date()
    open var End = Date()
    open var Issue = Date()
    
    init (id: Int, childId: Int, timeStamp: Date, action: NSString) {
        self.InvoiceId = id
        self.ChildId = childId
    
    }
    
    init (){}
    
}
