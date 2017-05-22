//
//  CommunicationsHelper.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import Alamofire

/*!
 @brief Performs an HTTP request.
 */
func makeHTTPGetRequest(encode: Bool, path: String, onCompletion: @escaping ServiceResponse) {
    
    var url = path
    
    if(encode){
     url = path.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    let user = ApiInformation.BasicAithUsername
    let password = ApiInformation.BasicAithPassword
    
    var headers: HTTPHeaders = [:]
    
    if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
        headers[authorizationHeader.key] = authorizationHeader.value
    }
    
    Alamofire.request(url, headers: headers)
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
    
    return;
    
}

/*!
 @brief Performs an HTTP PUT request.
 */
func makeHTTPPutRequest(encode: Bool, path: String, onCompletion: @escaping ServiceResponse) {
    
    var url = path
    
    if(encode){
        url = path.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    let user = ApiInformation.BasicAithUsername
    let password = ApiInformation.BasicAithPassword
    
    var headers: HTTPHeaders = [:]
    
    if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
        headers[authorizationHeader.key] = authorizationHeader.value
    }
    
    Alamofire.request(url, method: .put, headers: headers)
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
    
    return;
    
}








/*!
 @brief Performs an HTTP POST request.
 */
func makeHTTPPostRequest(encode: Bool, path: String, onCompletion: @escaping ServiceResponse) {
    
    var url = path
    
    if(encode){
        url = path.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    let user = ApiInformation.BasicAithUsername
    let password = ApiInformation.BasicAithPassword
    
    var headers: HTTPHeaders = [:]
    
    if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
        headers[authorizationHeader.key] = authorizationHeader.value
    }
    
    Alamofire.request(url, method: .post, headers: headers)
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
    
    return;
    
}







/*!
 @brief Performs an HTTP POST request.
 */
func makeHTTPPost(encode: Bool, path: String, params: Parameters, encoding: ParameterEncoding, onCompletion: @escaping ServiceResponse) {
    
    let user = ApiInformation.BasicAithUsername
    let password = ApiInformation.BasicAithPassword
    
    var headers: HTTPHeaders = [:]
    
    if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
        headers[authorizationHeader.key] = authorizationHeader.value
    }
    
    Alamofire.request(path, method: .post, parameters: params, encoding: encoding, headers: headers).responseJSON { response in
        
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
        
        if((response.response) == nil)
        {
            //Timeout?
            
            onCompletion(nil, nil)
        }
    }
    
    
   // Alamofire.request(path, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
    
}

/*!
 @brief Performs an HTTP PUT request.
 */
func makeHTTPPut(encode: Bool, path: String, params: Parameters, encoding: ParameterEncoding, onCompletion: @escaping ServiceResponse) {
    
    let user = ApiInformation.BasicAithUsername
    let password = ApiInformation.BasicAithPassword
    
    var headers: HTTPHeaders = [:]
    
    if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
        headers[authorizationHeader.key] = authorizationHeader.value
    }
    
    Alamofire.request(path, method: .put, parameters: params, encoding: encoding, headers: headers).responseJSON { response in
        
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
        
        if((response.response) == nil)
        {
            //Timeout?
            
            onCompletion(nil, nil)
        }
    }
    
    
    // Alamofire.request(path, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
    
}


/*!
 @brief Performs an HTTP DELETE request.
 */
func makeHTTPDeleteRequest(encode: Bool, path: String, onCompletion: @escaping ServiceResponse) {
    
    var url = path
    
    if(encode){
        url = path.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    let user = ApiInformation.BasicAithUsername
    let password = ApiInformation.BasicAithPassword
    
    var headers: HTTPHeaders = [:]
    
    if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
        headers[authorizationHeader.key] = authorizationHeader.value
    }
    
    Alamofire.request(url, method: .delete, headers: headers)
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
    
    return;
    
}
