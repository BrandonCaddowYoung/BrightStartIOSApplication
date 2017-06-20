//
//  BrightStartChild.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Eureka

open class NurseryDetails : Comparable
{
    // function for custom operator ==
    public static func ==(lhs: NurseryDetails, rhs: NurseryDetails) -> Bool {
        //...
        return false
    }
    // function for custom operator <
    public static func <(lhs: NurseryDetails, rhs: NurseryDetails) -> Bool {
        //...
        return false
    }
    
    open var Id: String = ""
    open var SMTP: String = ""
    open var EmailAddress: String = ""
    open var Port: String = ""
    open var PassWord: String = ""
    open var Name: String = ""
    open var NurserySchoolId: String = ""
    
    init () {
    }
    
    
}
