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
    
    open var NurseryName: String = ""
    open var Street: String = ""
    open var County: String = ""
    open var Town: String = ""
    open var PhoneNumber: String = ""
    open var Website: String = ""
    open var EmailAddress: String = ""
     open var OwnerName: String = ""
     open var OwnerPhoneNumber: String = ""
     open var ManagerName: String = ""
     open var ManagerPhoneNumber: String = ""
     open var BankAccountName: String = ""
     open var BankAccountNumber: String = ""
    open var BankAccountSortCode: String = ""
    open var ChequePayableTo: String = ""
    open var VATNumber: String = ""
    open var PostCode: String = ""
    open var PrinterName: String = ""
    open var BillingType: String = ""
    open var NurseryScholIdentification: String = ""
    open var IsNurserySchoolUsingOnlineVersion: String = ""
    open var NurserySchoolId: String = ""
    
    init () {
    }
    
    
}
