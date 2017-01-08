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
    var NavigationBarBackGroundColor: UIColor!
    var BackGroundColour: UIColor!
    var FontHeadingColour: UIColor!
    var FontColour: UIColor!
    var LabelColour: UIColor!
    
    var TableBackGroundOptionColour: UIColor!
    var TableBackGroundOptionColour2: UIColor!
    
    var TableForeGroundOptionColour: UIColor!
    
    var ButtonBackGroundColor: UIColor!
    var ButtonForeGroundColor: UIColor!
    
    var LightBlue: UIColor!
    var LightPink: UIColor!
    var Grey: UIColor!
    
    var AppleLightGrey: UIColor!
    var AppledGrey: UIColor!
    var AppleLightBlue: UIColor!
    
    var Red: UIColor!
    var Blue: UIColor!
    var White: UIColor!
    var Black: UIColor!
    
    var MenuHeadingFontSize: CGFloat!
    
    init() {
        
        //Apple Colours
        
        AppleLightGrey = hexStringToUIColor(hex: "#F7F7F7")
        AppledGrey = hexStringToUIColor(hex: "#C7C7CC")
        AppleLightBlue = hexStringToUIColor(hex: "#D1EEFC")
        
        //Bright Start Colours
        
        Red = hexStringToUIColor(hex: "#E53437")
        Blue = hexStringToUIColor(hex: "#37A0e6")
        White = hexStringToUIColor(hex: "#FFFFFF")
        Black = hexStringToUIColor(hex: "#000000")
        
        LightBlue = hexStringToUIColor(hex: "#D1EEFC")
        LightPink = hexStringToUIColor(hex: "#FD3E0")
        Grey = hexStringToUIColor(hex: "#555555")
        
        //Applicaiton Elements
        
        BackGroundColour = Blue
        
        FontColour = White
        LabelColour = Black
        FontHeadingColour = White
        
        ButtonBackGroundColor = Grey
        ButtonForeGroundColor = White
        
        NavigationBarBackGroundColor = Grey;
        
        TableBackGroundOptionColour = Grey
        TableBackGroundOptionColour2 = Blue;

        TableForeGroundOptionColour = Black
        
        MenuHeadingFontSize = 17
        
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
