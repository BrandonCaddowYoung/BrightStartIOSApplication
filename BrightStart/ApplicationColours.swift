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
    
    var WebAPIURL = "http://brightstartwebapi126.azurewebsites.net/api";
    
    var BackGroundColour: UIColor!
    var FontHeadingColour: UIColor!
    var FontColour: UIColor!
    var LabelColour: UIColor!
    
    var TableBackGround: UIColor!
    var TableTextColor: UIColor!
    
    var TableBackGroundOptionColour: UIColor!
    var TableBackGroundOptionColour2: UIColor!
    var TableForeGroundOptionColour: UIColor!
    
    var ButtonBackGroundColor: UIColor!
    var ButtonForeGroundColor: UIColor!
    
    var LightPink: UIColor!
    var Grey: UIColor!
    
    var AppleLightGrey: UIColor!
    var AppledGrey: UIColor!
    var AppleLightBlue: UIColor!
    
    var CalendarBackGround: UIColor!
    var CalendarText: UIColor!
    var CalendarHighLighted: UIColor!
    var CalendarHighLightedText: UIColor!
    var CalendarDot: UIColor!
    var CaelndarHeader: UIColor!
    
    var Red: UIColor!
    var Blue: UIColor!
    var LightBlue: UIColor!
    var White: UIColor!
    var Black: UIColor!
    var Orange: UIColor!
    
    var buttonFont = UIFont()
    
    var smallFont = UIFont()
     var sshmediumlFont = UIFont()
    var mediumFont = UIFont()
    var largeFont = UIFont()
    var XlargeFont = UIFont()
    var MenuFont = UIFont()
    var MassiveFont = UIFont()
    
    var MenuHeadingFontSize: CGFloat!
    
    init() {
        
        buttonFont = UIFont(name: "HelveticaNeue-Thin", size: 15.0)!
        
        smallFont = UIFont(name: "HelveticaNeue-Thin", size: 10.0)!
        sshmediumlFont = UIFont(name: "HelveticaNeue-Thin", size: 15.0)!
        mediumFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0)!
        largeFont = UIFont(name: "HelveticaNeue-Thin", size: 30.0)!
        XlargeFont = UIFont(name: "HelveticaNeue-Thin", size: 40.0)!
         MassiveFont = UIFont(name: "HelveticaNeue-Thin", size: 80.0)!
        
        MenuFont = UIFont(name: "HelveticaNeue-Medium", size: 15.0)!
        
        //Theme Colour
        White = hexStringToUIColor(hex: "#FFFFFF")
        Black = hexStringToUIColor(hex: "#000000")
        Grey = hexStringToUIColor(hex: "#7f909a")
        Orange = hexStringToUIColor(hex: "#ed6639")
        Blue = hexStringToUIColor(hex: "#385b9f")
        LightBlue = hexStringToUIColor(hex: "#6889ca")
        
        //GENERAL
        BackGroundColour = Blue
        
        //NAVIGATION BAR
        NavigationBarBackGroundColor = White;
        NavigationBarBackBackButtonColor = Orange
        
        //CALENDAR
        CalendarBackGround = White;
        CalendarHighLighted = Blue
        CalendarDot = Orange;
        CalendarHighLightedText = White;
        CalendarText = Black
        CaelndarHeader = Black
        
        //TEXT
        FontColour = White
        LabelColour = Black
        FontHeadingColour = White
        
        //BUTTONS
        ButtonBackGroundColor = White
        ButtonForeGroundColor = Black
        
        //TABLES
        
        TableBackGround = White;
        TableTextColor = Blue;
        
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

extension UITextField {
    
    func setBottomBorder(backGroundColor: CGColor, underlineColor: CGColor, textColor: UIColor) {
        
        self.borderStyle = .none
        self.layer.backgroundColor = backGroundColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = underlineColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
        self.textColor = textColor
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName : textColor])
        
    }
}
