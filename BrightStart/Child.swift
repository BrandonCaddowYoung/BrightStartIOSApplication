//
//  Child.swift
//  BrightStart
//
//  Created by Colleen Caddow on 29/11/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import Foundation

open class Child
{
    open var Name: NSString = ""
    open var Id: NSString = ""
    open var CurrentlySignedIn: Bool = false
    open var RegisteredStartTime: Date = Date()
    open var RegisteredFinishTime: Date = Date()
    
    init (name: NSString, id: NSString, currentlySignedIn: Bool, startTime: Date, endTime: Date) {
        self.Name = name
        self.Id = id
        self.CurrentlySignedIn = currentlySignedIn
        self.RegisteredStartTime = startTime
        self.RegisteredFinishTime = endTime
    }
}
