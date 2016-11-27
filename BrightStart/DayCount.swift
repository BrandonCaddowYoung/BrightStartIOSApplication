//
//  DayCount.swift
//  BrightStart
//
//  Created by dev on 21/04/2016.
//  Copyright © 2016 dev. All rights reserved.
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
