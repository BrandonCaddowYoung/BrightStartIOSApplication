//
//  MainMenuButtonCollectionViewCell.swift
//  BrightStart
//
//  Created by Colleen Caddow on 05/12/2016.
//  Copyright © 2016 dev. All rights reserved.
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
        
        contentView.addSubview(label) //Remember to add ui elements to the content view not the cell iteslf.
        
        button = UIButton(frame: contentView.frame)
        button.contentMode = .scaleToFill
        button.clipsToBounds = true
        
       // button.setTitle(displayText, for: .normal)
        button.layer.cornerRadius = 3
        
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        
        contentView.addSubview(button) //Remember to add ui elements to the content view not the cell iteslf.
        
    }
    
    func setDisplayText(newDisplayText: String)
    {
     //button.setTitle(newDisplayText, for: .normal)
        label.text = newDisplayText + "Boom"
    }
    
    func changeColor() {
        
        print("segue to: " + segueText)
        
        delegate?.changeColorOfButton(forCell: self)
        
        delegate?.performSegue(segueId: segueText)

    }
    
}
