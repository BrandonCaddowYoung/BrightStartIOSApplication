//
//  Child.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
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
