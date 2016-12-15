//
//  MainMenuButtonCollectionViewCell.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit

//Used to communicate between FoodCollectionViewCell and ViewController
protocol MainMenuButtonCollectionViewCellDelegate {
    
    func changeColorOfButton(forCell: MainMenuButtonCollectionViewCell)
    
    func performSegue(segueId: String)
}

class MainMenuButtonCollectionViewCell: UICollectionViewCell {
 
    var segueText: String = "intial segue text"
    var displayText: String = "BILLING"
    var button: UIButton!
    var label: UILabel!
    var delegate: MainMenuButtonCollectionViewCellDelegate? = nil
    
    override func awakeFromNib() {
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        
        label.font = UIFont(name: "Helvetica Neue", size: 15)
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        
        contentView.addSubview(label) //Remember to add ui elements to the content view not the cell iteslf.
        
        button = UIButton(frame: contentView.frame)
        button.contentMode = .scaleToFill
        button.clipsToBounds = true
        
       // button.setTitle(displayText, for: .normal)
        button.layer.cornerRadius = 3
        
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        
        contentView.addSubview(button) //Remember to add ui elements to the content view not the cell iteslf.
        
        setupConstraints()
        
    }
    
    func setDisplayText(newDisplayText: String)
    {
     //button.setTitle(newDisplayText, for: .normal)
        label.text = newDisplayText
    }
    
    func changeColor() {
        
        print("segue to: " + segueText)
        
        delegate?.changeColorOfButton(forCell: self)
        
        delegate?.performSegue(segueId: segueText)

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
