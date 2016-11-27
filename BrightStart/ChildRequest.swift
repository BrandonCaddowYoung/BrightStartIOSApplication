//
//  TwitterRequest.swift
//  Twitter
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation
import Accounts
import Social
import CoreLocation

// Simple Twitter query class
// Create an instance of it using one of the initializers
// Set the requestType and parameters (if not using a convenience init that sets those)
// Call fetch (or fetchTweets if fetching Tweets)
// The handler passed in will be called when the information comes back from Twitter
// Once a successful fetch has happened,
//   a follow-on TwitterRequest to get more Tweets (newer or older) can be created
//   using the requestFor{Newer,Older} methods

private var twitterAccount: ACAccount?

open class ChildRequest
{
  
}
