//
//  BrightStartChild.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Eureka

open class KeyWorkerGroup : Comparable
{
    // function for custom operator ==
    public static func ==(lhs: KeyWorkerGroup, rhs: KeyWorkerGroup) -> Bool {
        //...
        return false
    }
    // function for custom operator <
    public static func <(lhs: KeyWorkerGroup, rhs: KeyWorkerGroup) -> Bool {
        //...
        return false
    }
    
    open var Name: String = ""
    open var KeyWorkerGroupId: String = ""
    
    init () {
    }
    
}
