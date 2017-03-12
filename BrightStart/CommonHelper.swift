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

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    
    /**
     Adds bottom border to the view with given side margins
     
     - parameter color:   the border color
     - parameter margins: the left and right margin
     */
    func addBottomBorder(color: UIColor = .red, margins: CGFloat = 0) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutAttribute.height,
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutAttribute.height,
                                                multiplier: 1, constant: 1))
        
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.bottom,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.bottom,
                                              multiplier: 1, constant: 0))
        
        
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.leading,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.leading,
                                              multiplier: 1, constant: margins))
        
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.trailing,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.trailing,
                                              multiplier: 1, constant: margins))
    }
    
    func addTopBorder(color: UIColor = .red, margins: CGFloat = 0) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutAttribute.height,
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutAttribute.height,
                                                multiplier: 1, constant: 1))
        
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.top,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.top,
                                              multiplier: 1, constant: 0))
        
        
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.leading,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.leading,
                                              multiplier: 1, constant: margins))
        
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.trailing,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.trailing,
                                              multiplier: 1, constant: margins))
    }
}

