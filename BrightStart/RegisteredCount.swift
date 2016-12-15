//
//  RegisteredCount.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation

open class RegisteredCount
{
    open var NumberOfPersonWithRegisteredHours: Int = 0
    open var TargetDate: Date = Date()
    
    init (numberOfChildrenWithRegisteredHours: Int, targetDate: Date) {
        self.NumberOfPersonWithRegisteredHours = numberOfChildrenWithRegisteredHours
        self.TargetDate = targetDate
    }
}
