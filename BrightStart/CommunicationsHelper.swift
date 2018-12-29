//
//  CommunicationsHelper.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Alamofire
import p2_OAuth2
import AppAuth

public func getBearerToken(_ completion: @escaping (String) -> Void){
    
    var token = ""
    
    let path:String = "https://login.microsoftonline.com/10f1fd70-59b3-4389-9771-86283cd7b14d/oauth2/token"
    
    let parameters:[String:String] = ["resource": " f2571285-7e4c-4e05-a805-892409013d71","client_id": "157edbeb-f312-4d68-a005-4ab927eb8ecf", "client_secret": ".8{*{8N=@9es&=p{&lG>2$Yd^p@)Z%_!/2@:0@|;e+)Y8{D", "client_info": "1", "grant_type": "client_credentials"]
    
    Alamofire.request(path,method: .post, parameters: parameters).responseString { response in
        
        // Handle response to extract the OAuth Token
        if let error = response.result.error {
            print(error)
            return
        }
        
        if let receivedResults = response.result.value, let jsonData = receivedResults.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            let jsonResults = JSON(data: jsonData)
            
            for (key, value) in jsonResults {
                switch key {
                case "access_token":
                    token = value.string ?? ""
                default: break
                }
            }
            completion(token)
        }
    }
}

/*!
 @brief Performs an HTTP request.
 */
func makeHTTPRequest(encode: Bool, path: String, method: HTTPMethod, params: Parameters? = nil, encoding: ParameterEncoding? = nil, onCompletion: @escaping ServiceResponse) {
    
    var url = path
    
    if(encode){
        url = path.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    getBearerToken({token in
        
        let headers = ["Authorization" : "Bearer " + token ,
                       "Content-Type": "application/json"]
        
        Alamofire.request(url, method: method, parameters: params, encoding: encoding ?? JSONEncoding.default, headers: headers)
            .responseJSON { response in
                
                switch response.result {
                    
                case.success(let data):
                    onCompletion(JSON(data), nil)
                    
                case.failure(let error):
                    if let httpStatusCode = response.response?.statusCode {
                        switch(httpStatusCode) {
                        case 400:
                            print("Not found \(error) ")
                        case 401:
                            print("Unauthorised\(error) ")
                        default:
                            print("An unknown eror occured when making an http request")
                        }
                        
                    }
                }
        }
        
    });
    
    return;
    
}
