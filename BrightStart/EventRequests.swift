//
//  EventRequests.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Alamofire

//typealias ServiceResponse = (JSON, NSError?) -> Void

class EventRequests: NSObject {
    
    static let sharedInstance = EventRequests()
    let baseURL = ApiInformation.ApiURL
    var nurserySchoolId = "";
    
    func GetListOfCalednarEvents(onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/CalendarEventLogic/GetListOfCalednarEvents?nurserySchoolId=" + nurserySchoolId
        
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func CreateCalendarEvent(targetDate: Date, text: String,
                       onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: targetDate as Date)
        
        var parameters = [String : AnyObject]()
        
        parameters["Id"] = "0" as AnyObject?
        parameters["Enabled"] = false as AnyObject?
        parameters["EventColor"] = "" as AnyObject?
        parameters["EventFont"] = "" as AnyObject?
        parameters["EventLengthInHours"] = 2.0 as AnyObject?
        parameters["EventTextColor"] = "" as AnyObject?
        parameters["IgnoreTimeComponent"] = false as AnyObject?
        parameters["Rank"] = "" as AnyObject?
        parameters["ReadOnlyEvent"] = false as AnyObject?
        parameters["RecurringFrequency"] = "" as AnyObject?
        parameters["ThisDayForwardOnly"] = false as AnyObject?
        parameters["TooltipEnabled"] = false as AnyObject?
        parameters["ClosureDay"] = true as AnyObject?
        parameters["NurserySchoolId"] = nurserySchoolId as AnyObject?
        
        parameters["Date"] = dateString as AnyObject?
        parameters["EventText"] = text as AnyObject?
        
        let route = baseURL + "api/CalendarEventLogic/CreateCalendarEvent?nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route,method: .post, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func DeleteCalendarEventById(id: String,
                             onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/CalendarEventLogic/DeleteCalendarEventById?id=" + id + "&nurserySchoolId=" + nurserySchoolId
        
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
}
