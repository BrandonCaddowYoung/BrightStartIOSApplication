//
//  RegisteredCount.swift
//  BrightStart
//
//  Created by dev on 21/04/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import Foundation

public class RegisteredCount
{
    public var NumberOfPersonWithRegisteredHours: Int = 0
    public var TargetDate: NSDate = NSDate()
    
    init (numberOfChildrenWithRegisteredHours: Int, targetDate: NSDate) {
        self.NumberOfPersonWithRegisteredHours = numberOfChildrenWithRegisteredHours
        self.TargetDate = targetDate
    }
}