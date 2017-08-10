//
//  NurseryEvent.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Eureka

open class NurseryEvent : Comparable
{
    // function for custom operator ==
    public static func ==(lhs: NurseryEvent, rhs: NurseryEvent) -> Bool {
        return lhs.Id == rhs.Id
    }
    // function for custom operator <
    public static func <(lhs: NurseryEvent, rhs: NurseryEvent) -> Bool {
        //...
        return false
    }
    
    open var Id: NSString = ""
    open var TargetDate: Date = Date()
    open var EventText: NSString = ""
    open var EventType: EventType = .BankHoliday
    
    init () {
    }
    
}




public enum EventType: Int {
    case BankHoliday
    case Birthday
    case None
}
