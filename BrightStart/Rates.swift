//
//  BrightStartChild.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Eureka

open class Rates : Comparable
{
    // function for custom operator ==
    public static func ==(lhs: Rates, rhs: Rates) -> Bool {
        //...
        return false
    }
    // function for custom operator <
    public static func <(lhs: Rates, rhs: Rates) -> Bool {
        //...
        return false
    }
    
    open var RateId: Float = 0.0
    open var Early_Rate_PT: Float = 0
    open var Early_Rate_FT: Float = 0
    open var Late_Rate_PT: Float = 0
    open var Late_Rate_FT: Float = 0
    open var Registered_Hours_FT: Float = 0
    open var Registered_Hours_PT: Float = 0
    open var Non_Registered_Hours_FT: Float = 0
    open var Non_Registered_Hours_PT: Float = 0
    open var Early_Grace_Minutes: Float = 0
    open var Late_Grace_Minutes: Float = 0
    open var Full_Time_Qualifying_Point_Hours: Float = 0
    open var HalfDayQualificationLower: Float = 0
    open var HalfDayQualificationUpper: Float = 0
    open var FullDayQualificationLower: Float = 0
    open var FullDayQualificationUpper: Float = 0
    open var HalfDayRate_PT: Float = 0
    open var HalfDayRate_FT: Float = 0
    open var FullDayRate_PT: Float = 0
    open var FullDayRate_FT: Float = 0
    
    init () {
    }
    
    
}
