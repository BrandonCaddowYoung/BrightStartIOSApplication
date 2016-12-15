//
//  DayCount.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation

open class DayCount
{
    open var YetToArriveCount: Int = 0
   open var TotalExpectedInCount: Int = 0
    open var CurrentlySignedInCount: Int = 0
    open var NotCurrentlySignedInCount: Int = 0
    
    init (yetToArriveCount: Int, totalExpectedInCount: Int, currentlySignedInCount: Int, notCurrentlySignedInCount: Int) {
        
        self.YetToArriveCount = yetToArriveCount
        self.TotalExpectedInCount = totalExpectedInCount
        self.CurrentlySignedInCount = yetToArriveCount
        self.NotCurrentlySignedInCount = totalExpectedInCount
        
    }
}
