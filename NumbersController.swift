//
//  NumbersController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit

class NumbersController: UIViewController {
    
     var _ApplicatoinColours: ApplicatoinColours!
    
    var _ChildrenRegisterdHoursCounts:[RegisteredCount] = [RegisteredCount]()
    var _StaffRegisterdHoursCounts:[RegisteredCount] = [RegisteredCount]()
    
    
    //These are all the containers!
    @IBOutlet weak var TopLeftView: UIView!
    @IBOutlet weak var TopLeftSpinner: UIActivityIndicatorView!
    @IBOutlet weak var YetToArriveLabel: UILabel!
    
    @IBOutlet weak var TopRightView: UIView!
    @IBOutlet weak var TopRightSpinner: UIActivityIndicatorView!
    @IBOutlet weak var SignedInLabel: UILabel!
    
    @IBOutlet weak var MiddleLeftView: UIView!
    @IBOutlet weak var MiddleLeftSpinner: UIActivityIndicatorView!
    @IBOutlet weak var TotalLabel: UILabel!
    
    
    @IBOutlet weak var MiddleRightView: UIView!
    @IBOutlet weak var MiddleRightSpinner: UIActivityIndicatorView!
    @IBOutlet weak var GoneHomeLabel: UILabel!
    
    @IBOutlet weak var MiddleView: UIView!
    
    @IBOutlet weak var BottomLeftView: UIView!
    @IBOutlet weak var BottomLeftSpinner: UIActivityIndicatorView!
    @IBOutlet weak var ChilrenLabel: UILabel!
    
    @IBOutlet weak var BottomRightView: UIView!
    @IBOutlet weak var BottomRightSpinner: UIActivityIndicatorView!
    @IBOutlet weak var StaffLabel: UILabel!
    
    @IBOutlet weak var BottomView: UIView!
    
    @IBOutlet weak var LeftSubView: UIView!
    @IBOutlet weak var RightSubView: UIView!
    
    //There are all the elements that go within the containers!
    
    //Top left
    @IBOutlet weak var yetToArriveChildren: UILabel!
    @IBOutlet weak var yetToArriveStaff: UILabel!
    
    //Top Right
    @IBOutlet weak var signedInChildren: UILabel!
    @IBOutlet weak var signedInStaff: UILabel!
    
    //Middle left
    @IBOutlet weak var totalExpectedchildren: UILabel!
    @IBOutlet weak var totalExpectedStaff: UILabel!
    
    //Middle
    @IBOutlet weak var sliderTimeLabel: UILabel!
    @IBOutlet weak var Switch: UISwitch!
    
    //Bototm left
    @IBOutlet weak var numberOfChilrenAtGivenTime: UILabel!
    
    //Bottom Right
    @IBOutlet weak var numberOfStaffAtGivenTime: UILabel!
   
    //Bottom
    @IBOutlet weak var numbersSlider: UISlider!
    
    //Spinner
    @IBOutlet weak var forecastSpinner: UIActivityIndicatorView!
    
    
    @IBAction func SwitchSwitched(_ sender: Any) {
        
        if(Switch.isOn)
        {
        //Show children counts
            
           signedInChildren.text = signedInChildrenCount
            yetToArriveChildren.text =  yetToArriveChildrenCount
            totalExpectedchildren.text =  totalExpectedChildrenCount
            
        }
        else
        {
        //Show staff counts
            
            signedInChildren.text = signedInStaffCount
            yetToArriveChildren.text = yetToArriveStaffCount
            totalExpectedchildren.text = totalExpectedStaffCount
            
        }
        
    }
    
    
    @IBAction func SliderChanged(_ sender: Any) {
        
        let currentValueAs24Hour = Int(numbersSlider.value)
        
        var currentValue = currentValueAs24Hour
        
        var amOrPm = "AM"
        if(currentValue > 12)
        {
            currentValue = currentValue - 12
            amOrPm = "PM"
        }
        
        sliderTimeLabel.text = "\(currentValue):00 " + amOrPm
        
        if(!self._ChildrenRegisterdHoursCounts.indices.contains(Int(currentValueAs24Hour - 1)) == true)
        {
            //Means the API probably hasnt returned anything yet
            return
        }
        
        if(!self._StaffRegisterdHoursCounts.indices.contains(Int(currentValueAs24Hour - 1)) == true)
        {
            //Means the API probably hasnt returned anything yet
            return
        }
        
        let childrenWithRegisteredhoursCount = self._ChildrenRegisterdHoursCounts[Int(currentValueAs24Hour - 1)]
        let staffWithRegisteredhoursCount = self._StaffRegisterdHoursCounts[Int(currentValueAs24Hour - 1)]
        
        numberOfChilrenAtGivenTime.text = "\(childrenWithRegisteredhoursCount.NumberOfPersonWithRegisteredHours)"
        numberOfStaffAtGivenTime.text = "\(staffWithRegisteredhoursCount.NumberOfPersonWithRegisteredHours)"
        
    }
    
    
    
        /*!
     @brief Deals with collecting the appropriate infomration when the user changes the time on the slider.
     */
    @IBAction func SliderValueChanged(_ sender: AnyObject) {
        
      
    }
    
    /*!
     @brief Sets up all constraints for the view.
     */
    func setupConstraints() {
        
        //Positioning the left subview
        
        YetToArriveLabel.translatesAutoresizingMaskIntoConstraints = false
        SignedInLabel.translatesAutoresizingMaskIntoConstraints = false
        
        TotalLabel.translatesAutoresizingMaskIntoConstraints = false
        GoneHomeLabel.translatesAutoresizingMaskIntoConstraints = false
        ChilrenLabel.translatesAutoresizingMaskIntoConstraints = false
        StaffLabel.translatesAutoresizingMaskIntoConstraints = false
        
        TopLeftSpinner.translatesAutoresizingMaskIntoConstraints = false
        TopRightSpinner.translatesAutoresizingMaskIntoConstraints = false
        
        MiddleLeftSpinner.translatesAutoresizingMaskIntoConstraints = false
        MiddleRightSpinner.translatesAutoresizingMaskIntoConstraints = false
        
        TopLeftSpinner.isHidden = true
        TopRightSpinner.isHidden = true
        
        MiddleLeftSpinner.isHidden = true
        MiddleRightSpinner.isHidden = true
        
        BottomLeftSpinner.translatesAutoresizingMaskIntoConstraints = false
        BottomRightSpinner.translatesAutoresizingMaskIntoConstraints = false
        
        TopLeftView.translatesAutoresizingMaskIntoConstraints = false
        TopRightView.translatesAutoresizingMaskIntoConstraints = false
        MiddleLeftView.translatesAutoresizingMaskIntoConstraints = false
       MiddleRightView.translatesAutoresizingMaskIntoConstraints = false
        MiddleView.translatesAutoresizingMaskIntoConstraints = false
        BottomLeftView.translatesAutoresizingMaskIntoConstraints = false
        BottomRightView.translatesAutoresizingMaskIntoConstraints = false
        BottomView.translatesAutoresizingMaskIntoConstraints = false
        RightSubView.translatesAutoresizingMaskIntoConstraints = false
        LeftSubView.translatesAutoresizingMaskIntoConstraints = false
        yetToArriveChildren.translatesAutoresizingMaskIntoConstraints = false
        yetToArriveStaff.translatesAutoresizingMaskIntoConstraints = false
        signedInChildren.translatesAutoresizingMaskIntoConstraints = false
        signedInStaff.translatesAutoresizingMaskIntoConstraints = false
        totalExpectedchildren.translatesAutoresizingMaskIntoConstraints = false
        totalExpectedStaff.translatesAutoresizingMaskIntoConstraints = false
        sliderTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        Switch.translatesAutoresizingMaskIntoConstraints = false
        numberOfChilrenAtGivenTime.translatesAutoresizingMaskIntoConstraints = false
        numberOfStaffAtGivenTime.translatesAutoresizingMaskIntoConstraints = false
        numbersSlider.translatesAutoresizingMaskIntoConstraints = false
        forecastSpinner.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        LeftSubView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        //bottom
        LeftSubView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        //top
        LeftSubView.topAnchor.constraint(
            equalTo: view.topAnchor).isActive = true

        //width
        LeftSubView.widthAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.05).isActive = true
        
        //LeftSubView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        LeftSubView.backgroundColor = _ApplicatoinColours.BackGroundColour
        

        
        //Positioning the right subview
       
        //right
        RightSubView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        //bottom
        RightSubView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        //top
        RightSubView.topAnchor.constraint(
            equalTo: view.topAnchor).isActive = true
        
        //width
        RightSubView.widthAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.05).isActive = true
        
       // RightSubView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

        RightSubView.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        
        
        
        
        
        
        //Positioning the top left subview
        
        //left
        TopLeftView.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        //top
        TopLeftView.topAnchor.constraint(
            equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
        //width
        TopLeftView.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.40).isActive = true
        
        //height
        TopLeftView.heightAnchor.constraint(
            equalTo: (view.readableContentGuide.heightAnchor),
            multiplier: 0.23).isActive = true
        
        //TopLeftView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        TopLeftView.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        
        //Positioning label within top left view
        
        yetToArriveChildren.centerXAnchor.constraint(
            equalTo: TopLeftView.centerXAnchor
            ).isActive = true
        
        yetToArriveChildren.centerYAnchor.constraint(
            equalTo: TopLeftView.centerYAnchor
            ).isActive = true
        
        
        yetToArriveChildren.textColor = _ApplicatoinColours.FontColour
        
        
        
        //right
        TopLeftSpinner.trailingAnchor.constraint(
            equalTo: TopLeftView.trailingAnchor).isActive = true
        
        //top
        TopLeftSpinner.topAnchor.constraint(
            equalTo: TopLeftView.topAnchor).isActive = true

        //Positioning top left label
        
        //left
        YetToArriveLabel.centerXAnchor.constraint(
            equalTo: TopLeftView.centerXAnchor).isActive = true
        
        YetToArriveLabel.centerYAnchor.constraint(
            equalTo: TopLeftSpinner.centerYAnchor
            ).isActive = true
        
        YetToArriveLabel.textColor = _ApplicatoinColours.LabelColour
        
        //Positioning the top right subview
        
        //right
        TopRightView.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        
        //top
        TopRightView.topAnchor.constraint(
            equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
        //width
        TopRightView.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.40).isActive = true
        
        //height
        TopRightView.heightAnchor.constraint(
            equalTo: view.readableContentGuide.heightAnchor,
            multiplier: 0.23).isActive = true
        
       // TopRightView.backgroundColor =  #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        TopRightView.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        
        //Positioning label within top left view
        
       signedInChildren.centerXAnchor.constraint(
            equalTo: TopRightView.centerXAnchor
            ).isActive = true
        
        signedInChildren.centerYAnchor.constraint(
            equalTo: TopRightView.centerYAnchor
            ).isActive = true
        
        
           signedInChildren.textColor = _ApplicatoinColours.FontColour
        
        
        //right
        TopRightSpinner.trailingAnchor.constraint(
            equalTo: TopRightView.trailingAnchor).isActive = true
        
        //top
        TopRightSpinner.topAnchor.constraint(
            equalTo: TopRightView.topAnchor).isActive = true
        
        
        //left
        SignedInLabel.centerXAnchor.constraint(
            equalTo: TopRightView.centerXAnchor).isActive = true
        
        //top
        SignedInLabel.centerYAnchor.constraint(
            equalTo: TopRightSpinner.centerYAnchor).isActive = true

        SignedInLabel.textColor = _ApplicatoinColours.LabelColour
        
        
        //Positioning the middle left subview
        
        
        
        //left
        MiddleLeftView.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        //top
        MiddleLeftView.topAnchor.constraint(
            equalTo: TopLeftView.bottomAnchor).isActive = true
        
        //width
        MiddleLeftView.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.40).isActive = true
        
        //height
        MiddleLeftView.heightAnchor.constraint(
            equalTo: view.readableContentGuide.heightAnchor,
            multiplier: 0.23).isActive = true
        
       // MiddleLeftView.backgroundColor =  #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        MiddleLeftView.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        
        //Positioning label within top left view
        
        totalExpectedchildren.centerXAnchor.constraint(
            equalTo: MiddleLeftView.centerXAnchor
            ).isActive = true
        
        totalExpectedchildren.centerYAnchor.constraint(
            equalTo: MiddleLeftView.centerYAnchor
            ).isActive = true

        
         totalExpectedchildren.textColor = _ApplicatoinColours.FontColour
        
        //right
        MiddleLeftSpinner.trailingAnchor.constraint(
            equalTo: MiddleLeftView.trailingAnchor).isActive = true
        
        //top
        MiddleLeftSpinner.topAnchor.constraint(
            equalTo: MiddleLeftView.topAnchor).isActive = true
        
        
        
        //left
        TotalLabel.centerXAnchor.constraint(
            equalTo: MiddleLeftView.centerXAnchor).isActive = true
        
        //top
        TotalLabel.centerYAnchor.constraint(
            equalTo: MiddleLeftSpinner.centerYAnchor).isActive = true
        
        TotalLabel.textColor = _ApplicatoinColours.LabelColour
        
        
        
        
        
        
        
        
        
        //Positioning the middle right subview
       
        //right
        MiddleRightView.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        
        //top
        MiddleRightView.topAnchor.constraint(
            equalTo: TopRightView.bottomAnchor).isActive = true
        
        //width
        MiddleRightView.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.40).isActive = true
        
        //height
        MiddleRightView.heightAnchor.constraint(
            equalTo: view.readableContentGuide.heightAnchor,
            multiplier: 0.23).isActive = true
        
       // MiddleRightView.backgroundColor =  #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        MiddleRightView.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        //right
        MiddleRightSpinner.trailingAnchor.constraint(
            equalTo: MiddleRightView.trailingAnchor).isActive = true
        
        //top
        MiddleRightSpinner.topAnchor.constraint(
            equalTo: MiddleRightView.topAnchor).isActive = true
        
        //Positioning label within top left view
        
       // yetToArriveChildren.centerXAnchor.constraint(
         //   equalTo: TopLeftView.centerXAnchor
           // ).isActive = true
        
       // yetToArriveChildren.centerYAnchor.constraint(
         //   equalTo: TopLeftView.centerYAnchor
           // ).isActive = true

        
         yetToArriveChildren.textColor = _ApplicatoinColours.FontColour
        
        
        
        
        //Positioning the middle subview

        //right
        MiddleView.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        
        //left
        MiddleView.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        //top
        MiddleView.topAnchor.constraint(
            equalTo: MiddleRightView.bottomAnchor).isActive = true
       
        
        //height
        MiddleView.heightAnchor.constraint(
            equalTo: view.readableContentGuide.heightAnchor,
            multiplier: 0.11).isActive = true
        
       // MiddleView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        MiddleView.backgroundColor = _ApplicatoinColours.BackGroundColour
        

        
        
        
        //Positioning the time label
        
        sliderTimeLabel.centerYAnchor.constraint(
            equalTo: MiddleView.centerYAnchor
            ).isActive = true
        
        sliderTimeLabel.leadingAnchor.constraint(
            equalTo: MiddleView.leadingAnchor).isActive = true

        //Positioning the switch
       
        Switch.centerYAnchor.constraint(
            equalTo: MiddleView.centerYAnchor
            ).isActive = true
        
        Switch.trailingAnchor.constraint(
            equalTo: MiddleView.trailingAnchor).isActive = true
        
        //Positioning the bottom left subview
       
        //right
        BottomLeftView.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        //top
        BottomLeftView.topAnchor.constraint(
            equalTo: MiddleView.bottomAnchor).isActive = true
        
        //width
        BottomLeftView.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.40).isActive = true
        
        //height
        BottomLeftView.heightAnchor.constraint(
            equalTo: view.readableContentGuide.heightAnchor,
            multiplier: 0.23).isActive = true
        
        //BottomLeftView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        BottomLeftView.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        
        //right
        BottomLeftView.trailingAnchor.constraint(
            equalTo: BottomLeftView.trailingAnchor).isActive = true
        
        //top
        BottomLeftView.topAnchor.constraint(
            equalTo: BottomLeftView.topAnchor).isActive = true
        
        //Positioning label within top left view
        
        numberOfChilrenAtGivenTime.centerXAnchor.constraint(
            equalTo: BottomLeftView.centerXAnchor
            ).isActive = true
        
        numberOfChilrenAtGivenTime.centerYAnchor.constraint(
            equalTo: BottomLeftView.centerYAnchor
            ).isActive = true
        
        
        numberOfChilrenAtGivenTime.textColor = _ApplicatoinColours.FontColour
        
        
        //right
        BottomLeftSpinner.trailingAnchor.constraint(
            equalTo: BottomLeftView.trailingAnchor).isActive = true
        
        //top
        BottomLeftSpinner.topAnchor.constraint(
            equalTo: BottomLeftView.topAnchor).isActive = true
        
        
        
        //left
        ChilrenLabel.centerXAnchor.constraint(
            equalTo: BottomLeftView.centerXAnchor).isActive = true
        
        //top
        ChilrenLabel.centerYAnchor.constraint(
            equalTo: BottomLeftSpinner.centerYAnchor).isActive = true
        
        StaffLabel.textColor = _ApplicatoinColours.LabelColour
        
        TotalLabel.textColor = _ApplicatoinColours.LabelColour
        
        
        //Positioning the bottom right subview
        
       // BottomRightView.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        BottomRightView.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        
        //top
        BottomRightView.topAnchor.constraint(
            equalTo: MiddleView.bottomAnchor).isActive = true
        
        //width
        BottomRightView.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.40).isActive = true
        
        BottomRightView.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        //right
        BottomRightView.trailingAnchor.constraint(
            equalTo: BottomRightView.trailingAnchor).isActive = true
        
        //top
        BottomRightView.topAnchor.constraint(
            equalTo: BottomRightView.topAnchor).isActive = true
        
        //height
        BottomRightView.heightAnchor.constraint(
            equalTo: view.readableContentGuide.heightAnchor,
            multiplier: 0.23).isActive = true

        
        numberOfStaffAtGivenTime.centerXAnchor.constraint(
            equalTo: BottomRightView.centerXAnchor
            ).isActive = true
        
        numberOfStaffAtGivenTime.centerYAnchor.constraint(
            equalTo: BottomRightView.centerYAnchor
            ).isActive = true
        
        numberOfStaffAtGivenTime.textColor = _ApplicatoinColours.FontColour
        
        
        //right
        BottomRightSpinner.trailingAnchor.constraint(
            equalTo: BottomRightView.trailingAnchor).isActive = true
        
        //top
        BottomRightSpinner.topAnchor.constraint(
            equalTo: BottomRightView.topAnchor).isActive = true
        
        
        //left
        StaffLabel.centerXAnchor.constraint(
            equalTo: BottomRightView.centerXAnchor).isActive = true
        
        //top
        StaffLabel.centerYAnchor.constraint(
            equalTo: BottomRightSpinner.centerYAnchor).isActive = true
        
        StaffLabel.textColor = _ApplicatoinColours.LabelColour
        
        SignedInLabel.textColor = _ApplicatoinColours.LabelColour

        

        
        
        //Positioning the bottom subview
        
       // BottomView.translatesAutoresizingMaskIntoConstraints = false
        
        //right
        BottomView.trailingAnchor.constraint(
            equalTo: RightSubView.leadingAnchor).isActive = true
        
        //left
        BottomView.leadingAnchor.constraint(
            equalTo: LeftSubView.trailingAnchor).isActive = true
        
        //top
        BottomView.topAnchor.constraint(
            equalTo: BottomLeftView.bottomAnchor).isActive = true
        
        //height
        BottomView.heightAnchor.constraint(
            equalTo: view.readableContentGuide.heightAnchor,
            multiplier: 0.11).isActive = true

   //  BottomView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        BottomView.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        //left
        numbersSlider.leadingAnchor.constraint(
            equalTo: BottomView.leadingAnchor).isActive = true
        
        //right
        numbersSlider.trailingAnchor.constraint(
            equalTo: BottomView.trailingAnchor).isActive = true
        
        //top
        numbersSlider.topAnchor.constraint(
            equalTo: BottomView.topAnchor).isActive = true
        
        //bottom
        numbersSlider.bottomAnchor.constraint(
            equalTo: BottomView.bottomAnchor).isActive = true

view.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        
    }
    
    var signedInChildrenCount = "";
    var yetToArriveChildrenCount = "";
    var totalExpectedChildrenCount = "";
    
    var signedInStaffCount = "";
    var yetToArriveStaffCount = "";
    var totalExpectedStaffCount = "";

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ApplicatoinColours = ApplicatoinColours()
        
        setupConstraints()
        
        self.forecastSpinner.hidesWhenStopped = true;
        
        self.BottomLeftSpinner.hidesWhenStopped = true;
        self.BottomRightSpinner.hidesWhenStopped = true;
        
        self.forecastSpinner.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.gray;
        
        self.BottomLeftSpinner.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.gray;
        self.BottomRightSpinner.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.gray;
        
        self.forecastSpinner.startAnimating()
        
        self.BottomLeftSpinner.startAnimating()
        self.BottomRightSpinner.startAnimating()
        
        CommonRequests.sharedInstance.SelectChildrenCountsForTargetDate(targetDate: Date() as NSDate, onCompletion: { json in
            
            let signedInChildren = json["CurrentlySignedInCount"].stringValue
            
            let yetToArriveChildren = json["YetToAriveCount"].stringValue;
            
            let totalExpectedchildren = json["TotalExpectedInCount"].stringValue;
           
            
            DispatchQueue.main.async(execute: {
                
                self.signedInChildrenCount = signedInChildren;
                self.yetToArriveChildrenCount = yetToArriveChildren;
                self.totalExpectedChildrenCount = totalExpectedchildren;
                
                self.signedInChildren.text = signedInChildren
                
                self.yetToArriveChildren.text = yetToArriveChildren
                
                self.totalExpectedchildren.text = totalExpectedchildren
                
                var hour = Calendar.current.component(.hour, from: Date())
                
                self.numbersSlider.setValue(Float(hour), animated: true)
                
                var amOrPm = "AM"
                if(hour > 12)
                {
                    hour = hour - 12
                    amOrPm = "PM"
                }
                
                self.sliderTimeLabel.text = "\(hour):00 " + amOrPm
                
            })
            
        })
        
   
        
        
        CommonRequests.sharedInstance.SelectStaffCountsForTargetDate(targetDate: Date() as NSDate, onCompletion: { json in
            
            let signedInStaff = json["CurrentlySignedInCount"].stringValue
           
            let yetToArriveStaff = json["YetToAriveCount"].stringValue;
            
            let totalExpectedStaff = json["TotalExpectedInCount"].stringValue;
            
            DispatchQueue.main.async(execute: {
               
                self.signedInStaffCount = signedInStaff;
                self.yetToArriveStaffCount = yetToArriveStaff;
                self.totalExpectedStaffCount = totalExpectedStaff;
                
                self.signedInStaff.text = signedInStaff
               
                self.yetToArriveStaff.text = yetToArriveStaff
                
                self.totalExpectedStaff.text = totalExpectedStaff
                
            })
            
        })

        
        let date = Date()
        let calendar = Calendar.current
        _ = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        
        let year = String(Calendar.current.component(.year, from: Date()))
        let month = String(Calendar.current.component(.month, from: Date()))
        let day = String(Calendar.current.component(.day, from: Date()))
        
        CommonRequests.sharedInstance.GetNumberOfChildrenWithRegisteredHoursForEntireDay(year: year, month: month, day:day, onCompletion: { json in
            
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
               
                if(self._StaffRegisterdHoursCounts.count > 0)
                {
                    self.forecastSpinner.stopAnimating()
                    
                    self.BottomLeftSpinner.stopAnimating()
                    self.BottomRightSpinner.stopAnimating()

                    
                    self.showForeCastLabels()
                    
                }
                
            })
            
        })
        
        CommonRequests.sharedInstance.GetNumberOfStaffWithRegisteredHoursForEntireDay(year: year, month: month, day: day, onCompletion: { json in
            
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
                
                if(self._ChildrenRegisterdHoursCounts.count > 0)
                {
                    self.BottomLeftSpinner.stopAnimating()
                    self.BottomRightSpinner.stopAnimating()
                    

                    
                 self.forecastSpinner.stopAnimating()
                    
                    self.showForeCastLabels()
                    
                }
                
            })
            
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showForeCastLabels()
    {
    
        
        numberOfStaffAtGivenTime.isHidden = false
        numberOfChilrenAtGivenTime.isHidden = false
             sliderTimeLabel.isHidden = false
        
    }
    

}
