//
//  MainMenuButtonCollectionViewCell.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit

protocol MainMenuButtonCollectionViewCellDelegate {
  
    func performSegue(segueId: String)
    
    func renderMenuAssets(menuType: MenuTypes)
    
     func setSelectedAuthyId(authyID: NSString)
    
    func setTargetPurpose(type: PurposeTypes)
    
    
}

class MainMenuButtonCollectionViewCell: UICollectionViewCell {
 
    var authyId: String = ""
    var segueText: String = ""
    var targetPurpose: PurposeTypes!
    var displayText: String = ""
    var button: UIButton!
    var label: UILabel!
    var delegate: MainMenuButtonCollectionViewCellDelegate? = nil
    
    override func awakeFromNib() {
        
        //This is the text under the image within the menu.
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        
        //label.textColor = _ApplicatoinColours.AppledGrey
       // label.font = _ApplicatoinColours.MenuFont
        
        label.adjustsFontSizeToFitWidth = true
        
        contentView.addSubview(label) //Remember to add ui elements to the content view not the cell iteslf.
        
        button = UIButton(frame: contentView.frame)
        button.contentMode = .scaleToFill
        button.clipsToBounds = true
        
        button.layer.cornerRadius = 3
        
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        
       button.backgroundColor = StyleManager.theme2()
        
        contentView.addSubview(button) //Remember to add ui elements to the content view not the cell iteslf.
       
        setupConstraints()
        
    }
    
    func setDisplayText(newDisplayText: String)
    {
        label.text = newDisplayText
    }
    
    func setAuthyId(auhtyId: String)
    {
        authyId = auhtyId
    }
    
    func changeColor() {
        
        delegate?.setTargetPurpose(type: targetPurpose)
        
        //If segueing to another menu, we need to do something differently as we have to segue to ourself!
        
        delegate?.setSelectedAuthyId(authyID: authyId as NSString)
        
        if(segueText=="GoToAuthyMenu"){
            delegate?.renderMenuAssets(menuType: .Authy)
        }
        else if(segueText=="GoToMainMenu"){
            delegate?.renderMenuAssets(menuType: .MainMenu)
        }
        else if(segueText=="GoToTimeStampsMenu"){
            delegate?.renderMenuAssets(menuType: .TimeStamps)
        }
        else if(segueText=="GoToRegisteredHoursMenu"){
            delegate?.renderMenuAssets(menuType: .RegisteredHours)
        }
        else if(segueText=="GoToChildrenMenu"){
            delegate?.renderMenuAssets(menuType: .Children)
        }
        else if(segueText=="GoToBillingMenu"){
            delegate?.renderMenuAssets(menuType: .Billing)
        }
        else{
            delegate?.performSegue(segueId: segueText)
        }

    }
    
    func setupConstraints()
    {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        //label to the botom
        label.bottomAnchor .constraint(
            equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //Button to the top
        button.topAnchor .constraint(
            equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        
        //button 50% of heght
        button.heightAnchor .constraint(
            equalTo: contentView.heightAnchor, multiplier: 0.50).isActive = true
        
        button.widthAnchor.constraint(
            equalTo: button.heightAnchor).isActive = true
        
        button.centerXAnchor.constraint(
            equalTo: contentView.centerXAnchor).isActive = true

        label.centerXAnchor.constraint(
            equalTo: contentView.centerXAnchor).isActive = true
        
    }
    
}
