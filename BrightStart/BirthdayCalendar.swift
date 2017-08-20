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

class BirthdayCalendarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FSCalendarDataSource, FSCalendarDelegate {
    
     @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet
    weak var calendar: FSCalendar!
    
    @IBOutlet
    weak var calendarHeightConstraint: NSLayoutConstraint!
    
     var childrenArray = Array<BrightStartChild>()
    
    var childrenWithBirthdaysToday = Array<BrightStartChild>()
    
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
    
    //var events = Array<NurseryEvent>()
    
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
        
        //Retrieve all children
        ChildRequests.sharedInstance.GetAllEnrolledChilren(onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                let child = BrightStartChild()
              
                child.ChildFirstName = JSON["ChildFirstName"].stringValue as NSString
                child.ChildLastName = JSON["ChildLastName"].stringValue as NSString
                
                child.ChildId = JSON["ChildId"].stringValue as NSString
                
                let dateFormatter = DateFormatter()
                //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
                
                let dateOfBirth = JSON["ChildDOB"].stringValue
                
                var newDate = dateFormatter.date(from: dateOfBirth)
                
                if(newDate == nil){
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    newDate = dateFormatter.date(from: dateOfBirth)
                    
                    if(newDate == nil){
                        continue
                    }
                }
                
                child.ChildDOB = newDate!
                
                self.childrenArray.append(child)
            }
            
            DispatchQueue.main.async(execute: {
                
                //let fullChildList = Dictionary(keyValuePairs: self.childrenArray.map{($0.ChildId, $0.ChildFullName)})
                
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
       return RetrieveBirhtdaysForGivenDate(date: date).count
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        
        if(RetrieveBirhtdaysForGivenDate(date: date).count == 0)
        {
            return nil;
        }
        
//        if(CheckIfBirthdayExists(date: date) == false){
//            return nil
//        }
        
        return UIImage(named: "Party Baloon-25")!
        
    }
    
    // MARK:- FSCalendarDelegate
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
       // print("change page to \(self.formatter.string(from: calendar.currentPage))")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
       // print("calendar did select date \(self.formatter.string(from: date))")
        
        childrenWithBirthdaysToday = RetrieveBirhtdaysForGivenDate(date: date)
        tableView.reloadData()
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
    
    func CheckIfBirthdayExists(date: Date) -> Bool
    {
        let day: Int! = self.gregorian.component(.day, from: date)
        let month: Int! = self.gregorian.component(.month, from: date)
        
        let eventsForToday = childrenArray.filter( {
            
            let curDay: Int! = self.gregorian.component(.day, from: $0.ChildDOB)
            let curMonth: Int! = self.gregorian.component(.month, from: $0.ChildDOB)
            
            return curDay == day && curMonth == month
            
            }
            
        )
        
        if(eventsForToday.count == 0)
        {
            return false
        }
        
        return true
    }
    
    func RetrieveBirhtdaysForGivenDate(date: Date) -> Array<BrightStartChild>
    {
        let day: Int! = self.gregorian.component(.day, from: date)
        let month: Int! = self.gregorian.component(.month, from: date)
        let year: Int! = self.gregorian.component(.year, from: date)
        
        let eventsForToday = childrenArray.filter( {
            
            let curDay: Int! = self.gregorian.component(.day, from: $0.ChildDOB)
            let curMonth: Int! = self.gregorian.component(.month, from: $0.ChildDOB)
            let curYear: Int! = self.gregorian.component(.year, from: $0.ChildDOB)
            
            return curDay == day && curMonth == month && curYear == year
            
            }
        )
        
        return eventsForToday
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
    
    // MARK:- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        let numberOfBirthdaysToday = childrenWithBirthdaysToday.count
        
        return [numberOfBirthdaysToday][section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let personFirstName = childrenWithBirthdaysToday[indexPath.row].ChildFirstName
        let personLastName = childrenWithBirthdaysToday[indexPath.row].ChildLastName
        
        cell.textLabel?.text = "Happy Birthday " + (personFirstName as String) + " " + (personLastName as String) + "!"
        
        return cell
    }
    
    // MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Nothing
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
}
