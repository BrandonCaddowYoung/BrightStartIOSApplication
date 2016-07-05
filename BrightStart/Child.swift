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

public class Child
{
    public var Name: NSString = ""
    public var Id: NSString = ""
    public var CurrentlySignedIn: Bool = false
    
    public var RegisteredStartTime: NSDate = NSDate()
    public var RegisteredFinishTime: NSDate = NSDate()
    
    init (name: NSString, id: NSString, currentlySignedIn: Bool, startTime: NSDate, endTime: NSDate) {
        self.Name = name
        self.Id = id
        self.CurrentlySignedIn = currentlySignedIn
        self.RegisteredStartTime = startTime
        self.RegisteredFinishTime = endTime
    }
    
}
