//
//  BrightStartChild.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Eureka

open class Account : Comparable
{
    // function for custom operator ==
    public static func ==(lhs: Account, rhs: Account) -> Bool {
        //...
        return false
    }
    // function for custom operator <
    public static func <(lhs: Account, rhs: Account) -> Bool {
        //...
        return false
    }
    
    open var AccountId: String = ""
    open var AccountName: String = ""
    open var AccountDetails: String = ""
    open var HouseNumber: String = ""
    open var Road: String = ""
    open var Town: String = ""
    open var County: String = ""
    open var PostCode: String = ""
    open var HomePhoneNumber: String = ""
    open var MotherWorkPhoneNumber: String = ""
    open var FatherWorkPhoneNumber: String = ""
    open var MotherBillingEmailAddress: String = ""
    open var FatherBillingEmailAddress: String = ""
    open var PayPalEmailAddress: String = ""
    open var MotherMobile: String = ""
    open var FatherMobile: String = ""
    open var FatherPayPercentage: String = ""
    open var MotherPayPercentage: String = ""
    open var MotherOccupation: String = ""
    open var FatherOccupation: String = ""
    open var FatherName: String = ""
    open var MotherName: String = ""
    open var ExistingAccountBalance: String = ""
    open var NurserySchoolId: String = ""
    
    open var DateOpened: Date = Date()
    
    init () {
        
    }
}
