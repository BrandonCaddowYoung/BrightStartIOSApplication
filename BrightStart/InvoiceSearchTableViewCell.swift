//
//  CustomTableViewCell.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import UIKit

class InvoiceSearchTableViewCell: UITableViewCell
{
    var invoice: Invoice? {
        didSet {
            updateUI()
        }
    }
    
    var _CommonHelper: CommonHelper!
    var _ApplicationColours: ApplicatoinColours!
    
    @IBOutlet weak var LargeLeftContainer: UIView!
    
    @IBOutlet weak var TotalLabel: UILabel!
    
    @IBOutlet weak var InvoiceNumberLabel: UILabel!
    
    @IBOutlet weak var SmallTopLeftContainer: UIView!
    
    @IBOutlet weak var SmallTopRightContainer: UIView!
    
    @IBOutlet weak var SmallBottomLeftContainer: UIView!
    
    @IBOutlet weak var SmallBottomRightContainer: UIView!
    
    @IBOutlet weak var BalanceLabel: UILabel!
    @IBOutlet weak var BalanceAmountLabel: UILabel!
    
    @IBOutlet weak var RegisterdLabel: UILabel!
    @IBOutlet weak var RegisteredAmountLabel: UILabel!
    
    @IBOutlet weak var ExtraLabel: UILabel!
    @IBOutlet weak var ExtraAmountLabel: UILabel!
    
    @IBOutlet weak var NonRegisteredLabel: UILabel!
    @IBOutlet weak var NonRegisteredAmountLabel: UILabel!
    
    override func awakeFromNib() {
        
        _CommonHelper = CommonHelper()
        _ApplicationColours = ApplicatoinColours()
        
        setupConstraints()
        
        LargeLeftContainer.backgroundColor = _ApplicationColours.White
        SmallTopLeftContainer.backgroundColor = _ApplicationColours.White
        SmallTopRightContainer.backgroundColor = _ApplicationColours.White
        SmallBottomLeftContainer.backgroundColor = _ApplicationColours.White
        SmallBottomRightContainer.backgroundColor = _ApplicationColours.White
        
        TotalLabel.font = _ApplicationColours.XlargeFont
        InvoiceNumberLabel.font = _ApplicationColours.mediumFont
        
        RegisteredAmountLabel.font = _ApplicationColours.mediumFont
        NonRegisteredAmountLabel.font = _ApplicationColours.mediumFont
        ExtraAmountLabel.font = _ApplicationColours.mediumFont
        BalanceAmountLabel.font = _ApplicationColours.mediumFont
        
        RegisterdLabel.font = _ApplicationColours.smallFont
        NonRegisteredLabel.font = _ApplicationColours.smallFont
        ExtraLabel.font = _ApplicationColours.smallFont
        BalanceLabel.font = _ApplicationColours.smallFont
        
        TotalLabel.textColor = _ApplicationColours.Black
        InvoiceNumberLabel.textColor = _ApplicationColours.Black
        
        RegisteredAmountLabel.textColor = _ApplicationColours.Black
        NonRegisteredAmountLabel.textColor = _ApplicationColours.Black
        ExtraAmountLabel.textColor = _ApplicationColours.Black
        BalanceAmountLabel.textColor = _ApplicationColours.Black
        
        RegisterdLabel.textColor = _ApplicationColours.Black
        NonRegisteredLabel.textColor = _ApplicationColours.Black
        ExtraLabel.textColor = _ApplicationColours.Black
        BalanceLabel.textColor = _ApplicationColours.Black
        
    }
    
    func setupConstraints() {
        
        LargeLeftContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        LargeLeftContainer.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor).isActive = true
        
        //height
        LargeLeftContainer.heightAnchor.constraint(
            equalToConstant: 150).isActive = true
        
        //width
        LargeLeftContainer.widthAnchor.constraint(
            equalTo: contentView.widthAnchor, multiplier: 0.50).isActive = true
        
        LargeLeftContainer.topAnchor.constraint(
            equalTo: contentView.topAnchor).isActive = true
        
        LargeLeftContainer.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor).isActive = true
        
        
        //TOTAL LABEL
        
        TotalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TotalLabel.centerYAnchor.constraint(
            equalTo: LargeLeftContainer.centerYAnchor).isActive = true
        
        //left
        TotalLabel.centerXAnchor.constraint(
            equalTo: LargeLeftContainer.centerXAnchor).isActive = true
        
        //INVOICE NUMBER LABEL
        
        InvoiceNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        InvoiceNumberLabel.leadingAnchor.constraint(
            equalTo: LargeLeftContainer.leadingAnchor, constant: 10).isActive = true
        
        //left
        InvoiceNumberLabel.topAnchor.constraint(
            equalTo: LargeLeftContainer.topAnchor, constant: 10).isActive = true
        
        SmallTopLeftContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        SmallTopLeftContainer.leadingAnchor.constraint(
            equalTo: LargeLeftContainer.trailingAnchor).isActive = true
        
        //height
        SmallTopLeftContainer.heightAnchor.constraint(
            equalTo: contentView.heightAnchor, multiplier: 0.50).isActive = true
        
        //width
        SmallTopLeftContainer.widthAnchor.constraint(
            equalTo: contentView.widthAnchor, multiplier: 0.25).isActive = true
        
        //top
        SmallTopLeftContainer.topAnchor.constraint(
            equalTo: LargeLeftContainer.topAnchor).isActive = true
        
        
        
        BalanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        BalanceAmountLabel.centerYAnchor.constraint(
            equalTo: SmallTopLeftContainer.centerYAnchor).isActive = true
        
        //left
        BalanceAmountLabel.centerXAnchor.constraint(
            equalTo: SmallTopLeftContainer.centerXAnchor).isActive = true
        
        
        BalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        BalanceLabel.centerXAnchor.constraint(
            equalTo: SmallTopLeftContainer.centerXAnchor).isActive = true
        
        BalanceLabel.topAnchor.constraint(
            equalTo: BalanceAmountLabel.bottomAnchor, constant: 4).isActive = true
        
        

        
        
        
        
       
        SmallTopRightContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        SmallTopRightContainer.leadingAnchor.constraint(
            equalTo: SmallTopLeftContainer.trailingAnchor).isActive = true
        
        //height
        SmallTopRightContainer.heightAnchor.constraint(
            equalTo: contentView.heightAnchor, multiplier: 0.50).isActive = true
        
        //width
        SmallTopRightContainer.widthAnchor.constraint(
            equalTo: contentView.widthAnchor, multiplier: 0.25).isActive = true
        
        //top
        SmallTopRightContainer.topAnchor.constraint(
            equalTo: LargeLeftContainer.topAnchor).isActive = true
        

        
        
        RegisteredAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        RegisteredAmountLabel.centerYAnchor.constraint(
            equalTo: SmallTopRightContainer.centerYAnchor).isActive = true
        
        //left
        RegisteredAmountLabel.centerXAnchor.constraint(
            equalTo: SmallTopRightContainer.centerXAnchor).isActive = true
        
        
        RegisterdLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        RegisterdLabel.centerXAnchor.constraint(
            equalTo: SmallTopRightContainer.centerXAnchor).isActive = true
        
        RegisterdLabel.topAnchor.constraint(
            equalTo: RegisteredAmountLabel.bottomAnchor, constant: 4).isActive = true
        
        
        
        
        
        
        SmallBottomLeftContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        SmallBottomLeftContainer.leadingAnchor.constraint(
            equalTo: LargeLeftContainer.trailingAnchor).isActive = true
        
        //height
        SmallBottomLeftContainer.heightAnchor.constraint(
            equalTo: contentView.heightAnchor, multiplier: 0.50).isActive = true
        
        //width
        SmallBottomLeftContainer.widthAnchor.constraint(
            equalTo: contentView.widthAnchor, multiplier: 0.25).isActive = true
        
        //bottom
        SmallBottomLeftContainer.bottomAnchor.constraint(
            equalTo: LargeLeftContainer.bottomAnchor).isActive = true
        
        
        
        
        
        
        NonRegisteredAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        NonRegisteredAmountLabel.centerYAnchor.constraint(
            equalTo: SmallBottomRightContainer.centerYAnchor).isActive = true
        
        //left
        NonRegisteredAmountLabel.centerXAnchor.constraint(
            equalTo: SmallBottomRightContainer.centerXAnchor).isActive = true
        
        
        NonRegisteredLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        NonRegisteredLabel.centerXAnchor.constraint(
            equalTo: SmallBottomRightContainer.centerXAnchor).isActive = true
        
        NonRegisteredLabel.topAnchor.constraint(
            equalTo: NonRegisteredAmountLabel.bottomAnchor, constant: 4).isActive = true
        
        
        
        
        
        
        
        SmallBottomRightContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        SmallBottomRightContainer.leadingAnchor.constraint(
            equalTo: SmallBottomLeftContainer.trailingAnchor).isActive = true
        
        //height
        SmallBottomRightContainer.heightAnchor.constraint(
            equalTo: contentView.heightAnchor, multiplier: 0.50).isActive = true
        
        //width
        SmallBottomRightContainer.widthAnchor.constraint(
            equalTo: contentView.widthAnchor, multiplier: 0.25).isActive = true
        
        //bottom
        SmallBottomRightContainer.bottomAnchor.constraint(
            equalTo: LargeLeftContainer.bottomAnchor).isActive = true
        
        
       
        
        ExtraAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        ExtraAmountLabel.centerYAnchor.constraint(
            equalTo: SmallBottomLeftContainer.centerYAnchor).isActive = true
        
        //left
        ExtraAmountLabel.centerXAnchor.constraint(
            equalTo: SmallBottomLeftContainer.centerXAnchor).isActive = true
        
        
        ExtraLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        ExtraLabel.centerXAnchor.constraint(
            equalTo: SmallBottomLeftContainer.centerXAnchor).isActive = true
        
        ExtraLabel.topAnchor.constraint(
            equalTo: ExtraAmountLabel.bottomAnchor, constant: 4).isActive = true
        
        
        
        
        
        
    }
    
    //func tableView(_ tableView: UITableView, heightForRowAtIndexPath: IndexPath) -> CGFloat
   // {
    //    return 500.0;//Choose your custom row height
   // }
    
    func updateUI() {
        
        self.backgroundColor = _ApplicationColours.TableBackGround
        
       // self.titleLabel.textColor = _ApplicationColours.TableTextColor
       // self.timeLabel.textColor =  _ApplicationColours.TableTextColor
        
        //titleLabel?.text = nil
        
        if let invoice = self.invoice
        {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "HH mm ss"
            
            //dateFormatter.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
            dateFormatter.dateFormat = "h:mm a"
            
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            
           // let convertedDateString = dateFormatter.string(from: invoice.TimeStamp)
            
           // let dateField = convertedDateString as String
            
            TotalLabel?.text = "£" + String(describing: invoice.Total)
            InvoiceNumberLabel?.text = "#" + String(describing: invoice.InvoiceId)
           
            var (h, m, s) = _CommonHelper.secondsToHoursMinutesSeconds (seconds: Int(invoice.RegisteredMinutes * 60))
            RegisteredAmountLabel?.text = String(h) + "H " + String(m) + "M"
            
            (h, m, s) = _CommonHelper.secondsToHoursMinutesSeconds (seconds: Int(invoice.NonRegisteredMinutes * 60))
            NonRegisteredAmountLabel?.text = String(h) + "H " + String(m) + "M"
            
            ExtraAmountLabel?.text = String(describing: invoice.EarlyMinutes + invoice.LateMinutes)
            BalanceAmountLabel?.text = "£0"
            
            // UserDefaults.standard.set(child.RegisteredFinishTime, forKey: "finishTime")
            //UserDefaults.standard.set(child.RegisteredStartTime, forKey: "dateKey")
        }
    }
    
    
}


