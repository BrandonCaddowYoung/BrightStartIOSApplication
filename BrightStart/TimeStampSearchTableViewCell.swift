//
//  CustomTableViewCell.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import UIKit

class TimeStampSearchTableViewCell: UITableViewCell
{
    var child: Child? {
        didSet {
            updateUI()
        }
    }
    
    var _CommonHelper: CommonHelper!
    var _ApplicationColours: ApplicatoinColours!
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellImage2: UIImageView!
    @IBOutlet weak var childNameLabel: UILabel!
    @IBOutlet weak var cellDetailsText: UILabel!
    @IBOutlet weak var cellInformationText: UILabel!
    
    override func awakeFromNib() {
        
        _CommonHelper = CommonHelper()
        _ApplicationColours = ApplicatoinColours()
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        
        //Positioning the name label
        
        childNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        childNameLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        //Right is defined below, after the image is in place
        
        
        //top
        childNameLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        
        //Positioning image number 1(the right image)
        
        //Making sure the image doesnt lose its width to the name when it gets bigger.
        self.cellImage?.setContentCompressionResistancePriority(1000, for: UILayoutConstraintAxis.vertical);
        self.cellImage?.setContentCompressionResistancePriority(1000, for: UILayoutConstraintAxis.horizontal);
        
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        
        //right
        cellImage.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor).isActive = true
        
        cellImage.widthAnchor.constraint(
            equalToConstant: 50).isActive = true
        
        cellImage.heightAnchor.constraint(
            equalToConstant: 50).isActive = true
        
        //top
        cellImage.topAnchor.constraint(
            equalTo: contentView.topAnchor).isActive = true
        
        //cellImage.centerYAnchor.constraint(
        //  equalTo: contentView.centerYAnchor).isActive = true
        
        
        //right
        childNameLabel.trailingAnchor.constraint(
            equalTo: cellImage.leadingAnchor, constant: -5).isActive = true
        
        //Positioning image number 2(the left image)
        
        cellImage2.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        cellImage2.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        //top
        cellImage2.topAnchor.constraint(
            equalTo: childNameLabel.bottomAnchor, constant: 10).isActive = true
        
        self.cellImage2?.setContentCompressionResistancePriority(1000, for: UILayoutConstraintAxis.vertical);
        self.cellImage2?.setContentCompressionResistancePriority(1000, for: UILayoutConstraintAxis.horizontal);
        
        cellImage2.widthAnchor.constraint(
            equalToConstant: 50).isActive = true
        
        cellImage2.heightAnchor.constraint(
            equalToConstant: 50).isActive = true
        
        
        
        //INFORMATION LABEL
        
        cellInformationText.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        cellInformationText.leadingAnchor.constraint(
            equalTo: cellImage2.trailingAnchor, constant: 5).isActive = true
        
        //top
        cellInformationText.topAnchor.constraint(
            equalTo: cellImage2.topAnchor).isActive = true
        
        //right
        cellInformationText.trailingAnchor.constraint(
            equalTo: cellImage.leadingAnchor, constant: -5).isActive = true
        
        //Positioning the DETIALS LABEL
        cellDetailsText.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        cellDetailsText.leadingAnchor.constraint(
            equalTo: cellImage2.trailingAnchor, constant: 5).isActive = true
        
        //right
        cellInformationText.trailingAnchor.constraint(
            equalTo: cellImage.leadingAnchor, constant: -5).isActive = true
        
        
        
        //bottom
        cellDetailsText.bottomAnchor.constraint(
            equalTo: cellImage2.bottomAnchor).isActive = true
        
        //bottomAnchor
        cellDetailsText.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 170.0;//Choose your custom row height
    }
    
    func IsTimeNowAfterRegisteredFinishTime(_ registeredFinishTime: Date) -> Bool
    {
        let minutesElapsed = GetTimeLapsedInMinutes(registeredFinishTime)
        
        if(minutesElapsed > 0)
        {
            //postive is gone past. So yes
            return true
        }
        else{
            //negative is no yet reached. So no.
            return false;
        }
        
    }
    
    func IsTimeNowBeforeRegisteredStartTime(_ registeredStartTime: Date)-> Bool
    {
        let minutesElapsed = GetTimeLapsedInMinutes(registeredStartTime)
        
        if(minutesElapsed > 0)
        {
            //postive is after the childs registere start time, so no.
            return true
        }
        else{
            //negative is expecting a child in, so the time now is before the registered start time. So yes
            return false;
        }
        
    }
    
    func GetTimeLapsedInMinutes(_ time: Date) -> Double
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let currentDate = Date()
        let distanceBetweenDates = currentDate.timeIntervalSince(time)
        let secondsInAnMinute = 60.0;
        let minutesElapsed = distanceBetweenDates / secondsInAnMinute;
        
        return minutesElapsed
    }
    
    func updateUI() {
        
        self.childNameLabel.textColor = .black
        self.cellInformationText.textColor = .black
        self.cellDetailsText.textColor = .black
        
        childNameLabel?.text = nil
        
        if let child = self.child
        {
            childNameLabel?.text = "\(child.Name)"
            
            let lightBlue = _ApplicationColours.LightBlue
            let lightPink = _ApplicationColours.LightPink
            let lightGrey = _ApplicationColours.Grey
            
            UserDefaults.standard.set(child.RegisteredFinishTime, forKey: "finishTime")
            UserDefaults.standard.set(child.RegisteredStartTime, forKey: "dateKey")
            
            if(child.CurrentlySignedIn==true)
            {
                self.cellImage?.image = UIImage(named: "SwipeLeft")
                self.cellImage2?.image = UIImage(named: "SignedIn")
                
                if let savedDate = UserDefaults.standard.object(forKey: "finishTime")  as? Date
                {
                    //Getting Registered Finish time as string
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    let registeredFinishTime = dateFormatter.string(from: child.RegisteredFinishTime as Date)
                    
                    let currentDate = Date()
                    let distanceBetweenDates = currentDate.timeIntervalSince(savedDate)
                    let secondsInAnMinute = 60.0;
                    let minutesElapsed = distanceBetweenDates / secondsInAnMinute;
                    
                    if(minutesElapsed > 1440) //Such a large number must mean no registered hours
                    {
                        //Child currently signed in
                        //Child has no regisered hours.
                        
                        //self.takeActionImage?.image = UIImage(named: "star")
                        self.cellDetailsText.text = "Signed in"
                        self.cellInformationText.text = "No registerd hours."
                        self.backgroundColor = lightBlue?.withAlphaComponent(1)
                        
                    }
                    else if(minutesElapsed > 0 && minutesElapsed < 1440)
                    {
                        //Child currently signed in
                        //Time now is after the childs regisred finish time.
                        
                        //self.takeActionImage?.image = UIImage(named: "priority")
                        self.cellDetailsText.text = "Signed in"
                        self.cellInformationText.text = "Late to leave, expected to go home at: " + registeredFinishTime
                        self.backgroundColor = lightBlue?.withAlphaComponent(1)
                    }
                    else{
                        
                        //Child currently signed in
                        //Time now is before the childs regisred finish time.
                        
                        //self.takeActionImage?.image = UIImage(named: "star")
                        self.cellDetailsText.text = "Signed in"
                        self.cellInformationText.text = "Expected to go home at " + registeredFinishTime
                        self.backgroundColor = lightBlue?.withAlphaComponent(1)
                    }
                }
            }
            else //Not signed in
            {
                self.cellImage?.image = UIImage(named: "SwipeLeft")
                self.cellImage2?.image = UIImage(named: "SignedOut")
                
                
                self.cellDetailsText.text = ""
                
                if let savedDate = UserDefaults.standard.object(forKey: "dateKey")  as? Date
                {
                    //Getting Registered Finish time as string
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    let registeredStartTime = dateFormatter.string(from: child.RegisteredStartTime as Date)
                    
                    let currentDate = Date()
                    let distanceBetweenDates = currentDate.timeIntervalSince(savedDate)
                    let secondsInAnMinute = 60.0;
                    let minutesElapsed = distanceBetweenDates / secondsInAnMinute;
                    
                    if(minutesElapsed < 1440) //If there are more than this many minutes, there cant be a registered start time for this child.
                    {
                        if(minutesElapsed < 0)
                        {
                            //Child not signed in.
                            //Time now is before the childs regisred start time.
                            
                            self.backgroundColor = lightGrey?.withAlphaComponent(1)
                            self.cellDetailsText.text = "Expected in"
                            self.cellInformationText.text = "Expected in " + String(format:"%.0f", abs(minutesElapsed)) + " minutes."
                            
                            self.childNameLabel.textColor = .white
                            self.cellInformationText.textColor = lightBlue
                            self.cellDetailsText.textColor = lightPink
                            
                        }
                        else
                        {
                            //At this point we know
                            //  The child is not signed in
                            // Time now is after the childs registered start time.
                            
                            //At this point we are not sure of
                            //  The child is either about to come in or has already come in.
                            
                            //What we do not know
                            //  If the time now is after or before the registered finish time.
                            
                            //How to tell?
                            //  If the current time is after the registered finish time.
                            //      This means that the child either never came in, or came in and went home.
                            //          If the child has a sign in/out stamp for today, we know that the child was in.
                            //          If the child does not have a sign in/out stamp for today, we know that the child never arrived.
                            
                            if let registeredFinTime = UserDefaults.standard.object(forKey: "finishTime")  as? Date
                            {
                                let isCurrentTimeAfterRegFinishTime = IsTimeNowAfterRegisteredFinishTime(registeredFinTime)
                                let isCurrentTimeBeforeRegFinishTime = !isCurrentTimeAfterRegFinishTime
                                
                                //  If the current time is before the registerd finish time.
                                //      This means that the child is yet to arrive(OR HAS SIGNED OUT EARLY! NEED TO CHECK FOR THIS).
                                if(isCurrentTimeBeforeRegFinishTime)
                                {
                                    //Child has registered hours.
                                    //Child is not signed in.
                                    //It is currently before the childs registered finish time.
                                    //It is currently after the childs registerd start time.
                                    
                                    //TBD: IT MAY BE THAT THE CHILD HAS SIGNED OUT EARLY, WE NEED TO CHECK FOR A SIGN OUT STAMP HERE.
                                    
                                    //Child is yet to arrive/Child is late to sign in
                                    self.backgroundColor = lightGrey?.withAlphaComponent(1)
                                    self.cellDetailsText.text = "Expected in at " + registeredStartTime
                                    self.cellInformationText.text = String(format:"%.0f", minutesElapsed) + " minutes late."
                                    
                                    self.childNameLabel.textColor = .white
                                    self.cellInformationText.textColor = lightBlue
                                    self.cellDetailsText.textColor = lightPink
                                    
                                }
                                else
                                {
                                    //Child has registered hours.
                                    //Child is not signed in.
                                    //It is currently after BOTH the childs registered start and finish time.
                                    
                                    //This means the child could have come in already as its past his/her registered finish hour, or just not come in at al.
                                    
                                    //TBD BELOW
                                    
                                    //To be sure we should check if the child has had any timestamps so far.
                                    
                                    //if time stamps exist(just need to check sign out), we know that the child came in and left.
                                    //  Show in pink
                                    //  "Gone home"
                                    //  "Signed out at"
                                    
                                    //If time stamp does not exist, we know the child never came in today.
                                    //  Show in Orange
                                    //  "Had Registered hours but never arrived."
                                    //  "No time stamps"
                                    
                                    //For now I am just going to assume that the child came in and left, ie has time stamps for today
                                    
                                    //Child is yet to arrive/Child is late to sign in
                                    self.backgroundColor = lightPink?.withAlphaComponent(1)
                                    //self.backgroundColor.backgroundColor?.withAlphaComponent(0.5)
                                    
                                    self.cellDetailsText.text = "Gone home."
                                    self.cellInformationText.text = "Signed out."
                                    
                                }
                                
                            }
                        }
                    }
                    else{
                        
                        //Child not signed in.
                        //Child does not have registered hours.
                        
                        self.backgroundColor = UIColor.white
                        self.cellDetailsText.text = "Not expected in."
                        self.cellInformationText.text = ""
                    }
                    
                }
            }
        }
        
        
        
    }
    
    
    
}


