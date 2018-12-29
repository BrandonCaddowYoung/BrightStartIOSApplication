//
//  AuthyRequests.swift
//  BrightStart
//
//  Created by Brandon Young on 30/01/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Foundation


class AuthyRequests: NSObject {
    
    static let sharedInstance = AuthyRequests()
    let baseURL = ApiInformation.ApiURL
    
    var nurserySchoolId = "";
    
    /*!
     @brief Registers a parent with Authy.
     */
    func RegisterUser(email: String, phoneNumber: String, countryCode: String, name: String, relationship: String, childId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/Authy/RegisterUser?email=" + email + "&phoneNumber=" + phoneNumber + "&countryCode=" + "\(countryCode)" + "&name=" + name + "&relationship=" + relationship + "&childId=" + childId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: true, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    /*!
     @brief Within the authy app, the parent will have a token, this validates it.
     */
    func ValidateToken(auhtyId: String, token: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/Authy/ValidateToken?auhtyId=" + auhtyId + "&token=" + token + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route,method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    /*!
     @brief Sends a one touch request to parents phone.
     */
    func SendOneTouchRequest(authyId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/Authy/SendOneTouchRequest?authyId=" + authyId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route,method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    /*!
     @brief Disables the authy user.
     */
    func DisableChildForAuthy(authyId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/Authy/DisableChildForAuthy?authyId=" + authyId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route,method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    
    /*!
     @brief Enables the authy user.
     */
    func EnableChildForAuthy(authyId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/Authy/EnableChildForAuthy?authyId=" + authyId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    /*!
     @brief Check to see if the user has approved the one touch request.
     */
    func HasOneTouchBeenApproved(uuid: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/Authy/HasOneTouchBeenApproved?uuid=" + uuid + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    /*!
     @brief Retrieves all authy users belonging to a child.
     */
    func GetAllAuthyUsersForChild(childId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/Authy/GetAllAuthyUsersForChild?childId=" + childId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    /*!
     @brief Retrieves all disabled authy users belonging to a child.
     */
    func GetAllDisabledAuthyUsers(childId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/Authy/GetAllDisabledAuthyUsers?childId=" + childId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    /*!
     @brief Retrieves all disabled authy users belonging to a child.
     */
    func GetAllEnabledAuthyUsers(childId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/Authy/GetAllEnabledAuthyUsers?childId=" + childId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    /*!
     @brief Retrieves an Authy user.
     */
    func GetAuhtyUser(auhtyId: String, onCompletion: @escaping (JSON) -> Void) {
        
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolId = id;
        }
        
        let route = baseURL + "api/Authy/GetAuthyUser?authyId=" + auhtyId + "&nurserySchoolId=" + nurserySchoolId
        makeHTTPRequest(encode: false, path: route, method: .get, onCompletion:
            {
                json, err in
                onCompletion(json as JSON)
        })
    }
    
    
}
