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
        
        if( UIDevice.current.userInterfaceIdiom == .pad)
        {
            //print("its an IPad")
            
            self.selectedIndex = 1
            tabBar.isHidden = true;
        }
        
        if( UIDevice.current.userInterfaceIdiom == .phone)
        {
            
            //print("Its an Iphone")
            
            self.selectedIndex = 1
            tabBar.isHidden = false;
        }
        
    }
    
    
    
    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if(self.selectedIndex==0)
        {
            tabBar.isHidden = true;
        }
        
        //print("Selected item")
    }
    
    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //print("Selected view controller")
    }
    
    
    
    
}
