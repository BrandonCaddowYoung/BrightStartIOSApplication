//
//  BrightStartStaff.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Eureka

open class BrightStartStaff : Comparable
{
    // function for custom operator ==
    public static func ==(lhs: BrightStartStaff, rhs: BrightStartStaff) -> Bool {
        //...
        return false
    }
    // function for custom operator <
    public static func <(lhs: BrightStartStaff, rhs: BrightStartStaff) -> Bool {
        //...
        return false
    }
    
    
    open var StaffMemberId: NSString = ""

    open var DOB: Date = Date()
    open var FirstName: NSString = ""
    open var MiddleName: NSString = ""
    open var LastName: NSString = ""
    open var FullName: NSString = ""
    
    open var Road: NSString = ""
    open var County: NSString = ""
    open var Postcode: NSString = ""
    open var HomePhoneNumber: NSString = ""
    open var MobileNumber: NSString = ""
    open var EmailAddress: NSString = ""
    open var HouseNumber: NSString = ""
    open var Town: NSString = ""
    
    open var MedicalConditions: NSString = ""
    open var GPsDetails: NSString = ""
    open var OtherNotes : NSString = ""
    open var EmergencyName: NSString = ""
    open var EmergencyRelation: NSString = ""
     open var EmergencyHomeNumber: NSString = ""
     open var EmergencyMobileNumber: NSString = ""
      open var EmergencyWorkNumber: NSString = ""
    
     open var Password: NSString = ""
    open var KeyWorkerGroupId: NSString = ""
    open var NurserySchoolId: NSString = ""
    
    
    
    
    init () {
    }
    
    
}
