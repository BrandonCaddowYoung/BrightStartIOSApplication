//
//  NumbersController.swift
//  BrightStart
//
//  Created by dev on 16/04/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class NumbersController: UIViewController {
    
     var _ApplicatoinColours: ApplicatoinColours!
    
    var _ChildrenRegisterdHoursCounts:[RegisteredCount] = [RegisteredCount]()
    var _StaffRegisterdHoursCounts:[RegisteredCount] = [RegisteredCount]()
    
    @IBOutlet weak var LeftSubView: UIView!
    @IBOutlet weak var RightSubView: UIView!
    
    @IBOutlet weak var topSubView: UIView!
    @IBOutlet weak var middleSubView: UIView!
    @IBOutlet weak var bottomSubView: UIView!
    
    @IBOutlet weak var signedInChildren: UILabel!
    @IBOutlet weak var signedInStaff: UILabel!
    
    @IBOutlet weak var yetToArriveChildren: UILabel!
    @IBOutlet weak var yetToArriveStaff: UILabel!
    
    @IBOutlet weak var totalExpectedchildren: UILabel!
    @IBOutlet weak var totalExpectedStaff: UILabel!
    
    @IBOutlet weak var sliderTimeLabel: UILabel!
    @IBOutlet weak var numbersSlider: UISlider!
    
    @IBOutlet weak var numberOfChilrenAtGivenTime: UILabel!
    @IBOutlet weak var numberOfStaffAtGivenTime: UILabel!
    
    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var currentStatusLabel: UILabel!
    @IBOutlet weak var signedInLabel: UILabel!
    @IBOutlet weak var yetToArriveLabel: UILabel!
    @IBOutlet weak var totalExpectedInLabel: UILabel!
    
    
    @IBOutlet weak var bottomSubViewHeading: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var childrenLabel: UILabel!
    @IBOutlet weak var staffLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    /*!
     @brief Deals with collecting the appropriate infomration when the user changes the time on the slider.
     */
    @IBAction func SliderValueChanged(_ sender: AnyObject) {
        
        var currentValue = Int(numbersSlider.value)
        
        if(!self._ChildrenRegisterdHoursCounts.indices.contains(Int(currentValue - 1)) == true)
        {
            //Means the API probably hasnt returned anything yet
            return
        }
        
        if(!self._StaffRegisterdHoursCounts.indices.contains(Int(currentValue - 1)) == true)
        {
             //Means the API probably hasnt returned anything yet
            return
        }
        
        let childrenWithRegisteredhoursCount = self._ChildrenRegisterdHoursCounts[Int(currentValue - 1)]
        let staffWithRegisteredhoursCount = self._StaffRegisterdHoursCounts[Int(currentValue - 1)]
       
        var amOrPm = "AM"
        if(currentValue > 12)
        {
        currentValue = currentValue - 12
            amOrPm = "PM"
        }
        
        sliderTimeLabel.text = "\(currentValue):00 " + amOrPm
        
        numberOfChilrenAtGivenTime.text = "\(childrenWithRegisteredhoursCount.NumberOfPersonWithRegisteredHours)"
        numberOfStaffAtGivenTime.text = "\(staffWithRegisteredhoursCount.NumberOfPersonWithRegisteredHours)"
    }
    
    /*!
     @brief Sets up all constraints for the view.
     */
    func setupConstraints() {
        
        //Positioning the left subview
        
        LeftSubView.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        LeftSubView.leadingAnchor.constraint(
            equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        //bottom
        LeftSubView.bottomAnchor.constraint(
            equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        //top
        LeftSubView.topAnchor.constraint(
            equalTo: view.layoutMarginsGuide.topAnchor).isActive = true

        //width
        LeftSubView.widthAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.10).isActive = true
        
        
        
        //Positioning the right subview
        
        RightSubView.translatesAutoresizingMaskIntoConstraints = false
        
        //right
        RightSubView.trailingAnchor.constraint(
            equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        //bottom
        RightSubView.bottomAnchor.constraint(
            equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        //top
        RightSubView.topAnchor.constraint(
            equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        
        //width
        RightSubView.widthAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.10).isActive = true
        
        
        //Positioning the bottom subview
        
        bottomSubView.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        bottomSubView.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        //right
        bottomSubView.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        //bottom
        bottomSubView.bottomAnchor.constraint(
            equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        //height
        bottomSubView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.40).isActive = true
        
        
        //Positioning the top subview
        
        topSubView.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        topSubView.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        //right
        topSubView.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        
        //top
        topSubView.topAnchor.constraint(
            equalTo: view.topAnchor).isActive = true
       
        //height
        topSubView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.20).isActive = true
        
        //Positioning the middle subview
        
        middleSubView.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        middleSubView.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        //right
        middleSubView.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        
        //top
        middleSubView.topAnchor.constraint(
            equalTo: topSubView.bottomAnchor).isActive = true
        
        //bottom
        middleSubView.bottomAnchor.constraint(
            equalTo: bottomSubView.topAnchor).isActive = true
        
        
        //Positioning the heading label wihtin the top subview
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headingLabel.sizeToFit()
        
        headingLabel.centerXAnchor.constraint(
            equalTo: topSubView.centerXAnchor).isActive = true
        
        headingLabel.centerYAnchor.constraint(
            equalTo: topSubView.centerYAnchor).isActive = true
        
        
        //Positioning middle sub view content
        
        //Positioning the Current Status Label
        currentStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        signedInLabel.translatesAutoresizingMaskIntoConstraints = false
        yetToArriveLabel.translatesAutoresizingMaskIntoConstraints = false
        totalExpectedInLabel.translatesAutoresizingMaskIntoConstraints = false
        
        currentStatusLabel.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        currentStatusLabel.topAnchor.constraint(
            equalTo: middleSubView.topAnchor).isActive = true
        
        signedInLabel.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        signedInLabel.topAnchor.constraint(
            equalTo: currentStatusLabel.bottomAnchor).isActive = true
        
        yetToArriveLabel.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        yetToArriveLabel.topAnchor.constraint(
            equalTo: signedInLabel.bottomAnchor).isActive = true
        
        totalExpectedInLabel.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        totalExpectedInLabel.topAnchor.constraint(
            equalTo: yetToArriveLabel.bottomAnchor).isActive = true
        
        
        
        
        
        
        
        
        
        
        
        
        signedInStaff.translatesAutoresizingMaskIntoConstraints = false
        yetToArriveStaff.translatesAutoresizingMaskIntoConstraints = false
        totalExpectedStaff.translatesAutoresizingMaskIntoConstraints = false
        
        signedInStaff.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        
        signedInStaff.centerYAnchor.constraint(
            equalTo: signedInLabel.centerYAnchor).isActive = true
        
        yetToArriveStaff.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        
        yetToArriveStaff.centerYAnchor.constraint(
            equalTo: yetToArriveLabel.centerYAnchor).isActive = true
        
        totalExpectedStaff.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        
        totalExpectedStaff.centerYAnchor.constraint(
            equalTo: totalExpectedInLabel.centerYAnchor).isActive = true
        
        
        
        signedInChildren.translatesAutoresizingMaskIntoConstraints = false
        yetToArriveChildren.translatesAutoresizingMaskIntoConstraints = false
        totalExpectedchildren.translatesAutoresizingMaskIntoConstraints = false
        
        signedInChildren.trailingAnchor.constraint(
            equalTo: signedInStaff.leadingAnchor).isActive = true
        
        signedInChildren.centerYAnchor.constraint(
            equalTo: signedInLabel.centerYAnchor).isActive = true
        
        yetToArriveChildren.trailingAnchor.constraint(
            equalTo: yetToArriveStaff.leadingAnchor).isActive = true
        
        yetToArriveChildren.centerYAnchor.constraint(
            equalTo: yetToArriveLabel.centerYAnchor).isActive = true
        
        totalExpectedchildren.trailingAnchor.constraint(
            equalTo: totalExpectedStaff.leadingAnchor).isActive = true
        
        totalExpectedchildren.centerYAnchor.constraint(
            equalTo: totalExpectedInLabel.centerYAnchor).isActive = true
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //Positioning the bottom subview content
        
        sliderTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfChilrenAtGivenTime.translatesAutoresizingMaskIntoConstraints = false
        numberOfStaffAtGivenTime.translatesAutoresizingMaskIntoConstraints = false
        
        sliderTimeLabel.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        
        sliderTimeLabel.centerYAnchor.constraint(
            equalTo: timeLabel.centerYAnchor).isActive = true
        
        numberOfChilrenAtGivenTime.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        
        numberOfChilrenAtGivenTime.centerYAnchor.constraint(
            equalTo: childrenLabel.centerYAnchor).isActive = true
        
        numberOfStaffAtGivenTime.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        
        numberOfStaffAtGivenTime.centerYAnchor.constraint(
            equalTo: staffLabel.centerYAnchor).isActive = true
        
        
        
        //Positioning bottom sub view content
        
        //Positioning the Current Status Label
        bottomSubViewHeading.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        childrenLabel.translatesAutoresizingMaskIntoConstraints = false
        staffLabel.translatesAutoresizingMaskIntoConstraints = false
         slider.translatesAutoresizingMaskIntoConstraints = false
        
        bottomSubViewHeading.leadingAnchor  .constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        bottomSubViewHeading.topAnchor.constraint(
            equalTo: bottomSubView.topAnchor).isActive = true
        
        timeLabel.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        timeLabel.topAnchor.constraint(
            equalTo: bottomSubViewHeading.bottomAnchor).isActive = true
        
        childrenLabel.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        childrenLabel.topAnchor.constraint(
            equalTo: timeLabel.bottomAnchor).isActive = true
        
        staffLabel.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        staffLabel.topAnchor.constraint(
            equalTo: childrenLabel.bottomAnchor).isActive = true
        
        
        slider.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        slider.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        
        slider.bottomAnchor.constraint(
            equalTo: bottomSubView.bottomAnchor).isActive = true
        
        
        headingLabel.sizeToFit()
        currentStatusLabel.sizeToFit()
         bottomSubViewHeading.sizeToFit()
        
        topSubView.backgroundColor = _ApplicatoinColours.BackGroundColour
         middleSubView.backgroundColor = _ApplicatoinColours.BackGroundColour
         bottomSubView.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        LeftSubView.backgroundColor = _ApplicatoinColours.BackGroundColour
        RightSubView.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ApplicatoinColours = ApplicatoinColours()
        
        setupConstraints()
        
        CommonRequests.sharedInstance.SelectChildrenCountsForTargetDate(targetDate: Date() as NSDate, onCompletion: { json in
            
            let signedInChildren = json["CurrentlySignedInCount"].stringValue
            
            let yetToArriveChildren = json["YetToAriveCount"].stringValue;
            
            let totalExpectedchildren = json["TotalExpectedInCount"].stringValue;
           
            DispatchQueue.main.async(execute: {
                
                self.signedInChildren.text = signedInChildren
                
                self.yetToArriveChildren.text = yetToArriveChildren
                
                self.totalExpectedchildren.text = totalExpectedchildren
                
            })
            
        })
        
   
        
        
        CommonRequests.sharedInstance.SelectStaffCountsForTargetDate(targetDate: Date() as NSDate, onCompletion: { json in
            
            let signedInStaff = json["CurrentlySignedInCount"].stringValue
           
            let yetToArriveStaff = json["YetToAriveCount"].stringValue;
            
            let totalExpectedStaff = json["TotalExpectedInCount"].stringValue;
            
            DispatchQueue.main.async(execute: {
               
                self.signedInStaff.text = signedInStaff
               
                self.yetToArriveStaff.text = yetToArriveStaff
                
                self.totalExpectedStaff.text = totalExpectedStaff
                
            })
            
        })

        
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        
        CommonRequests.sharedInstance.GetNumberOfChildrenWithRegisteredHoursForEntireDay(year: String(describing: components.year), month: String(describing: components.month), day: String(describing: components.day), onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {

                var signedInChildren = Int(JSON["NumberOfPersonWithRegisteredHours"].stringValue)
                
                if(signedInChildren == nil){
                 signedInChildren = 0
                }
                
                let targetDate = JSON["TargetDate"].stringValue
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                
                var curDate = dateFormatter.date(from: targetDate)
                
                if(curDate == nil){
                    curDate = Date()
                }
                
                let regCount:RegisteredCount = RegisteredCount(numberOfChildrenWithRegisteredHours: signedInChildren!, targetDate: curDate!)
            
                self._ChildrenRegisterdHoursCounts.append(regCount)
               
            }

            
            DispatchQueue.main.async(execute: {
                
                
                
            })
            
        })
        
        CommonRequests.sharedInstance.GetNumberOfStaffWithRegisteredHoursForEntireDay(year: String(describing: components.year), month: String(describing: components.month), day: String(describing: components.day), onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                var signedInStaff = Int(JSON["NumberOfPersonWithRegisteredHours"].stringValue)
                let targetDate = JSON["TargetDate"].stringValue
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                
                var curDate = dateFormatter.date(from: targetDate)
                
                
                
                if(signedInStaff == nil){
                    signedInStaff = 0
                }
               
                if(curDate == nil){
                    curDate = Date()
                }

                
                
                
                let regCount:RegisteredCount = RegisteredCount(numberOfChildrenWithRegisteredHours: signedInStaff!, targetDate: curDate!)
                
                self._StaffRegisterdHoursCounts.append(regCount)
            }
            
            DispatchQueue.main.async(execute: {
                
                
            })
            
        })

        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
