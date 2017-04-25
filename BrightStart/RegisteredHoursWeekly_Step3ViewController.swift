//
//  RegisteredHoursWeekly_Step2ViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 06/04/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class RegisteredHoursWeekly_Step3ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RegHoursWeeklyViewCellDelegate {
    
    var showNavigationBar = true
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    @IBOutlet weak var MainHeadingLabel: UILabel!
    
    @IBOutlet weak var SelectLabel: UILabel!
    
    @IBOutlet weak var Top: UIView!
    
    @IBOutlet weak var UpperHeading: UIView!
    
    @IBOutlet weak var UpperContent: UIView!
    
    @IBOutlet weak var Bottom: UIView!
    
    @IBOutlet weak var DaysOfTheWeekTable: UITableView!
    
    var defaultStartDate = Date()
    var defaultEndDate = Date()
    
    var daysOfTheWeekArray = Array<WeekDay>()
    var selectedDaysOfTheWeekArray = Array<WeekDay>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        self.hideKeyboardWhenTappedAround()
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        setupConstraints()
        
        self.DaysOfTheWeekTable.delegate = self
        self.DaysOfTheWeekTable.dataSource = self
        
        let monday = WeekDay()
        monday.DayName = "Monday"
        monday.DayNumber = 1
        
        self.daysOfTheWeekArray.append(monday)
        
        let tuesday = WeekDay()
        tuesday.DayName = "Tuesday"
        tuesday.DayNumber = 2
        
        self.daysOfTheWeekArray.append(tuesday)
        
        let wednesday = WeekDay()
        wednesday.DayName = "Wednesday"
        wednesday.DayNumber = 3
        
        self.daysOfTheWeekArray.append(wednesday)
        
        let thursday = WeekDay()
        thursday.DayName = "Thursday"
        thursday.DayNumber = 4
        
        self.daysOfTheWeekArray.append(thursday)
        
        let friday = WeekDay()
        friday.DayName = "Friday"
        friday.DayNumber = 5
        
        self.daysOfTheWeekArray.append(friday)
        
        let saturday = WeekDay()
        saturday.DayName = "Saturday"
        saturday.DayNumber = 6

        self.daysOfTheWeekArray.append(saturday)
        
        let sunday = WeekDay()
        sunday.DayName = "Sunday"
        sunday.DayNumber = 7
        
        self.daysOfTheWeekArray.append(sunday)
        
        Top.backgroundColor = _ApplicatoinColours.Blue
        
        UpperHeading.backgroundColor = _ApplicatoinColours.Blue
        
        UpperContent.backgroundColor = _ApplicatoinColours.White
        
        Bottom.backgroundColor = _ApplicatoinColours.Blue
        
        MainHeadingLabel.textColor = _ApplicatoinColours.Orange
         MainHeadingLabel.font = _ApplicatoinColours.XlargeFont
        
        SelectLabel.textColor = _ApplicatoinColours.White
        SelectLabel.font = _ApplicatoinColours.mediumFont
        
         defaultStartDate = Date().setTime(hour: 09, min: 00, sec: 00)!
         defaultEndDate = Date().setTime(hour: 18, min: 00, sec: 00)!
        
        daysOfTheWeekArray[0].StartTime = defaultStartDate as NSDate
        daysOfTheWeekArray[0].EndTime = defaultEndDate as NSDate
        
        daysOfTheWeekArray[1].StartTime = defaultStartDate as NSDate
        daysOfTheWeekArray[1].EndTime = defaultEndDate as NSDate
        
        daysOfTheWeekArray[2].StartTime = defaultStartDate as NSDate
        daysOfTheWeekArray[2].EndTime = defaultEndDate as NSDate
        
        daysOfTheWeekArray[3].StartTime = defaultStartDate as NSDate
        daysOfTheWeekArray[3].EndTime = defaultEndDate as NSDate
        
        daysOfTheWeekArray[4].StartTime = defaultStartDate as NSDate
        daysOfTheWeekArray[4].EndTime = defaultEndDate as NSDate
        
        daysOfTheWeekArray[5].StartTime = defaultStartDate as NSDate
        daysOfTheWeekArray[5].EndTime = defaultEndDate as NSDate
        
        daysOfTheWeekArray[6].StartTime = defaultStartDate as NSDate
        daysOfTheWeekArray[6].EndTime = defaultEndDate as NSDate
        
    }
    
    
    func setupConstraints() {
        
        //Top
        
        Top.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        Top.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        Top.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //top
        Top.topAnchor.constraint(
            equalTo: view.topAnchor).isActive = true
        
        //height
        Top.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        
        //Heading label
        
        MainHeadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        MainHeadingLabel.centerYAnchor.constraint(
            equalTo: Top.centerYAnchor).isActive = true
        
        //center
        MainHeadingLabel.trailingAnchor.constraint(
            equalTo: Top.trailingAnchor, constant: -15).isActive = true
        
        MainHeadingLabel.widthAnchor.constraint(
            equalTo: Top.widthAnchor, multiplier: 0.70).isActive = true
        
        MainHeadingLabel.textAlignment = .right
        
        MainHeadingLabel.adjustsFontSizeToFitWidth = true
        
        
        //Upper Heading
        
        UpperHeading.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        UpperHeading.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        UpperHeading.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //top
        UpperHeading.topAnchor.constraint(
            equalTo: Top.bottomAnchor).isActive = true
        
        //height
        UpperHeading.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        //Name Label
        
        SelectLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        SelectLabel.centerYAnchor.constraint(
            equalTo: UpperHeading.centerYAnchor).isActive = true
        
        //width
        SelectLabel.widthAnchor.constraint(
            equalTo: UpperHeading.widthAnchor).isActive = true
        
        //left
        SelectLabel.leadingAnchor.constraint(
            equalTo: UpperHeading.leadingAnchor, constant: 20 ).isActive = true
        
        
        //Bottom
        
        Bottom.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        Bottom.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        Bottom.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //bottom
        Bottom.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        
        //height
        Bottom.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        //Upper Content
        
        UpperContent.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        UpperHeading.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        UpperContent.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //top
        UpperContent.topAnchor.constraint(
            equalTo: UpperHeading.bottomAnchor).isActive = true
        
        //height
        UpperContent.bottomAnchor.constraint(
            equalTo: Bottom.topAnchor).isActive = true
        
        //Table
        
        DaysOfTheWeekTable.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        DaysOfTheWeekTable.centerXAnchor.constraint(
            equalTo: UpperContent.centerXAnchor).isActive = true
        
        //center
        DaysOfTheWeekTable.centerYAnchor.constraint(
            equalTo: UpperContent.centerYAnchor).isActive = true
        
        //width
        DaysOfTheWeekTable.widthAnchor.constraint(
            equalTo: UpperContent.widthAnchor, multiplier: 0.90).isActive = true
        
        //height
        DaysOfTheWeekTable.heightAnchor.constraint(
            equalTo: UpperContent.heightAnchor).isActive = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func tickClicked(sender: UIButton!)
    {
        let value = sender.tag;
        
        if(selectedDaysOfTheWeekArray.contains( where: { $0 === daysOfTheWeekArray[value] } )){
            
            let indexOfChild = selectedDaysOfTheWeekArray.index{$0 === daysOfTheWeekArray[value]}
            
            //remove
            selectedDaysOfTheWeekArray.remove(at: indexOfChild!)
        }
        else
        {
            //add
            selectedDaysOfTheWeekArray.append(daysOfTheWeekArray[value])
        }
        
        DaysOfTheWeekTable.reloadData()
        
    }
    
    /////NUMBER OF ROWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return daysOfTheWeekArray.count;
        
    }
    /////CELL FOR ROW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let contact = daysOfTheWeekArray[indexPath.row]
        
        let cell:RegisreredHoursDayOfWeekTableViewCell = DaysOfTheWeekTable.dequeueReusableCell(withIdentifier: "reuseCell") as! RegisreredHoursDayOfWeekTableViewCell
        
        cell.delegate = self
        
        var selectedChild = WeekDay()
        selectedChild = contact
        
        cell.DayOfWeekLabel?.text = contact.DayName
        
        cell.DayOfWeekLabel?.font = _ApplicatoinColours.largeFont
        cell.StartLabel?.font = _ApplicatoinColours.mediumFont
        cell.EndLabel?.font = _ApplicatoinColours.mediumFont
        
        cell.DayOfWeekLabel?.textColor = _ApplicatoinColours.Blue
        
        cell.tickButton.addTarget(self, action:#selector(CreateChild_Quick_3ViewController.tickClicked(sender:)), for: .touchUpInside)
        
        cell.tickButton.tag=indexPath.row
        
        if(selectedDaysOfTheWeekArray.contains( where: { $0 === contact } )){
            cell.tickButton.setBackgroundImage(UIImage(named:"Checked"), for: UIControlState.normal)
        }
        else
        {
            cell.tickButton.setBackgroundImage(UIImage(named:"Unchecked"), for: UIControlState.normal)
            
            cell.StartTimePicker.date = defaultStartDate
            cell.EndTimePicker.date = defaultEndDate
            
            daysOfTheWeekArray[indexPath.row].StartTime = defaultStartDate as NSDate
            daysOfTheWeekArray[indexPath.row].EndTime = defaultEndDate as NSDate
            
        }
        
        cell.tickButton.titleLabel?.text = ""
        
        return cell
    }
    /////HEIGHT FOR ROW
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) ->CGFloat
    {
        return 80.0
    }
    
    func updateStartDate(newDate: Date, dayOfWeek: Int){
        daysOfTheWeekArray[dayOfWeek-1].StartTime = newDate as NSDate
    }
    
    func updateEndDate(newDate: Date, dayOfWeek: Int)
    {
       daysOfTheWeekArray[dayOfWeek-1].EndTime = newDate as NSDate
    }
    
    
   
   
    
}



