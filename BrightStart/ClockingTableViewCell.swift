//
//  CustomTableViewCell.swift
//  BrightStart
//
//  Created by Colleen Caddow on 29/11/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class ClockingTableViewCell: UITableViewCell
{
    var child: Child? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var takeActionImage: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var takeActionText: UILabel!
    @IBOutlet weak var currentStatusText: UILabel!
    
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
        
        // reset any existing tweet information that may exist from a previus load.
        // tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        //tweetProfileImageView?.image = nil
        // tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        if let tweet = self.child
        {
            tweetScreenNameLabel?.text = "\(tweet.Name)" // tweet.user.description
            
            let lightBlue = UIColor(red: 126/255, green: 206/255, blue: 253/255, alpha: 0.5)
            let lightPink = UIColor(red: 243/255, green: 212/255, blue: 226/255, alpha: 0.7)
            let lightGrey = UIColor(red: 75/255, green: 79/255, blue: 78/255, alpha: 0.3)
            
            UserDefaults.standard.set(tweet.RegisteredFinishTime, forKey: "finishTime")
            UserDefaults.standard.set(tweet.RegisteredStartTime, forKey: "dateKey")
            
            if(tweet.CurrentlySignedIn==true)
            {
                if let savedDate = UserDefaults.standard.object(forKey: "finishTime")  as? Date
                {
                    //Getting Registered Finish time as string
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    let registeredFinishTime = dateFormatter.string(from: tweet.RegisteredFinishTime as Date)
                    
                    let currentDate = Date()
                    let distanceBetweenDates = currentDate.timeIntervalSince(savedDate)
                    let secondsInAnMinute = 60.0;
                    let minutesElapsed = distanceBetweenDates / secondsInAnMinute;
                    
                    if(minutesElapsed > 1440) //Such a large number must mean no registered hours
                    {
                        //Child currently signed in
                        //Child has no regisered hours.
                        
                        //self.takeActionImage?.image = UIImage(named: "star")
                        self.takeActionText.text = "Signed in"
                        self.currentStatusText.text = "No registerd hours."
                        self.backgroundColor = lightBlue
                        
                    }
                    else if(minutesElapsed > 0 && minutesElapsed < 1440)
                    {
                        //Child currently signed in
                        //Time now is after the childs regisred finish time.
                        
                        //self.takeActionImage?.image = UIImage(named: "priority")
                        self.takeActionText.text = "Signed in"
                        self.currentStatusText.text = "Late to leave, expected to go home at: " + registeredFinishTime
                        self.backgroundColor = lightBlue
                        
                        //shouldChildHaveBeenSignedOutAlready = true
                    }
                    else{
                        
                        //Child currently signed in
                        //Time now is before the childs regisred finish time.
                        
                        //self.takeActionImage?.image = UIImage(named: "star")
                        self.takeActionText.text = "Signed in"
                        self.currentStatusText.text = "Expected to go home at " + registeredFinishTime
                        self.backgroundColor = lightBlue
                    }
                }
            }
            else //Not signed in
            {
                self.takeActionImage?.image = nil
                
                self.takeActionText.text = ""
                
                if let savedDate = UserDefaults.standard.object(forKey: "dateKey")  as? Date
                {
                    //Getting Registered Finish time as string
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    let registeredStartTime = dateFormatter.string(from: tweet.RegisteredStartTime as Date)
                    
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
                            
                            self.backgroundColor = lightGrey
                            self.takeActionText.text = "Expected in"
                            self.currentStatusText.text = "Expected in " + String(format:"%.0f", abs(minutesElapsed)) + " minutes."
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
                                    self.backgroundColor = lightGrey
                                    self.takeActionText.text = "Expected in at " + registeredStartTime
                                    self.currentStatusText.text = String(format:"%.0f", minutesElapsed) + " minutes late."
                                    
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
                                    self.backgroundColor = lightPink
                                    self.takeActionText.text = "Gone home."
                                    self.currentStatusText.text = "Signed out."
                                    
                                }
                                
                            }
                        }
                    }
                    else{
                        
                        //Child not signed in.
                        //Child does not have registered hours.
                        
                        self.backgroundColor = UIColor.white
                        self.takeActionText.text = "Not expected in."
                        self.currentStatusText.text = ""
                    }
                    
                }
            }
            
            //Study this!
            
            // if let profileImageURL = tweet.user.profileImageURL {
            //   let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            // dispatch_async(dispatch_get_global_queue(qos, 0), {()-> Void in
            
            //Now we are on a seperate thread.
            //   if let imageData = NSData(contentsOfURL: profileImageURL) {
            
            //     dispatch_async(dispatch_get_main_queue()){
            
            //Now we are back on the main UI thread
            //       if profileImageURL == tweet.user.profileImageURL {
            //         self.tweetProfileImageView?.image = UIImage(data: imageData)
            
            //   }
            // else {
            //   self.tweetProfileImageView?.image = nil
            // }
            // }
            // }
            
            // })
            // }
            
            //let formatter = NSDateFormatter()
            //if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
            //  formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            //} else {
            //  formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            // }
            //tweetCreatedLabel?.text = formatter.stringFromDate(tweet.Id)
        }
        
    }
}
