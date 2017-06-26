//
//  ChildRequests.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Alamofire

//typealias ServiceResponse = (JSON, NSError?) -> Void

class SettingsRequests: NSObject {
    
    static let sharedInstance = SettingsRequests()
    let baseURL = ApiInformation.ApiURL
    var nurserySchoolId = "";
    
    func GetRates(onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/RatesLogic/GetAllRates?nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func UpdateRates(RateId: String,
                       Early_Rate_PT: String,
                       Early_Rate_FT: String,
                       Late_Rate_PT: String,
                       Late_Rate_FT: String? = "",
                       Registered_Hours_FT: String? = "",
                       Registered_Hours_PT: String? = "",
                       Non_Registered_Hours_FT: String? = "",
                       Non_Registered_Hours_PT: String? = "",
                       Early_Grace_Minutes: String? = "",
                       Late_Grace_Minutes: String? = "",
                       Full_Time_Qualifying_Point_Hours: String? = "",
                       HalfDayQualificationLower: String? = "",
                       HalfDayQualificationUpper: String? = "",
                       FullDayQualificationLower: String? = "",
                       FullDayQualificationUpper: String? = "",
                       HalfDayRate_PT: String? = "",
                       HalfDayRate_FT: String? = "",
                       FullDayRate_PT: String? = "",
                       FullDayRate_FT: String? = "",
                    onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        var parameters = [String : AnyObject]()
        
        parameters["RateId"] = RateId as AnyObject?
        parameters["Early_Rate_PT"] = Early_Rate_PT as AnyObject?
        parameters["Early_Rate_FT"] = Early_Rate_FT as AnyObject?
        parameters["Late_Rate_PT"] = Late_Rate_PT as AnyObject?
        parameters["Late_Rate_FT"] = Late_Rate_FT as AnyObject?
        parameters["Registered_Hours_FT"] = Registered_Hours_FT as AnyObject?
        parameters["Registered_Hours_PT"] = Registered_Hours_PT as AnyObject?
        parameters["Non_Registered_Hours_FT"] = Non_Registered_Hours_FT as AnyObject?
        parameters["Non_Registered_Hours_PT"] = Non_Registered_Hours_PT as AnyObject?
        parameters["Early_Grace_Minutes"] = Early_Grace_Minutes as AnyObject?
        parameters["Late_Grace_Minutes"] = Late_Grace_Minutes as AnyObject?
        parameters["Full_Time_Qualifying_Point_Hours"] = Full_Time_Qualifying_Point_Hours as AnyObject?
        parameters["HalfDayQualificationLower"] = HalfDayQualificationLower as AnyObject?
        parameters["HalfDayQualificationUpper"] = HalfDayQualificationUpper as AnyObject?
        parameters["FullDayQualificationLower"] = FullDayQualificationLower as AnyObject?
        parameters["FullDayQualificationUpper"] = FullDayQualificationUpper as AnyObject?
        parameters["HalfDayRate_PT"] = HalfDayRate_PT as AnyObject?
        parameters["HalfDayRate_FT"] = HalfDayRate_FT as AnyObject?
        parameters["FullDayRate_PT"] = FullDayRate_PT as AnyObject?
        parameters["FullDayRate_FT"] = FullDayRate_FT as AnyObject?
        parameters["NurserySchoolId"] = nurserySchoolId as AnyObject?
       
        parameters["NurserySchoolId"] = nurserySchoolId as AnyObject?
        
        let route = baseURL + "api/RatesLogic/UpdateRate?nurserySchoolId=" + nurserySchoolId
        makeHTTPPut(encode: false, path: route, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func GetEmailSettings(onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/EmailLogic/GetEmailSettings?nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func UpdateEmailSettings(Id: String,
                     SMTP: String,
                     EmailAddress: String,
                     Port: String,
                     PasssWord: String? = "",
                     Name: String? = "",
                     onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        var parameters = [String : AnyObject]()
        
        parameters["Id"] = Id as AnyObject?
        parameters["SMTP"] = SMTP as AnyObject?
        parameters["EmailAddress"] = EmailAddress as AnyObject?
        parameters["Port"] = Port as AnyObject?
        parameters["PassWord"] = PasssWord as AnyObject?
        parameters["Name"] = Name as AnyObject?
        parameters["NurserySchoolId"] = nurserySchoolId as AnyObject?
        
        let route = baseURL + "api/EmailLogic/UpdateEmail?nurserySchoolId=" + nurserySchoolId
        makeHTTPPut(encode: false, path: route, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func GetBreakDownText(onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/SettingsLogic/GetSettingByName?settingsName=ExtraTimeBreakDownEmailBodyText&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func GetShouldSendBreakDown(onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/SettingsLogic/GetSettingByName?settingsName=ShouldSendExtraMinutesBreakDownWithEmail&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func GetEmailBodyText(onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/SettingsLogic/GetSettingByName?settingsName=EmailBodyText&nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func UpdateSettings(Name: String,
                     Value: String,
                     onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        var parameters = [String : AnyObject]()
        
        parameters["Name"] = Name as AnyObject?
        parameters["Value"] = Value as AnyObject?
               parameters["NurserySchoolId"] = nurserySchoolId as AnyObject?
        
        let route = baseURL + "api/SettingsLogic/UpdateSettings?nurserySchoolId=" + nurserySchoolId
        makeHTTPPut(encode: false, path: route, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func GetNurserySettings(onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/NurseryDetailsLogic/GetNurseryDetails?nurserySchoolId=" + nurserySchoolId
        makeHTTPGetRequest(encode: false, path: route, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    func UpdateNurserySettings(Id: String,
                             SMTP: String,
                             EmailAddress: String,
                             Port: String,
                             PasssWord: String? = "",
                             Name: String? = "",
                             onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        var parameters = [String : AnyObject]()
        
        parameters["Id"] = Id as AnyObject?
        parameters["SMTP"] = SMTP as AnyObject?
        parameters["EmailAddress"] = EmailAddress as AnyObject?
        parameters["Port"] = Port as AnyObject?
        parameters["PassWord"] = PasssWord as AnyObject?
        parameters["Name"] = Name as AnyObject?
        parameters["NurserySchoolId"] = nurserySchoolId as AnyObject?
        
        let route = baseURL + "api/EmailLogic/UpdateEmail?nurserySchoolId=" + nurserySchoolId
        makeHTTPPut(encode: false, path: route, params: parameters, encoding: JSONEncoding.default, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    

}
