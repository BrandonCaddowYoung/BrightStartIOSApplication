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
    var NavigationBarBackBackButtonColor: UIColor!
    
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
    var Orange: UIColor!
    
    var buttonFont = UIFont()
    
    var smallFont = UIFont()
     var sshmediumlFont = UIFont()
    var mediumFont = UIFont()
    var largeFont = UIFont()
    var XlargeFont = UIFont()
    
    var MenuHeadingFontSize: CGFloat!
    
    init() {
        
        buttonFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)!
        
        smallFont = UIFont(name: "HelveticaNeue-Light", size: 10.0)!
        sshmediumlFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)!
        mediumFont = UIFont(name: "HelveticaNeue-Light", size: 20.0)!
        largeFont = UIFont(name: "HelveticaNeue-Light", size: 30.0)!
        XlargeFont = UIFont(name: "HelveticaNeue-Light", size: 40.0)!
        
        //Theme Colour
        White = hexStringToUIColor(hex: "#FFFFFF")
        Black = hexStringToUIColor(hex: "#000000")
        Grey = hexStringToUIColor(hex: "#7f909a")
        Orange = hexStringToUIColor(hex: "#ed6639")
        Blue = hexStringToUIColor(hex: "#385b9f")
        
        //Applicaiton Elements
        
        BackGroundColour = Blue
        
        NavigationBarBackGroundColor = White;
        NavigationBarBackBackButtonColor = Orange
        
        FontColour = White
        LabelColour = Black
        FontHeadingColour = White
        
        ButtonBackGroundColor = White
        ButtonForeGroundColor = Black
        
        TableBackGroundOptionColour = White
        TableBackGroundOptionColour2 = Orange;
        TableForeGroundOptionColour = Black
        
        MenuHeadingFontSize = 26
        
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
