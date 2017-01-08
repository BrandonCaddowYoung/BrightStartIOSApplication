//
//  PersonLog.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation

open class PersonLog
{
    open var Id: NSString = ""
    open var PersonId: NSString = ""
    open var TimeStamp: Date = Date()
    open var Action: NSString = ""
    
    init (id: NSString, personId: NSString, timeStamp: Date, action: NSString) {
        self.Id = id
        self.PersonId = personId
        self.TimeStamp = timeStamp
        self.Action = action
    }
    
    init (){}
    
}
