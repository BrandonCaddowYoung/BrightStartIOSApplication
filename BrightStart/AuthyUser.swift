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
    open var ChildId: NSString = ""
    open var Name: NSString = ""
    open var Relationship: NSString = ""
    open var PhoneNumber: NSString = ""
    open var IsDisabled: Bool = false
    open var CountryCode: NSString = ""
    open var AuhtyId: NSString = ""
    open var Email: NSString = ""
    
    init()
    {
    
    }
    
    init (name: NSString, relationship: NSString, phoneNumber: NSString, countryCode: NSString, authyId: NSString, isDisabled: Bool, childId: NSString, email: NSString) {
        self.Name = name
        self.Relationship = relationship
        self.PhoneNumber = phoneNumber
        self.CountryCode = countryCode
        self.AuhtyId = authyId
        self.IsDisabled = isDisabled
        self.ChildId = childId
        self.Email = email
    }
}
