//
//  CommonHelper.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import UIKit

class CommonHelper {
    
    
    
    func GetMonthAsInt(monthAsString: String) -> Int
    {
        
        switch monthAsString {
        case "January":
            return 1;
        case "Febuary":
            return 2;
        case "March":
            return 3;
        case "April":
            return 4;
        case "May":
            return 5;
        case "June":
            return 6;
        case "July":
            return 7;
        case "August":
            return 8;
        case "September":
            return 9;
        case "October":
            return 10;
        case "November":
            return 11;
        case "Decemeber":
            return 12;
        default:
            return -1
        }
        
    
    }
    
    func GetDayAsInt(monthAsString: String) -> Int
    {
        
        switch monthAsString {
        case "Monday":
            return 1;
        case "Tuesday":
            return 2;
        case "Wednesday":
            return 3;
        case "Thursday":
            return 4;
        case "Friday":
            return 5;
        case "Saturday":
            return 6;
        case "Sunday":
            return 7;
        default:
            return -1
        }
        
        
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func showOverlayMessage(_ message: String) ->  UIAlertController{
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.view.layer.cornerRadius = 8.0
        alert.view.layer.masksToBounds = true
        
        
        alert.view.tintColor = UIColor.gray
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        
        return alert
        
    }
    
    func showOverlayMessage2(_ message: String) ->  ProgressHUD{
        
        let loadingSpiiner = ProgressHUD(text: message)
        
        return loadingSpiiner
        
    }
    
    
    func GetTimeAsStringFromDate(targetDate: Date) -> String
    {
        let hour = Calendar.current.component(.hour, from: targetDate)
        let minute = Calendar.current.component(.minute, from: targetDate)
        
        return String(hour) + ":" + String(minute)
        
    }
    
    
    
    

}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    
    /**
     Adds bottom border to the view with given side margins
     
     - parameter color:   the border color
     - parameter margins: the left and right margin
     */
    func addBottomBorder(color: UIColor = .red, margins: CGFloat = 0) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutAttribute.height,
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutAttribute.height,
                                                multiplier: 1, constant: 1))
        
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.bottom,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.bottom,
                                              multiplier: 1, constant: 0))
        
        
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.leading,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.leading,
                                              multiplier: 1, constant: margins))
        
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.trailing,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.trailing,
                                              multiplier: 1, constant: margins))
    }
    
    func addTopBorder(color: UIColor = .red, margins: CGFloat = 0) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutAttribute.height,
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutAttribute.height,
                                                multiplier: 1, constant: 1))
        
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.top,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.top,
                                              multiplier: 1, constant: 0))
        
        
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.leading,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.leading,
                                              multiplier: 1, constant: margins))
        
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.trailing,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.trailing,
                                              multiplier: 1, constant: margins))
    }
}

extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UITextField {
    
    func setBottomBorder(backGroundColor: CGColor, underlineColor: CGColor, textColor: UIColor, palceHoldertextColor: UIColor) {
        
        self.borderStyle = .none
        self.layer.backgroundColor = backGroundColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = underlineColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
        self.textColor = textColor
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName : palceHoldertextColor])
        
    }
}

extension Date {
    public func setTime(hour: Int, min: Int, sec: Int, timeZoneAbbrev: String = "UTC") -> Date? {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)
        
        components.timeZone = TimeZone(abbreviation: timeZoneAbbrev)
        components.hour = hour
        components.minute = min
        components.second = sec
        
        return cal.date(from: components)
    }
}


    
    




