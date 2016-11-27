//
//  Tweet.swift
//  Twitter
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation

// a simple container class which just holds the data in a Tweet
// IndexedKeywords are substrings of the Tweet's text
// for example, a hashtag or other user or url that is mentioned in the Tweet
// note carefully the comments on the two range properties in an IndexedKeyword
// Tweet instances re created by fetching from Twitter using a TwitterRequest

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
