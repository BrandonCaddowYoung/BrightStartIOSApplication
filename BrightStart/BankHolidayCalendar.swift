//
//  ViewController.swift
//  FSCalendarSwiftExample
//
//  Created by Brandon Young.
//  Copyright (c) 2015 wenchao. All rights reserved.
//

import UIKit
import FSCalendar
import SCLAlertView
import SVProgressHUD

class BankHolidayCalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet
    weak var calendar: FSCalendar!
    
    @IBOutlet
    weak var calendarHeightConstraint: NSLayoutConstraint!
    
    fileprivate var lunar: Bool = false {
        didSet {
            self.calendar.reloadData()
        }
    }
    fileprivate let lunarFormatter = LunarFormatter()
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    
    fileprivate let calendarPurpose: CalendarPurpose! = .BankHolidays
    
    var events = Array<NurseryEvent>()
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    // MARK:- Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        self.calendar.appearance.titleSelectionColor = UIColor.black
         self.calendar.appearance.selectionColor = UIColor.clear
        
        self.calendar.appearance.weekdayTextColor = UIColor.red
        self.calendar.appearance.headerTitleColor = UIColor.darkGray
        self.calendar.appearance.eventDefaultColor = UIColor.green
       
        self.calendar.appearance.headerDateFormat = "MMMM yyyy";
        self.calendar.appearance.todayColor = UIColor.clear
        self.calendar.appearance.borderRadius = 1.0
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
       // Retrieve all children
        EventRequests.sharedInstance.GetListOfCalednarEvents(onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
            
                let event = NurseryEvent()
                
                event.EventText = JSON["EventText"].stringValue as NSString
                event.Id = JSON["Id"].stringValue as NSString
                
                let dateFormatter = DateFormatter()
                //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
                
                let targetDate = JSON["Date"].stringValue
                
                var newDate = dateFormatter.date(from: targetDate)
                
                if(newDate == nil){
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    newDate = dateFormatter.date(from: targetDate)
                    
                    if(newDate == nil){
                        continue
                    }
                }
                
                event.TargetDate = newDate!
                
                 event.EventType = .BankHoliday
                
                self.events.append(event)
            }
            
            DispatchQueue.main.async(execute: {
            
                
                SVProgressHUD.dismiss(withDelay: 1, completion: {
                    self.calendar.reloadData()
                } )
                
               
                
            })
        
             })
        
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 400
        }
        
        self.calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
        
        let curDate = Date()
        self.calendar.select(self.formatter.date(from: curDate.ToStringYMD())!)
        
        let scopeGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        self.calendar.addGestureRecognizer(scopeGesture)
        
        // For UITest
        //self.calendar.accessibilityIdentifier = "calendar"
        
    }
    
    // MARK:- FSCalendarDataSource
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return self.gregorian.isDateInToday(date) ? "" : nil //Change this to anything you want, only four letters shoq tho. May work well for birthdays.
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        guard self.lunar else {
            return nil
        }
        return self.lunarFormatter.string(from: date)
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        
        let curDate = Date()
        let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: curDate)
        
        return self.formatter.date(from: nextYear!.ToStringYMD())!
        
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        
        if(CheckIfBankHolidayExists(date: date) == false){
            return nil
        }
        
        var targetImage: UIImage? = nil
        
        if(calendarPurpose == .BankHolidays)
        {
         targetImage = UIImage(named: "Delete-25")!
        }
        else if(calendarPurpose == .Birthdays)
        {
            targetImage = UIImage(named: "Birthday Cake-37")!
        }
        
        return targetImage
        
    }
    
    // MARK:- FSCalendarDelegate
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        print("calendar did select date \(self.formatter.string(from: date))")
        
        //Make change to below the calendar!
        
        if(CheckIfBankHolidayExists(date: date) == false){
            
            //Ask the user if they want to remove registered hours for this date
            
            let appearance = SCLAlertView.SCLAppearance(
                kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
                kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
                kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
                showCloseButton: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("NO")
            {
                //Sends to the server and then locally.
                self.CreateEvent(targetDate: date, text: "Bank Holiday")
                
                //Success message!
                
            }
            alertView.addButton("YES") {
               
                //Call server requesting to remove registered hours for this date
                
                let day: Int! = self.gregorian.component(.day, from: date)
                let month: Int! = self.gregorian.component(.month, from: date)
                let year: Int! = self.gregorian.component(.year, from: date)
                
                SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                SVProgressHUD.show()
                
                RegistrationHoursRequests.sharedInstance.RemoveAllGetListOfAllRegisteredHours(year: year, month: month, day: day, onCompletion: { JSON in
                    
                    DispatchQueue.main.async(execute: {
                        
                        //Sends to the server and then locally.
                        self.CreateEvent(targetDate: date, text: "Bank Holiday")
                        
                    })
                    
                })
            }
            
            alertView.showSuccess("New Bank Holiday", subTitle: "Would you like to remove all Registered Hours for this date? \n " + date.ToString())
            
        }
        else
        {
            let appearance = SCLAlertView.SCLAppearance(
                kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
                kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
                kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
                showCloseButton: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("OK")
            {
                //Removes from server and then locally
                self.RemoveEvent(date: date)
            }
            
            alertView.addButton("Cancel")
            {
                
            }
            
            alertView.showSuccess("Registed Hours", subTitle: "When you created this bank holiday, you may have chosen to remove all 'Registerd Hours'. If you did, you should know that these 'Registered Hours' will not re-appear.")
           
        }

    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    // MARK:- Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
    @IBAction
    func unwind2InterfaceBuilder(segue: UIStoryboardSegue) {
        
    }
    
    func CheckIfBankHolidayExists(date: Date) -> Bool
    {
        let day: Int! = self.gregorian.component(.day, from: date)
        let month: Int! = self.gregorian.component(.month, from: date)
        let year: Int! = self.gregorian.component(.year, from: date)
        
        let eventsForToday = events.filter( {
            
            let curDay: Int! = self.gregorian.component(.day, from: $0.TargetDate)
            let curMonth: Int! = self.gregorian.component(.month, from: $0.TargetDate)
            let curYear: Int! = self.gregorian.component(.year, from: $0.TargetDate)
            
            return curDay == day && curMonth == month && curYear == year
            
            }
            
        )
        
        if(eventsForToday.count == 0)
        {
            return false
        }
        
        return true
    }
    
    func RetrieveBankHolidaysForGivenDate(date: Date) -> Array<NurseryEvent>
    {
        let day: Int! = self.gregorian.component(.day, from: date)
        let month: Int! = self.gregorian.component(.month, from: date)
        let year: Int! = self.gregorian.component(.year, from: date)
        
        let eventsForToday = events.filter( {
            
            let curDay: Int! = self.gregorian.component(.day, from: $0.TargetDate)
            let curMonth: Int! = self.gregorian.component(.month, from: $0.TargetDate)
            let curYear: Int! = self.gregorian.component(.year, from: $0.TargetDate)
            
            return curDay == day && curMonth == month && curYear == year
    
            }
            
        )
        
        return eventsForToday
    }
    
    func RetrieveBankHolidayById(eventId: String) -> Array<NurseryEvent>
    {
        let eventsForToday = events.filter( { return $0.Id as String == eventId }
            
        )
        
        return eventsForToday
    }
    
    func AddNewBankHoliday(date: Date, id: String)
    {
    
    let event = NurseryEvent()
    
    event.EventText = "Bank Holiday"
        
    event.Id = id as NSString
    
    event.TargetDate = date
    event.EventType = .BankHoliday
        
    self.events.append(event)
    
    }
    
    func RemoveBankHoliday(id: String)
    {
        let bankHolidaysForGivenDate = RetrieveBankHolidayById(eventId: id)
        
        //Removing all bank holidays for the given date.
        events = events.filter { !bankHolidaysForGivenDate.contains($0) }
        
    }
    
    func CreateEvent(targetDate: Date, text: String)
    {
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        EventRequests.sharedInstance.CreateCalendarEvent(targetDate: targetDate, text: text, onCompletion:
            { json in
                
                let eventId = json.stringValue
                
                DispatchQueue.main.async(execute: {
                    
                    SVProgressHUD.dismiss(withDelay: 1, completion: {
                        //Adds locally
                        self.AddNewBankHoliday(date: targetDate, id: eventId)
                        
                        self.calendar.reloadData()
                        
                        //Show success message?
                    } )
                    
                    
                   
                    
                })
        })
        
    }
    
    
    func RemoveEvent(date: Date)
    {
        let allForDate = RetrieveBankHolidaysForGivenDate(date: date)
        
        if(allForDate.count == 0)
        {
        return
        }
        
        let eventId = allForDate.first?.Id
        
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        EventRequests.sharedInstance.DeleteCalendarEventById(id: eventId as! String, onCompletion:
            { json in
                
                DispatchQueue.main.async(execute: {
                    
                    SVProgressHUD.dismiss(withDelay: 1, completion: {
                        
                        //Removes locally
                        self.RemoveBankHoliday(id: eventId as! String)
                        
                        self.calendar.reloadData()
                        
                        //Show success message?
                        
                    } )
                    
                    
                })
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        SetNavigationBarDetails()
    }
    
    func SetNavigationBarDetails()
    {
        //Title color(Center)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: StyleManager.NavigationBarText()]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        navigationController?.navigationBar.tintColor = StyleManager.theme4()
        
        //Back ground color
        navigationController?.navigationBar.barTintColor = StyleManager.NavigationBarBackGround()
        
        let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Home"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
        
        //Right button
        self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = StyleManager.NavigationBarText()
        
        self.navigationItem.title = " "
    }
    
    func NavBarMenuTapped(){
        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
    
    
    
}



