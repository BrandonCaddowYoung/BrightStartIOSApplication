//
//  MainTabBarController.swift
//  BrightStart
//
//  Created by dev on 29/04/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        
        self.delegate = self
        
        if( UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
            print("its an IPad")
            
            self.selectedIndex = 1
            tabBar.hidden = true;
        }
        
        if( UIDevice.currentDevice().userInterfaceIdiom == .Phone)
        {
            
            print("Its an Iphone")
            
            self.selectedIndex = 1
            tabBar.hidden = true;
        }
       
        
        
    }
    
    
    // UITabBarDelegate
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        if(self.selectedIndex==0)
        {
            tabBar.hidden = true;
        }
        
        print("Selected item")
    }
    
    // UITabBarControllerDelegate
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("Selected view controller")
    }
    
    
    
    
}
