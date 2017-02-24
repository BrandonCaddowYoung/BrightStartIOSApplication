//
//  CommonHelper.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import UIKit

class CommonHelper {
    
    
    func showOverlayMessage(_ message: String) ->  UIAlertController{
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        
        
        
        alert.view.layer.cornerRadius = 8.0
        alert.view.layer.masksToBounds = true
        
        
        alert.view.tintColor = UIColor.gray
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        
        return alert
        
    }
    
    func showOverlayMessage2(_ message: String) ->  ProgressHUD{
        
        let loadingSpiiner = ProgressHUD(text: message)
        
        return loadingSpiiner
        
    }
    
    
    
    
    

}
