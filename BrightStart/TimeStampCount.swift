//
//  BrightStartChild.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Eureka

open class TimeStampCount : Comparable
{
    // function for custom operator ==
    public static func ==(lhs: TimeStampCount, rhs: TimeStampCount) -> Bool {
        //...
        return false
    }
    // function for custom operator <
    public static func <(lhs: TimeStampCount, rhs: TimeStampCount) -> Bool {
        //...
        return false
    }
    
    open var ChildFullName: String = ""
    open var ChildId: String = ""
    open var NumberOfStamps: Int = 0
    open var TargetDate: Date = Date()
   
    init () {
    }
    
    init (ChildFullName: String, ChildId: String, NumberOfStamps: Int, TargetDate: Date) {
        self.ChildFullName = ChildFullName
        self.ChildId = ChildId
        self.NumberOfStamps = NumberOfStamps
        self.TargetDate = TargetDate
    }
    
}
