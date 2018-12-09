//
//  CommonHelper.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView
import Eureka
import LocalAuthentication

class CommonHelper {
    
    var _ApplicatoinColours = ApplicatoinColours()
    
    var timeoutValue: TimeInterval = 5.0
    
    func retrieveUsingTouchId() -> Bool
    {
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "UsingTouchId")
        {
            return Int(id)!.boolValue
        }
        
        return false
    }
    
    func isDeviceTouchIdEnabled() -> Bool
    {
        var authError : NSError?
        if LAContext().canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            // do your thing dependent on touch id being useable on the device
            
            return true;
            
        }
        
        return false
    }
    
    func GetDateObjectFromString(dateAsString: String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        
        var newStart = dateFormatter.date(from: dateAsString)
        if(newStart == nil){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            newStart = dateFormatter.date(from: dateAsString)
            if(newStart == nil){
                return Date()
            }
        }
        
        return newStart!;
        
    }
    
    func ShowSuccessMessage(title: String, subsTtitle: String)
    {
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false
        )
        
        let timeoutAction: SCLAlertView.SCLTimeoutConfiguration.ActionType = {
        }
        
        let alert = SCLAlertView(appearance: appearance)
        
        alert.showSuccess(title, subTitle: subsTtitle, closeButtonTitle: "test", timeout: SCLAlertView.SCLTimeoutConfiguration(timeoutValue: timeoutValue, timeoutAction: timeoutAction), colorStyle: StyleManager.theme1().ToUint())
        
    }
    
    func ShowErrorMessage(title: String, subsTtitle: String)
    {
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false
        )
        
        let alert = SCLAlertView(appearance: appearance)
        
        let timeoutAction: SCLAlertView.SCLTimeoutConfiguration.ActionType = {
        }
        
        alert.showError(title, subTitle: subsTtitle, closeButtonTitle: "test", timeout: SCLAlertView.SCLTimeoutConfiguration(timeoutValue: timeoutValue, timeoutAction: timeoutAction),colorStyle: StyleManager.errorTheme().ToUint())
        
    }
    
    func IsStartDateAfterEndDate(startYear: Int, startMonth: Int, endYear: Int, endMonth: Int) -> Bool
    {
        if(startYear > endYear) {
            return true
        }
        
        if(startYear == endYear) {
            if(startMonth > endMonth || startMonth == endMonth) {
                return true
            }
        }
        
        return false
    }
    
    func IsStartDateAfterEndDate(startYear: Int, startMonth: Int, startDay: Int, endYear: Int, endMonth: Int, endDay: Int) -> Bool
    {
        if(startYear > endYear) {
            return true
        }
        
        if(startYear == endYear) {
            
            if(startMonth > endMonth) {
                return true
            }
            
            if(startDay > endDay || startDay == endDay) {
                return true
            }
            
        }
        
        return false
    }
    
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
        case "December":
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
    
    func DateToEncodedString(targetDate: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        return dateFormatter.string(from: targetDate as Date)
        
    }
    
    func GetIdsFromList(selection: SelectableSection<ListCheckRow<BrightStartChild>>) -> Array<String>
    {
        let kids = selection.selectedRows().map({$0.value! as BrightStartChild})
        
        var idArray = Array<String>()
        
        for n in kids {
            idArray.append(n.ChildId as String)
        }
        
        return idArray
        
    }
    
    
    
    func GetKeysFromValues(dictionary: Dictionary<String, String>, selectedArray: Set<String>) -> Array<String>
    {
        var selectedKeys = Array<String>()
        
        for (key, value) in dictionary {
            if(selectedArray.contains(value as String))
            {
                selectedKeys.append(String(key))
            }
        }
        
        return selectedKeys
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
    
    var firstDayOfWeek: Date {
        var beginningOfWeek = Date()
        var interval = TimeInterval()
        
        _ = Calendar.current.dateInterval(of: .weekOfYear, start: &beginningOfWeek, interval: &interval, for: self)
        return beginningOfWeek
    }
    
    func addWeeks(_ numWeeks: Int) -> Date {
        var components = DateComponents()
        components.weekOfYear = numWeeks
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func weeksAgo(_ numWeeks: Int) -> Date {
        return addWeeks(-numWeeks)
    }
    
    func addDays(_ numDays: Int) -> Date {
        var components = DateComponents()
        components.day = numDays
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func daysAgo(_ numDays: Int) -> Date {
        return addDays(-numDays)
    }
    
    func addHours(_ numHours: Int) -> Date {
        var components = DateComponents()
        components.hour = numHours
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func hoursAgo(_ numHours: Int) -> Date {
        return addHours(-numHours)
    }
    
    func addMinutes(_ numMinutes: Double) -> Date {
        return self.addingTimeInterval(60 * numMinutes)
    }
    
    func minutesAgo(_ numMinutes: Double) -> Date {
        return addMinutes(-numMinutes)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        let cal = Calendar.current
        var components = DateComponents()
        components.day = 1
        return cal.date(byAdding: components, to: self.startOfDay)!.addingTimeInterval(-1)
    }
    
    var zeroBasedDayOfWeek: Int? {
        let comp = Calendar.current.component(.weekday, from: self)
        return comp - 1
    }
    
    func hoursFrom(_ date: Date) -> Double {
        return Double(Calendar.current.dateComponents([.hour], from: date, to: self).hour!)
    }
    
    func daysBetween(_ date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self.startOfDay, to: date.startOfDay)
        
        return components.day!
    }
    
    var percentageOfDay: Double {
        let totalSeconds = self.endOfDay.timeIntervalSince(self.startOfDay) + 1
        let seconds = self.timeIntervalSince(self.startOfDay)
        let percentage = seconds / totalSeconds
        return max(min(percentage, 1.0), 0.0)
    }
    
    var numberOfWeeksInMonth: Int {
        let calendar = Calendar.current
        let weekRange = (calendar as NSCalendar).range(of: NSCalendar.Unit.weekOfYear, in: NSCalendar.Unit.month, for: self)
        
        return weekRange.length
    }
    
    var day:Int {return Calendar.current.component(.day, from:self)}
    var month:Int {return Calendar.current.component(.month, from:self)}
    var year:Int {return Calendar.current.component(.year, from:self)}
    
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
    
    public func ToString() -> String{
    
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "MM/dd/yy"
        
        return dateformatter.string(from: self)
    
    }
    
    public func ToStringYMD() -> String{
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "yyyy/MM/dd"
        
        return dateformatter.string(from: self)
        
    }
    
    public func ToURLString() -> String{
        
        let dateFormatter:DateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm:ss"
        
        return dateFormatter.string(from: self)
        
    }
    
    public func ToURLString2() -> String{
        
        //let dateFormatter:DateFormatter = DateFormatter()
        
        //dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        
        //let dateAsString = dateFormatter.string(from: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        return dateFormatter.string(from: self)
        
        
      //  formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        
        
        
        
       // return dateAsString
        
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
}


extension UIColor {

     public func ToUint() -> UInt{

// read colors to CGFloats and convert and position to proper bit positions in UInt32
var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        
if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
    
    var colorAsUInt : UInt32 = 0
    
    colorAsUInt += UInt32(red * 255.0) << 16 +
        UInt32(green * 255.0) << 8 +
        UInt32(blue * 255.0)
    
   return UInt(colorAsUInt)
    
        }

        return 0

}

}

extension Float {
    init(_ value: String){
        self = (value as NSString).floatValue
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

class LogoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageView = UIImageView(image: UIImage(named: "color_logo_transparent_background"))
        imageView.frame = CGRect(x: 0, y: 0, width: 320, height: 130)
        imageView.autoresizingMask = .flexibleWidth
        self.frame = CGRect(x: 0, y: 0, width: 320, height: 175)
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Int {
    var stringValue:String {
        return "\(self)"
    }
}

extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}

extension Integer {
    var boolValue: Bool {
        if self == 0 {
            return false
        } else {
            return true
        }
    }
}


