//
//  ApplicationColours.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import UIKit

class ApplicatoinColours {
    
    //DEFAULTS
    var BackGroundColour: UIColor!
    var FontHeadingColour: UIColor!
    var FontColour: UIColor!
    
    var LightBlue: UIColor!
    var LightPink: UIColor!
    var Grey: UIColor!
    
    init() {
        BackGroundColour = hexStringToUIColor(hex: "#37A0e6") //BLUE
        FontColour = hexStringToUIColor(hex: "#FFFFFF") //WHITE
        FontHeadingColour = hexStringToUIColor(hex: "#000000") //Black

        
        LightBlue = hexStringToUIColor(hex: "#69BAE4")
        LightPink = hexStringToUIColor(hex: "#DD95B7")
        Grey = hexStringToUIColor(hex: "#3F3F3F")
        
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
