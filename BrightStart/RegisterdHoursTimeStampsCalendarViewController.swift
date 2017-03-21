//
//  RegisteredHoursViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 11/02/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

import JTAppleCalendar

class RegisterdHoursTimeStampsCalendarViewController: UIViewController {

    //Arguments
    
    var numberOfDateTaps = 0;
    
    var showNavigationBar = true
    
    var selectCalendarPurpose = CalendarPurpose.RegistrationHours
    
    var homeSeqgueIdentifier = ""
    
    var childId = ""
    
    var OptionText = ""
    var Purpose = ""
    
    @IBOutlet weak var targetPersonButton: UIButton!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var typeSwitch: UISegmentedControl!
    
    //End of mandatory arguments
    @IBOutlet weak var startSpinner: UIActivityIndicatorView!
    @IBOutlet weak var endSpinner: UIActivityIndicatorView!
    
    var creatingNew = false
    
    var loadingSpiiner: ProgressHUD!
    
    var childName = ""
    
    var hideHeader = true;
    
    var hideFutureDates = false;
    var hidePastDate = false;
    
    var makeFutureDatesUnselectable = false;
    var makePastDatesUnselectable = false;
    
    var lastSelectedDate = Date()
    
    var startSelected = false
    var endSelected = false
    
    //End
    
    var selectedStartDate = Date()
    var selectedEndDate = Date()
    
    var selectedRegisteredHoursId = String()
    
    var selectedPersonLogStartId = String()
    var selectedPersonLogEndId = String()
    
    var editSegueIdentifier = ""
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    //TBD
    // We cache our colors because we do not want to be creating
    // a new color every time a cell is displayed. We do not want a laggy
    // scrolling calendar.
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var addNewButtonStart: UIImageView!
    @IBOutlet weak var addNewButtonEnd: UIImageView!
    
    @IBOutlet weak var TopPadding: UIView!
    
    @IBOutlet weak var rightDeleteButton: UIImageView!
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var leftContainer: UIView!
    @IBOutlet weak var rightContainer: UIView!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var bottomContainer: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var LeftTopContainer: UIView!
    
    @IBOutlet weak var RightTopContainer: UIView!
    
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        NameLabel.text = childName
        NameLabel.textColor = _ApplicatoinColours.FontColour
        
        NameLabel.font = _ApplicatoinColours.largeFont
        
        startSpinner.hidesWhenStopped = true
        endSpinner.hidesWhenStopped = true
        
        loadingSpiiner = ProgressHUD(text: "Loading")
        self.view.addSubview(loadingSpiiner)
        hideSpinner()
        
        addNewButtonStart.isHidden = true
        addNewButtonEnd.isHidden = true
        
        //Adding click to start time
        startTime.isUserInteractionEnabled = true;
        let startTap = UITapGestureRecognizer(target: self, action: #selector(startTimeClicked))
        startTime.addGestureRecognizer(startTap)
        
        //Adding click to end time
        endTime.isUserInteractionEnabled = true;
        let endTap = UITapGestureRecognizer(target: self, action: #selector(endTimeClicked))
        endTime.addGestureRecognizer(endTap)
        
        //Adding click to add new start
        addNewButtonStart.isUserInteractionEnabled = true;
        let addNewButtonStartTap = UITapGestureRecognizer(target: self, action: #selector(addNewButtonStartClicked))
        addNewButtonStart.addGestureRecognizer(addNewButtonStartTap)
        
        addNewButtonStart.image = addNewButtonStart.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        addNewButtonStart.tintColor = _ApplicatoinColours.Grey
        
        //Adding click to add new end
        addNewButtonEnd.isUserInteractionEnabled = true;
        let addNewButtonEndTap = UITapGestureRecognizer(target: self, action: #selector(addNewButtonEndClicked))
        addNewButtonEnd.addGestureRecognizer(addNewButtonEndTap)
       
        addNewButtonEnd.image = addNewButtonEnd.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        addNewButtonEnd.tintColor = _ApplicatoinColours.Grey
        
        calendarView.registerHeaderView(xibFileNames: ["TimeStampsSectionHeaderView", "TimeStampsSectionHeaderView"])
        
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewXib(file: "CellView") // Registering your cell is manditory
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        
        leftContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        rightContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        calendarView.backgroundColor = _ApplicatoinColours.CalendarBackGround
        
        topContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        bottomContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        LeftTopContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        RightTopContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        RightTopContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        TopPadding.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        view.backgroundColor =  _ApplicatoinColours.BackGroundColour
        
        bottomContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        startLabel.font = _ApplicatoinColours.mediumFont
        finishLabel.font = _ApplicatoinColours.mediumFont
        
        startLabel.textColor = _ApplicatoinColours.FontColour
       finishLabel.textColor = _ApplicatoinColours.FontColour
        
        setupConstraints()
        
        //Single tap.
        let singleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSingleTapCollectionView(gesture:)))
        
        singleTapGesture.numberOfTapsRequired = 1  // add double tap
        
        if(selectCalendarPurpose == .TimeStamps)
        {
             editSegueIdentifier = "GoTotimeStampsEditor"
            
             startLabel.text = "Sign in"
             finishLabel.text = "Sign out"
            
        }
        if(selectCalendarPurpose == .RegistrationHours)
        {
            editSegueIdentifier = "GoTotimeStampsEditor"
            
            startLabel.text = "Start"
            finishLabel.text = "Finish"
        }
      
        calendarView.scrollToDate(Date())
        
        monthLabel.textColor = _ApplicatoinColours.White
        yearLabel.textColor = _ApplicatoinColours.White
        
typeSwitch.tintColor = _ApplicatoinColours.Grey
        
        typeSwitch.isHidden = true
        
        startTime.textColor = _ApplicatoinColours.White
        endTime.textColor = _ApplicatoinColours.White
        
        //Finally select the current date
        self.calendarView.selectDates([NSDate() as Date])
        
    }

    func showSpinner()
    {
        loadingSpiiner.show()
    }
    
    func hideSpinner()
    {
        //if(loadingSpiiner!=nil){
        loadingSpiiner.hide()
        //}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.calendarView.selectDates([self.lastSelectedDate])
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        else
        {
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
            
        //Changes the color of the backgorund within the nav bar.
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.barTintColor = _ApplicatoinColours.Black
        
        //Title color
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: _ApplicatoinColours.Black]
        navigationController?.navigationBar.titleTextAttributes = titleDict as! [String : Any]
        
        //Back color
        navigationController?.navigationBar.tintColor = _ApplicatoinColours.NavigationBarBackBackButtonColor //Orange
        
        //Back ground color
        navigationController?.navigationBar.barTintColor = _ApplicatoinColours.NavigationBarBackGroundColor // Grey
        
        let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
        
        self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
        
        self.navigationItem.rightBarButtonItem?.tintColor = _ApplicatoinColours.Black
        
            
            if(selectCalendarPurpose == .TimeStamps){
                navigationController?.navigationBar.topItem?.title = "Time Stamps"
            }
            else if(selectCalendarPurpose == .RegistrationHours){
               navigationController?.navigationBar.topItem?.title = "Registered Hours"
            }
            
        navigationController?.navigationBar.backItem?.title = ""
            
        }
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        
        let myCustomCell = cell as! CellView
        
        // Setup Cell text
        myCustomCell.dayLabel.text = cellState.text
        myCustomCell.dayLabel.textColor = _ApplicatoinColours.CalendarHighLightedText
        
        //if(cellState.dateBelongsTo == .thisMonth){
        //myCustomCell.dayLabel.textColor = _ApplicatoinColours.Red
          //  }
            //else
            //{ myCustomCell.dayLabel.textColor = _ApplicatoinColours.Red
           // }
        
        if cellState.dateBelongsTo == .thisMonth {
            myCustomCell.isUserInteractionEnabled = true
        } else {
            myCustomCell.isUserInteractionEnabled = false
        }
        
        myCustomCell.selectedView.backgroundColor = _ApplicatoinColours.CalendarHighLighted
        
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellSelection(view: cell, cellState: cellState)
        
         //lastSelectedDate = date
        
        //makeFutureDatesUnselectable = false
        //makePastDatesUnselectable = false
        
        //let cuDate = Date()
        
        //if(makeFutureDatesUnselectable==true){
        //if cellState.date >  cuDate {
          //  myCustomCell.isUserInteractionEnabled = false
        //} else {
          //  myCustomCell.isUserInteractionEnabled = true
        //}
       // }
        
        //if(makePastDatesUnselectable==true){
          //  if (cellState.date <  Date()) {
            //    myCustomCell.isUserInteractionEnabled = false
           // }
           // else {
             //   myCustomCell.isUserInteractionEnabled = true
           // }
        //}
        
    }
    
    func didSingleTapCollectionView(gesture: UITapGestureRecognizer) {
        //let point = gesture.location(in: gesture.view!)
        //let cellState = calendarView.cellStatus(at: point)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleDayCellView,
                  
                  //This month only!
                  cellState: CellState) -> Bool {
        
        //if cellState.dateBelongsTo == .thisMonth {
          //  return true
        //} else {
          //  return false
        //}
        
        lastSelectedDate = date
        
        if(Purpose == "TimeStamps_Search")
        {
         self.performSegue(withIdentifier: "TimeStamps_Search", sender: nil)
        }
        else if(Purpose == "TimeStamps_Missing")
        {
            self.performSegue(withIdentifier: "GoToSearchPerson_ExtraMinutes", sender: nil)
        }
        
        return true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*!
     @brief Sets up all constraints for the view..
     */
    func setupConstraints() {
    
        //Top Padding
        
       
        
        TopPadding.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TopPadding.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        //right
        TopPadding.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //top
        TopPadding.topAnchor.constraint(
            equalTo: view.topAnchor).isActive = true

        TopPadding.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.02).isActive = true
        
        
    //Top container
        
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        topContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        //right
        topContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //top
        topContainer.topAnchor.constraint(
            equalTo: TopPadding.bottomAnchor).isActive = true
        
        //Name label
        NameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        NameLabel.leadingAnchor.constraint(
            equalTo: topContainer.leadingAnchor, constant: 15 ).isActive = true
        
        //top
        NameLabel.topAnchor.constraint(
            equalTo: topContainer.topAnchor).isActive = true
        
        //targetPersonButton
        targetPersonButton.translatesAutoresizingMaskIntoConstraints = false
        
        targetPersonButton.widthAnchor.constraint(
            equalToConstant: 20).isActive = true
        
        targetPersonButton.heightAnchor.constraint(
            equalToConstant: 20).isActive = true
        
        targetPersonButton.leadingAnchor.constraint(
            equalTo: NameLabel.trailingAnchor, constant: 10).isActive = true
        
        targetPersonButton.centerYAnchor.constraint(
         equalTo: NameLabel.centerYAnchor).isActive = true
        
        //typeSwitch
        typeSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        typeSwitch.centerYAnchor.constraint(
            equalTo: NameLabel.centerYAnchor).isActive = true
        
        //right
        typeSwitch.trailingAnchor.constraint(
            equalTo: topContainer.trailingAnchor, constant: -15).isActive = true
        
        //Month label
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        monthLabel.leadingAnchor.constraint(
            equalTo: topContainer.leadingAnchor, constant: 15).isActive = true
        
        //top
        monthLabel.topAnchor.constraint(
            equalTo: NameLabel.bottomAnchor, constant: 20).isActive = true
        
        monthLabel.heightAnchor.constraint(
            equalTo: topContainer.heightAnchor, multiplier: 0.20).isActive = true
        
        //year label
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //right
        yearLabel.trailingAnchor.constraint(
            equalTo: topContainer.trailingAnchor, constant: -15).isActive = true
        
        //top
        yearLabel.centerYAnchor.constraint(
            equalTo: monthLabel.centerYAnchor).isActive = true
        
        //Stack view
        
    stackView.translatesAutoresizingMaskIntoConstraints = false
        
    stackView.topAnchor.constraint(
        equalTo: monthLabel.bottomAnchor, constant: 10).isActive = true
        
        //left
        stackView.leadingAnchor.constraint(
            equalTo: topContainer.leadingAnchor).isActive = true
        
        //right
        stackView.trailingAnchor.constraint(
            equalTo: topContainer.trailingAnchor).isActive = true
        
        topContainer.bottomAnchor.constraint(
            equalTo: stackView.bottomAnchor).isActive = true
        
        //Calendar
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        calendarView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //right
        calendarView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //top
        calendarView.topAnchor.constraint(
            equalTo: topContainer.bottomAnchor).isActive = true
        
        //height
        calendarView.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.60).isActive = true
        
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        bottomContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //right
        bottomContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //top
        bottomContainer.topAnchor.constraint(
            equalTo: calendarView.bottomAnchor).isActive = true
        
        //bottom
        bottomContainer.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        
        //RIGHT
        
        rightContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //width
        rightContainer.widthAnchor.constraint(
            equalTo: bottomContainer.widthAnchor,
            multiplier:0.50).isActive = true
       
        //right
        rightContainer.trailingAnchor.constraint(
            equalTo: bottomContainer.trailingAnchor).isActive = true
        
        //top
        rightContainer.topAnchor.constraint(
            equalTo: bottomContainer.topAnchor).isActive = true
        
        //bottom
        rightContainer.bottomAnchor.constraint(
            equalTo: bottomContainer.bottomAnchor).isActive = true
        
        RightTopContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        RightTopContainer.leadingAnchor.constraint(
            equalTo: rightContainer.leadingAnchor).isActive = true
        
        //right
        RightTopContainer.trailingAnchor.constraint(
            equalTo: rightContainer.trailingAnchor).isActive = true
        
        //top
        RightTopContainer.topAnchor.constraint(
            equalTo: rightContainer.topAnchor).isActive = true
        
        //top
        RightTopContainer.bottomAnchor.constraint(
           equalTo: view.bottomAnchor).isActive = true
        
        //LEFT
        
        leftContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //width
        leftContainer.widthAnchor.constraint(
            equalTo: bottomContainer.widthAnchor,
            multiplier:0.50).isActive = true
        
        //left
        leftContainer.leadingAnchor.constraint(
            equalTo: bottomContainer.leadingAnchor).isActive = true
        
        //top
        leftContainer.topAnchor.constraint(
            equalTo: bottomContainer.topAnchor).isActive = true
        
        //bottom
        leftContainer.bottomAnchor.constraint(
            equalTo: bottomContainer.bottomAnchor).isActive = true
        
        LeftTopContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        LeftTopContainer.leadingAnchor.constraint(
            equalTo: leftContainer.leadingAnchor).isActive = true
        
        //right
        LeftTopContainer.trailingAnchor.constraint(
            equalTo: leftContainer.trailingAnchor).isActive = true
        
        //top
        LeftTopContainer.topAnchor.constraint(
            equalTo: leftContainer.topAnchor).isActive = true
        
        //bottom
        LeftTopContainer.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        
        //NEW BUTTON START
        
        addNewButtonStart.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        addNewButtonStart.centerXAnchor.constraint(
            equalTo: LeftTopContainer.centerXAnchor).isActive = true
        
        //top
        addNewButtonStart.centerYAnchor.constraint(
            equalTo: LeftTopContainer.centerYAnchor).isActive = true

        addNewButtonStart.heightAnchor.constraint(
            equalTo: LeftTopContainer.heightAnchor,  multiplier: 0.50).isActive = true
        
        //NEW BUTTON END
        
        addNewButtonEnd.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        addNewButtonEnd.centerXAnchor.constraint(
            equalTo: RightTopContainer.centerXAnchor).isActive = true
        
        //top
        addNewButtonEnd.centerYAnchor.constraint(
            equalTo: RightTopContainer.centerYAnchor).isActive = true
        
        addNewButtonEnd.heightAnchor.constraint(
            equalTo: RightTopContainer.heightAnchor,  multiplier: 0.50).isActive = true
        
        //START SPINNER
        
        startSpinner.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        startSpinner.centerXAnchor.constraint(
            equalTo: LeftTopContainer.centerXAnchor).isActive = true
        
        //top
        startSpinner.centerYAnchor.constraint(
            equalTo: LeftTopContainer.centerYAnchor).isActive = true
        
        //startSpinner.heightAnchor.constraint(
           // equalTo: LeftTopContainer.heightAnchor,  multiplier: 0.50).isActive = true
        
        //END SPINNER
        
        endSpinner.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        endSpinner.centerXAnchor.constraint(
            equalTo: RightTopContainer.centerXAnchor).isActive = true
        
        //top
        endSpinner.centerYAnchor.constraint(
            equalTo: RightTopContainer.centerYAnchor).isActive = true
        
        //endSpinner.heightAnchor.constraint(
          //  equalTo: RightTopContainer.heightAnchor,  multiplier: 0.50).isActive = true
        
        startTime.translatesAutoresizingMaskIntoConstraints = false
        
        startTime.centerYAnchor.constraint(
            equalTo: LeftTopContainer.centerYAnchor).isActive = true
        
        startTime.centerXAnchor.constraint(
            equalTo: LeftTopContainer.centerXAnchor).isActive = true
        
        endTime.translatesAutoresizingMaskIntoConstraints = false
        
        endTime.centerYAnchor.constraint(
            equalTo: RightTopContainer.centerYAnchor).isActive = true
        
        endTime.centerXAnchor.constraint(
            equalTo: RightTopContainer.centerXAnchor).isActive = true
        
        //FINSIH LABEL
        
        finishLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        finishLabel.leadingAnchor.constraint(
            equalTo: RightTopContainer.leadingAnchor, constant: 10).isActive = true

        //top
        finishLabel.topAnchor.constraint(
            equalTo: RightTopContainer.topAnchor, constant: 10).isActive = true
        
        //START LABEL
        
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        startLabel.leadingAnchor.constraint(
            equalTo: LeftTopContainer.leadingAnchor, constant: 10).isActive = true
        
        //top
        startLabel.topAnchor.constraint(
            equalTo: LeftTopContainer.topAnchor,  constant: 10).isActive = true
    }
    
    
    // Function to handle the text color of the calendar
    func handleCellTextColor(view: JTAppleDayCellView?, cellState: CellState) {
        
        guard let myCustomCell = view as? CellView  else {
            return
        }
        
        if cellState.isSelected {
            myCustomCell.dayLabel.textColor = _ApplicatoinColours.CalendarHighLightedText
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                myCustomCell.dayLabel.textColor = _ApplicatoinColours.CalendarText
            } else {
                myCustomCell.dayLabel.textColor = _ApplicatoinColours.CalendarBackGround
            }
        }
    }
    
    // Function to handle the calendar selection
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? CellView  else {
            return
        }
        if cellState.isSelected {
            myCustomCell.selectedView.layer.cornerRadius =  25
            myCustomCell.selectedView.isHidden = false
        } else {
            myCustomCell.selectedView.isHidden = true
        }
    }
    
   
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        
        self.numberOfDateTaps += 1
        
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        startSpinner.startAnimating()
        endSpinner.startAnimating()
        
        self.startTime.isHidden = true;
        self.endTime.isHidden = true;
        self.addNewButtonEnd.isHidden = true
        self.addNewButtonStart.isHidden = true
        
        
        if(selectCalendarPurpose == .TimeStamps){
        
            fetchTimeStamps()
            
        }
        else if(selectCalendarPurpose == .RegistrationHours){
        
            fetchRegisteredHours()
            
        }
        else if(selectCalendarPurpose == .MissingTimeStamps_Person){
            
            if(numberOfDateTaps > 1){
            
            self.performSegue(withIdentifier: "GoToTimeStamp_Search", sender: nil)
                
            }
        }
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    // This sets the height of your header
    func calendar(_ calendar: JTAppleCalendarView, sectionHeaderSizeFor range: (start: Date, end: Date), belongingTo month: Int) ->
        
        CGSize {
            var height = 40
            
            if(hideHeader){
            height = 0
            }
            
        return CGSize(width: 200, height: height)
    }
    
    // This setups the display of your header
    func calendar(_ calendar: JTAppleCalendarView, willDisplaySectionHeader header: JTAppleHeaderView, range: (start: Date, end: Date), identifier: String) {
        
        let headerCell = (header as? TimeStampsSectionHeaderView)
        headerCell?.title.text = "Registered Hours"
        headerCell?.backgroundColor = .red
        
        if(hideHeader){
            headerCell?.title.textColor = _ApplicatoinColours.CalendarBackGround
        }
        else
        {
        headerCell?.title.textColor = _ApplicatoinColours.CaelndarHeader
        }
       
    }
    
    // Also add this delegate function.
    // This tells the calendar which headerView you want displayed for a particular date.
    // The names should be the same as what was registered.
    func calendar(_ calendar: JTAppleCalendarView, sectionHeaderIdentifierFor range: (start: Date, end: Date), belongingTo month: Int) -> String {
        
        let calendar2 = Calendar.current
        
        let dateFormatter: DateFormatter = DateFormatter()
        let months = dateFormatter.monthSymbols
        var monthSymbol = ""
        
        if(month > 0){
            monthSymbol = (months?[month - 1])! as String // month - from your date components
            
            
        }
        
        //self.yearLabel.text = String(startYear)
        monthLabel.text = monthSymbol
        
         yearLabel.text = String(calendar2.component(.year, from: range.start))
        
        if month % 2 > 0 {
            return "TimeStampsSectionHeaderView"
        }
        return "TimeStampsSectionHeaderView"
    }
    
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMainMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                
                if(selectCalendarPurpose == .TimeStamps){
                    vc.selectedMenu = .TimeStamps
                }
                else if(selectCalendarPurpose == .RegistrationHours){
                    vc.selectedMenu = .RegisteredHours
                }
                
                
            }
        }
            
        else if (segue.identifier == "GoToRegistrationHoursEditor") {
            
            if let vc = segue.destination as? AddRegisteredHoursViewController {
                
                vc.personName = childName
                vc.personId = childId
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                vc.targetDateAsText = dateFormatter.string(from: lastSelectedDate) as String
                
                vc.targetDate = lastSelectedDate as NSDate
                
            }
        }
        
       else if (segue.identifier == "GoTotimeStampsEditor") {
            
                if let vc = segue.destination as? TimeStampsEditorViewController {
                    
                    if(selectCalendarPurpose == .RegistrationHours)
                    {
                        vc.EditorMode = .RegisteredHours_Edit
                        
                        vc.existingStartDate = selectedStartDate
                        vc.existingEndDate = selectedEndDate
                        
                        vc.goBackOnSuccess = true
                        
                        vc.registerdHoursId = selectedRegisteredHoursId
                        
                        if(startSelected){
                            vc.editType = .Start
                        }
                        if(endSelected)
                        {
                            vc.editType = .End
                        }
                        
                    }
                    else if(selectCalendarPurpose == .TimeStamps)
                    {
                        vc.goBackOnSuccess = true
                        
                        if(creatingNew == false){
                            vc.EditorMode = .TimeStamps_Edit
                        }
                        else
                        {
                            vc.EditorMode = .TimeStamps_Create

                        }
                        
                        if(startSelected){
                            vc.editType = .Start
                        }
                        if(endSelected)
                        {
                            vc.editType = .End
                        }
                        
                    }
                    
                    let dateFormatter = DateFormatter()
                    
                    vc.PersonId = childId
                    vc.Name = childName
                    
                    var action = ""
                    
                    if(startSelected){
                        action = "Login"
                    }
                    if(endSelected)
                    {
                        action = "Logout"
                    }
                    
                    vc.Action = action
                    
                    var chosenDate = Date()
                    
                    if(startSelected){
                        chosenDate = selectedStartDate
                    }
                    if(endSelected)
                    {
                        chosenDate = selectedEndDate
                    }
                    
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    vc.Date = dateFormatter.string(from: chosenDate) as String
                    
                    dateFormatter.dateFormat = "hh:mm:ss"
                    vc.Time = dateFormatter.string(from: chosenDate) as String
                    
                    vc.DateAsObject = chosenDate
                    
                }
        }
            
       else if (segue.identifier == "GoToTimeStamp_Search") {
            
            if let vc = segue.destination as? TimeStampSearchTableViewController {
                
                vc.TargetDate = lastSelectedDate
                
                //Because it was 00:00 it thought it was the next day, so just rewinding the click 60 mintes.
                 vc.TargetDate = vc.TargetDate.addingTimeInterval(60)
                
                vc.TargetPersonId = childId as NSString!
                vc.SelectedPersonFullName = childName as NSString!
                
                vc.OptionText = "Searching time stamps"
                
            }
        }
            
        else if (segue.identifier == "GoToSearchPerson_ExtraMinutes") {
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.targetDate = lastSelectedDate
                
                vc.Purpose = "GoToSearchPerson_ExtraMinutes"
                vc.successSegueIdentifier = "GoToTimeStampSearch"
                
            }
        }
            
        else if (segue.identifier == "GoToEditTimeStampOrRegisteredHoours") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? TimeStampsEditorViewController {
                
                if(selectCalendarPurpose == .RegistrationHours)
                {
                    vc.EditorMode = .RegisteredHours_Edit
                }
                else if(selectCalendarPurpose == .TimeStamps)
                {
                    vc.EditorMode = .TimeStamps_Edit
                }
                
                let dateFormatter = DateFormatter()
                
                vc.PersonId = childId
                vc.Name = childName
                
                var action = ""
                
                if(startSelected){
                    action = "Login"
                }
                if(endSelected)
                {
                    action = "Logout"
                }
                
                vc.Action = action
                
                var chosenDate = Date()
                
                if(startSelected){
                    chosenDate = selectedStartDate
                }
                if(endSelected)
                {
                    chosenDate = selectedEndDate
                }
                
                dateFormatter.dateFormat = "dd/MM/yyyy"
                vc.Date = dateFormatter.string(from: chosenDate) as String
                
                dateFormatter.dateFormat = "hh:mm:ss"
                vc.Time = dateFormatter.string(from: chosenDate) as String
                
                vc.DateAsObject = chosenDate
                
                
                
            }
        }
        
       
        
        
        
        
        
        
        
    }
    
    func addNewButtonStartClicked(sender: UITapGestureRecognizer) {
     
         selectedStartDate = lastSelectedDate
        
        startSelected = true
        endSelected = false
        
        creatingNew = true
        
        //Go to time stamps editor
        
        if(selectCalendarPurpose == .RegistrationHours)
        {
           self.performSegue(withIdentifier: "GoToRegistrationHoursEditor", sender: nil)
            
        }
        else if(selectCalendarPurpose == .TimeStamps)
        {
            self.performSegue(withIdentifier: "GoTotimeStampsEditor", sender: nil)
        }
        
    }
    
    func addNewButtonEndClicked(sender: UITapGestureRecognizer) {
        
        selectedEndDate = lastSelectedDate
        
        startSelected = false
        endSelected = true
        
        creatingNew = true
        
        if(selectCalendarPurpose == .RegistrationHours)
        {
            self.performSegue(withIdentifier: "GoToRegistrationHoursEditor", sender: nil)
        }
        else if(selectCalendarPurpose == .TimeStamps)
        {
            self.performSegue(withIdentifier: "GoTotimeStampsEditor", sender: nil)
        }
        
    }
    
    func startTimeClicked(sender: UITapGestureRecognizer) {
        
        guard ((sender.view as? UILabel)?.text) != nil else { return }
        
        startSelected = true
        endSelected = false
        
        //selectedStartDate = lastSelectedDate
        
        showActionSheet()

    }
    
    
    func endTimeClicked(sender: UITapGestureRecognizer) {
        
        guard ((sender.view as? UILabel)?.text) != nil else { return }
        
        startSelected = false
        endSelected = true
        
        //selectedEndDate = lastSelectedDate
        
        showActionSheet()
        
    }
    
    func homeButtonClicked(sender: UITapGestureRecognizer) {
      
    }
    
    
    func showActionSheet()
    {
        // 1
        let optionMenu = UIAlertController(title: nil, message: "What would you like to do?", preferredStyle: .actionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            
            if(self.selectCalendarPurpose == .RegistrationHours)
            {
                 self.showSpinner()
                
                RegistrationHoursRequests.sharedInstance.DeleteRegisteredHours(personId: self.childId, dateToDelete: self.lastSelectedDate as NSDate, onCompletion: { (JSON) in
                    
                     self.hideSpinner()
                    
                    self.calendarView.selectDates([self.lastSelectedDate])
                    
                })

            }
            else if(self.selectCalendarPurpose == .TimeStamps)
            {
                var targetTimeStampsLogId = ""
                
                if(self.startSelected){
                    targetTimeStampsLogId = self.selectedPersonLogStartId;
                }
                else if(self.endSelected)
                {
                    targetTimeStampsLogId = self.selectedPersonLogEndId;
                }
                
                self.showSpinner()
                
                PersonLogRequests.sharedInstance.DeletePersonLog(logId: targetTimeStampsLogId, onCompletion:
                {_ in 
                self.hideSpinner()
                     self.calendarView.selectDates([self.lastSelectedDate])
                    
                }
                )
            }
            
            
        })
        let saveAction = UIAlertAction(title: "Edit", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
           self.performSegue(withIdentifier: self.editSegueIdentifier, sender: nil)
            
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        
        // 4
        optionMenu.addAction(saveAction)
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
       
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
        
        if(self.startSelected){
            optionMenu.popoverPresentationController?.sourceView = self.addNewButtonStart
        }
        else if(self.endSelected)
        {
            optionMenu.popoverPresentationController?.sourceView = self.addNewButtonEnd
        }
            
        }
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    func fetchTimeStamps()
    {
        var retrievedStartStamp = ""
        var retrievedEndStamp = ""
        
        self.childId = self.childId.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        PersonLogRequests.sharedInstance.GetLogins(personId: self.childId as String, targetDate: lastSelectedDate as NSDate, onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                let log = PersonLog()
                
                log.PersonId = JSON["PersonId"].stringValue as NSString
                log.Id = JSON["Id"].stringValue as NSString
                
                self.selectedPersonLogStartId = log.Id as String
                
                log.Action = JSON["Action"].stringValue as NSString
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
                
                let timeStamp = JSON["TimeStamp"].stringValue
                
                var newDate = dateFormatter.date(from: timeStamp)
                
                if(newDate == nil){
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    newDate = dateFormatter.date(from: timeStamp)
                    
                    if(newDate == nil){
                        continue
                    }
                }
                
                self.selectedStartDate = newDate!
                
                log.TimeStamp = newDate!
                
                dateFormatter.dateFormat = "HH:mm:ss"
                retrievedStartStamp = dateFormatter.string(from: log.TimeStamp) as String
                
            }
            
            DispatchQueue.main.async(execute: {
                
                self.startSpinner.stopAnimating()
                self.startTime.isHidden = false;
                
                self.startTime.text = retrievedStartStamp
                
                if(retrievedStartStamp == "")
                {
                    self.addNewButtonStart.isHidden = false
                }
                else
                {
                    self.addNewButtonStart.isHidden = true
                }
                
            })
            
        })
        
        PersonLogRequests.sharedInstance.GetLogouts(personId: self.childId as String, targetDate: lastSelectedDate as NSDate, onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                let log = PersonLog()
                
                log.PersonId = JSON["PersonId"].stringValue as NSString
                log.Id = JSON["Id"].stringValue as NSString
                
                self.selectedPersonLogEndId = log.Id as String
                
                log.Action = JSON["Action"].stringValue as NSString
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
                
                let timeStamp = JSON["TimeStamp"].stringValue
                
                print(timeStamp)
                
                var newDate = dateFormatter.date(from: timeStamp)
                
                if(newDate == nil){
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    newDate = dateFormatter.date(from: timeStamp)
                    
                    if(newDate == nil){
                        continue
                    }
                }
                
                self.selectedEndDate = newDate!
                
                log.TimeStamp = newDate!
                
                dateFormatter.dateFormat = "HH:mm:ss"
                retrievedEndStamp = dateFormatter.string(from: log.TimeStamp) as String
                
            }
            
            DispatchQueue.main.async(execute: {
                
                self.endSpinner.stopAnimating()
                self.endTime.isHidden = false;
                
                self.endTime.text = retrievedEndStamp
                
                if(retrievedEndStamp == "")
                {
                    self.addNewButtonEnd.isHidden = false
                }
                else
                {
                    self.addNewButtonEnd.isHidden = true
                }
                
            })
            
        })
    }
    
    
    func fetchRegisteredHours()
    {
        var retrievedStartStamp = ""
        var retrievedEndStamp = ""
        
        self.childId = self.childId.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        RegistrationHoursRequests.sharedInstance.GetRegisterdHoursyDateAndID(personId: self.childId as String, DateTime: lastSelectedDate as NSDate, onCompletion: { JSON in
            
            var noStartFound = true
            var noEndFound = true;
            
                let regHours = RegistrationHours()
            
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
            
            self.selectedRegisteredHoursId = JSON["Id"].stringValue;
            
                //Start to stirng, then to date
                let StartTime = JSON["StartTime"].stringValue
                var newStartTime = dateFormatter.date(from: StartTime)
                if(newStartTime == nil){
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    newStartTime = dateFormatter.date(from: StartTime)
                    
                    if(newStartTime != nil){
                        self.selectedStartDate = newStartTime!
                        regHours.StartTime = newStartTime!
                        noStartFound = false
                    }
                }
                else
                {
                    if(newStartTime != nil){
                        self.selectedStartDate = newStartTime!
                        regHours.StartTime = newStartTime!
                        noStartFound = false
                    }
            }
            
                
                //End to stirng, then to date
                let endTime = JSON["FinishTime"].stringValue
                var newEndTime = dateFormatter.date(from: endTime)
                if(newEndTime == nil){
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    newEndTime = dateFormatter.date(from: endTime)
                    
                    if(newEndTime != nil){
                        self.selectedEndDate = newEndTime!
                        regHours.FinishTime = newEndTime!
                        noEndFound = false
                    }
                }
            
                else
                {
            
            
                    if(newEndTime != nil){
                        self.selectedEndDate = newEndTime!
                        regHours.FinishTime = newEndTime!
                        noEndFound = false
                    }
            
            
            }
            

                //Setting both
                dateFormatter.dateFormat = "HH:mm:ss"
            
              if(noStartFound == false){
                retrievedStartStamp = dateFormatter.string(from: regHours.StartTime) as String
            }
            else
            {
            retrievedStartStamp = ""
            }
            
            if(noEndFound == false){
                retrievedEndStamp = dateFormatter.string(from: regHours.FinishTime) as String
            }
            else
            {
                retrievedEndStamp = ""
            }
            
            DispatchQueue.main.async(execute: {
                
                self.startSpinner.stopAnimating()
                self.startTime.isHidden = false;

                self.endSpinner.stopAnimating()
                self.endTime.isHidden = false;
                
                self.startTime.text = retrievedStartStamp
                self.endTime.text = retrievedEndStamp
                
                if(retrievedStartStamp == "")
                {
                    self.addNewButtonStart.isHidden = false
                }
                else
                {
                    self.addNewButtonStart.isHidden = true
                }
                
                if(retrievedEndStamp == "")
                {
                    self.addNewButtonEnd.isHidden = false
                }
                else
                {
                    self.addNewButtonEnd.isHidden = true
                }
                
            })
            
        })
       
    }
    
 
    @IBAction func PersonTapped(_ sender: Any) {
       
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func NavBarMenuTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
        
    }
}

extension RegisterdHoursTimeStampsCalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy dd MM"
        
        //let startDate = formatter.date(from: "2016 02 01")! // You can use date generated from a formatter
        
        var startDate = Date() // You can use date generated from a formatter
        var endDate = Date()
        
        startDate = startDate.addingTimeInterval(-(60*60*24*365))
        endDate = endDate.addingTimeInterval(60*60*24*365)
        
        //let endDate = formatter.date(from: "2020 02 01")!                              // You can also use dates created from this function
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
            calendar: Calendar.current,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfGrid,
            firstDayOfWeek: .monday)
        return parameters
    }
    
}


