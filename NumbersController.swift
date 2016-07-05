//
//  NumbersController.swift
//  BrightStart
//
//  Created by dev on 16/04/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class NumbersController: UIViewController {
    
    var _ChildrenRegisterdHoursCounts:[RegisteredCount] = [RegisteredCount]()
     var _StaffRegisterdHoursCounts:[RegisteredCount] = [RegisteredCount]()
    
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
    
    @IBAction func SliderValueChanged(sender: AnyObject) {
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        RestApiManager.sharedInstance.SelectChildrenCountsForTargetDate(NSDate(), onCompletion: { json in
            
            let signedInChildren = json["CurrentlySignedInCount"].stringValue
            
            let yetToArriveChildren = json["YetToAriveCount"].stringValue;
            
            let totalExpectedchildren = json["TotalExpectedInCount"].stringValue;
           
            dispatch_async(dispatch_get_main_queue(),{
                
                self.signedInChildren.text = signedInChildren
                
                self.yetToArriveChildren.text = yetToArriveChildren
                
                self.totalExpectedchildren.text = totalExpectedchildren
                
            })
            
        })
        
        
        RestApiManager.sharedInstance.SelectStaffCountsForTargetDate(NSDate(), onCompletion: { json in
            
            let signedInStaff = json["CurrentlySignedInCount"].stringValue
           
            let yetToArriveStaff = json["YetToAriveCount"].stringValue;
            
            let totalExpectedStaff = json["TotalExpectedInCount"].stringValue;
            
            dispatch_async(dispatch_get_main_queue(),{
               
                self.signedInStaff.text = signedInStaff
               
                self.yetToArriveStaff.text = yetToArriveStaff
                
                self.totalExpectedStaff.text = totalExpectedStaff
                
            })
            
        })

        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        RestApiManager.sharedInstance.GetNumberOfChildrenWithRegisteredHoursForEntireDay(String(components.year), month: String(components.month), day: String(components.day), onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {

                let signedInChildren = Int(JSON["NumberOfPersonWithRegisteredHours"].stringValue)
                let targetDate = JSON["TargetDate"].stringValue
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                
                let curDate = dateFormatter.dateFromString(targetDate)
                
                let regCount:RegisteredCount = RegisteredCount(numberOfChildrenWithRegisteredHours: signedInChildren!, targetDate: curDate!)
            
                self._ChildrenRegisterdHoursCounts.append(regCount)
               
            }

            
            dispatch_async(dispatch_get_main_queue(),{
                
                
                
            })
            
        })
        
        RestApiManager.sharedInstance.GetNumberOfStaffWithRegisteredHoursForEntireDay(String(components.year), month: String(components.month), day: String(components.day), onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                let signedInStaff = Int(JSON["NumberOfPersonWithRegisteredHours"].stringValue)
                let targetDate = JSON["TargetDate"].stringValue
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                
                let curDate = dateFormatter.dateFromString(targetDate)
                
                let regCount:RegisteredCount = RegisteredCount(numberOfChildrenWithRegisteredHours: signedInStaff!, targetDate: curDate!)
                
                self._StaffRegisterdHoursCounts.append(regCount)
            }
            
            dispatch_async(dispatch_get_main_queue(),{
                
                
            })
            
        })

        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
