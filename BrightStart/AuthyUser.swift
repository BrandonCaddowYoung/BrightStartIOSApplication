//
//  Child.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation

open class AuthyUser
{
    open var Name: NSString = ""
    open var Relationship: NSString = ""
    open var MobileNumber: NSString = ""
    open var CountryCode: NSString = ""
    open var AuhtyId: NSString = ""
    
    init (name: NSString, relationship: NSString, mobileNumber: NSString, countryCode: NSString, authyId: NSString) {
        self.Name = name
        self.Relationship = relationship
        self.MobileNumber = mobileNumber
        self.CountryCode = countryCode
        self.AuhtyId = authyId
    }
}
