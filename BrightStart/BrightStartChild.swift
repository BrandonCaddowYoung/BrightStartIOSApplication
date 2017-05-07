//
//  BrightStartChild.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Eureka

open class BrightStartChild : Comparable
{
  
    
    // function for custom operator ==
    public static func ==(lhs: BrightStartChild, rhs: BrightStartChild) -> Bool {
        //...
        return false
    }
    // function for custom operator <
   public static func <(lhs: BrightStartChild, rhs: BrightStartChild) -> Bool {
        //...
        return false
    }
    
    
   open var AccountId: NSString = ""
    open var ChildDOB: Date = Date()
    open var ChildFirstName: NSString = ""
    open var ChildFullName: NSString = ""
    open var ChildId: NSString = ""
     open var ChildLastName: NSString = ""
     open var ChildMiddleName: NSString = ""
     open var EmergencyHomeNumber: NSString = ""
     open var EmergencyMobileNumber: NSString = ""
     open var EmergencyName: NSString = ""
     open var EmergencyRelation: NSString = ""
     open var EmergencyWorkNumber: NSString = ""
     open var EverNoteAccessToken: NSString = ""
     open var GPsDetails: NSString = ""
     open var KeyWorkerId: NSString = ""
     open var MedicalConditions: NSString = ""
     open var OtherNotes: NSString = ""
    
    init () {
            }
    
    init (childFirstName: NSString, childLastName: NSString, childId: NSString, childDOB: Date) {
        self.ChildFirstName = childFirstName
        self.ChildLastName = childLastName
        self.ChildId = childId
        self.ChildDOB = childDOB
    }
    
}
