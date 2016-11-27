//
//  RegisteredCount.swift
//  BrightStart
//
//  Created by dev on 21/04/2016.
//  Copyright © 2016 dev. All rights reserved.
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
