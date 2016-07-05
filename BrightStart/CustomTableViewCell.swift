

import UIKit

class CustomTableViewCell: UITableViewCell
{
    var tweet: Child? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var takeActionImage: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var takeActionText: UILabel!
    @IBOutlet weak var currentStatusText: UILabel!
    
    func updateUI() {
        
        // reset any existing tweet information that may exist from a previus load.
        // tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        //tweetProfileImageView?.image = nil
        // tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        if let tweet = self.tweet
        {
            //tweetTextLabel?.text = tweet.Id
            //if tweetTextLabel?.text != nil  {
            //  for _ in tweet.media {
            //    tweetTextLabel.text! += " 📷"
            // }
            // }
            
            tweetScreenNameLabel?.text = "\(tweet.Name)" // tweet.user.description
            
            let lightBlue = UIColor(red: 126/255, green: 206/255, blue: 253/255, alpha: 0.3)
            //let lightPink = UIColor(red: 243/255, green: 212/255, blue: 226/255, alpha: 0.3)
            let lightGrey = UIColor(red: 75/255, green: 79/255, blue: 78/255, alpha: 0.3)
            
            if(tweet.CurrentlySignedIn==true)
            {
                NSUserDefaults.standardUserDefaults().setObject(tweet.RegisteredFinishTime, forKey: "finishTime")
                
                if let savedDate = NSUserDefaults.standardUserDefaults().objectForKey("finishTime")  as? NSDate
                {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "HH:mm" //format style. Browse online to get a format that fits your needs.
                    let registeredFinishTime = dateFormatter.stringFromDate(tweet.RegisteredFinishTime)
                    
                    let currentDate = NSDate()
                    let distanceBetweenDates = currentDate.timeIntervalSinceDate(savedDate)
                    let secondsInAnMinute = 60.0;
                    let minutesElapsed = distanceBetweenDates / secondsInAnMinute;
                    
                    if(minutesElapsed > 1440)
                    {
                        //if no registered hours, then lightblue, start, signed in at ....
                        
                        //self.takeActionImage?.image = UIImage(named: "star")
                        self.takeActionText.text = "Signed in"
                        self.currentStatusText.text = "No registerd hours."
                        self.backgroundColor = lightBlue
                        
                    }
                    else if(minutesElapsed > 0 && minutesElapsed < 1440)
                    {
                        //self.takeActionImage?.image = UIImage(named: "priority")
                        self.takeActionText.text = "Signed in"
                        self.currentStatusText.text = "Late to leave, expected to finish at: " + registeredFinishTime
                        self.backgroundColor = lightBlue
                        
                        //shouldChildHaveBeenSignedOutAlready = true
                    }
                    else{
                        
                        //self.takeActionImage?.image = UIImage(named: "star")
                        self.takeActionText.text = "Signed in"
                        self.currentStatusText.text = "Expected to leave at " + registeredFinishTime
                        self.backgroundColor = lightBlue
                        
                        
                    }
                }
                
                
                
            }
            else //Not signed in
            {
                
                self.takeActionImage?.image = nil
                
                self.takeActionText.text = ""
                
                NSUserDefaults.standardUserDefaults().setObject(tweet.RegisteredStartTime, forKey: "dateKey")
                
                if let savedDate = NSUserDefaults.standardUserDefaults().objectForKey("dateKey")  as? NSDate
                {
                    let currentDate = NSDate()
                    let distanceBetweenDates = currentDate.timeIntervalSinceDate(savedDate)
                    let secondsInAnMinute = 60.0;
                    let minutesElapsed = distanceBetweenDates / secondsInAnMinute;
                    
                    if(minutesElapsed < 1440)
                    {
                        if(minutesElapsed < 0)
                        {
                            self.backgroundColor = lightGrey
                            self.takeActionText.text = "Expected in"
                            self.currentStatusText.text = "Expected in " + String(format:"%.1f", abs(minutesElapsed)) + " minutes."
                        }
                        else
                        {     //Late to sign in
                            self.backgroundColor = lightGrey
                            self.takeActionText.text = "Expected in"
                            self.currentStatusText.text = String(format:"%.1f", minutesElapsed) + " minutes late."
                        }
                    }
                    else{
                        self.backgroundColor = UIColor.whiteColor()
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
