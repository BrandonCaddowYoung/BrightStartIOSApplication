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
    
    @IBOutlet weak var BottomContainer: UIView!
    
    @IBOutlet weak var LineInnerContainer: UIView!
    
    @IBOutlet weak var LineOuterContainer: UIView!
    
    @IBOutlet weak var LineContainer: UIView!
    
    
    @IBOutlet weak var InvoiceStartDate: UILabel!
    
    @IBOutlet weak var InvoiceEndDate: UILabel!
    
    
    
    
    override func awakeFromNib() {
        
        _CommonHelper = CommonHelper()
        _ApplicationColours = ApplicatoinColours()
        
        setupConstraints()
        
        LargeLeftContainer.backgroundColor = StyleManager.theme2()
        SmallTopLeftContainer.backgroundColor = StyleManager.theme2()
        SmallTopRightContainer.backgroundColor = StyleManager.theme2()
        SmallBottomLeftContainer.backgroundColor = StyleManager.theme2()
        SmallBottomRightContainer.backgroundColor = StyleManager.theme2()
        
        BottomContainer.backgroundColor = StyleManager.theme2()
        
        //LineOuterContainer.backgroundColor = StyleManager.theme2()
        
        LineInnerContainer.backgroundColor = StyleManager.theme2()
        
        TotalLabel.font = _ApplicationColours.XlargeFont
        InvoiceNumberLabel.font = _ApplicationColours.mediumFont
        
        InvoiceStartDate.font = _ApplicationColours.mediumFont
        InvoiceEndDate.font = _ApplicationColours.mediumFont
        
        RegisteredAmountLabel.font = _ApplicationColours.mediumFont
        NonRegisteredAmountLabel.font = _ApplicationColours.mediumFont
        ExtraAmountLabel.font = _ApplicationColours.mediumFont
        BalanceAmountLabel.font = _ApplicationColours.mediumFont
        
        RegisterdLabel.font = _ApplicationColours.smallFont
        NonRegisteredLabel.font = _ApplicationColours.smallFont
        ExtraLabel.font = _ApplicationColours.smallFont
        BalanceLabel.font = _ApplicationColours.smallFont
        
        TotalLabel.textColor = StyleManager.theme5()
        InvoiceNumberLabel.textColor = StyleManager.theme5()
        
        RegisteredAmountLabel.textColor = StyleManager.theme5()
        NonRegisteredAmountLabel.textColor = StyleManager.theme5()
        ExtraAmountLabel.textColor = StyleManager.theme5()
        BalanceAmountLabel.textColor = StyleManager.theme5()
        
        RegisterdLabel.textColor = StyleManager.theme5()
        NonRegisteredLabel.textColor = StyleManager.theme5()
        ExtraLabel.textColor = StyleManager.theme5()
        BalanceLabel.textColor = StyleManager.theme5()
        
        InvoiceStartDate.textColor = StyleManager.theme5()
        InvoiceEndDate.textColor = StyleManager.theme5()
        
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
        
        //LargeLeftContainer.bottomAnchor.constraint(
        //  equalTo: contentView.bottomAnchor).isActive = true
        
        
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
            equalToConstant: 75).isActive = true
        
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
            equalToConstant: 75).isActive = true
        
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
            equalToConstant: 75).isActive = true
        
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
            equalToConstant: 75).isActive = true
        
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
        
        
        
        
        
        
        BottomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        BottomContainer.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor).isActive = true
        
        //left
        BottomContainer.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor).isActive = true
        
        //height
        BottomContainer.heightAnchor.constraint(
            equalToConstant: 50).isActive = true
        
        BottomContainer.topAnchor.constraint(
            equalTo: LargeLeftContainer.bottomAnchor).isActive = true
        
        BottomContainer.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor).isActive = true
        
        
        
        
        
        
        LineOuterContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        LineOuterContainer.centerXAnchor.constraint(
            equalTo: contentView.centerXAnchor).isActive = true
        
        //width
        LineOuterContainer.widthAnchor.constraint(
            equalTo: contentView.widthAnchor, multiplier: 0.85).isActive = true
        
        //height
        LineOuterContainer.heightAnchor.constraint(
            equalTo: BottomContainer.heightAnchor, multiplier: 0.30).isActive = true
        
        LineOuterContainer.bottomAnchor.constraint(
            equalTo: BottomContainer.bottomAnchor, constant: -5).isActive = true
        
        
        
        
        
        
        
        
        LineInnerContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        LineInnerContainer.centerXAnchor.constraint(
            equalTo: LineOuterContainer.centerXAnchor).isActive = true
        
        //center
        LineInnerContainer.centerYAnchor.constraint(
            equalTo: LineOuterContainer.centerYAnchor).isActive = true
        
        //thicknes
        
        //width
        LineInnerContainer.widthAnchor.constraint(
            equalTo: LineOuterContainer.widthAnchor, multiplier: 0.98).isActive = true
        
        //height
        LineInnerContainer.heightAnchor.constraint(
            equalTo: LineOuterContainer.heightAnchor).isActive = true
        
        
        
        
        LineContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        LineContainer.centerXAnchor.constraint(
            equalTo: LineOuterContainer.centerXAnchor).isActive = true
        
        //center
        LineContainer.centerYAnchor.constraint(
            equalTo: LineOuterContainer.centerYAnchor).isActive = true
        
        //width
        LineContainer.widthAnchor.constraint(
            equalTo: LineOuterContainer.widthAnchor).isActive = true
        
        //thicknes
        
        //height
        LineContainer.heightAnchor.constraint(
            equalToConstant: 3).isActive = true
        
        
        
        
        
        InvoiceStartDate.translatesAutoresizingMaskIntoConstraints = false
        
        InvoiceStartDate.leadingAnchor.constraint(
            equalTo: LineOuterContainer.leadingAnchor).isActive = true
        
        InvoiceStartDate.bottomAnchor.constraint(
            equalTo: LineOuterContainer.topAnchor).isActive = true
        
        InvoiceStartDate.textAlignment = .left
        
        
        
        
        
        InvoiceEndDate.translatesAutoresizingMaskIntoConstraints = false
        
        InvoiceEndDate.trailingAnchor.constraint(
            equalTo: LineOuterContainer.trailingAnchor).isActive = true
        
        InvoiceEndDate.bottomAnchor.constraint(
            equalTo: LineOuterContainer.topAnchor).isActive = true
        
        InvoiceEndDate.textAlignment = .right
        
        
        
        
    }
    
    
    
    func updateUI() {
        
        self.backgroundColor = StyleManager.theme1()
        
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
            
            TotalLabel?.text = "£" + String(describing: invoice.InvoiceTotal.roundTo(places: 2))
            InvoiceNumberLabel?.text = "#" + String(describing: invoice.InvoiceNumber)
            
            var (h, m, s) = _CommonHelper.secondsToHoursMinutesSeconds (seconds: Int(invoice.Registered_Time_Minutes * 60))
            RegisteredAmountLabel?.text = String(h) + "H " + String(m) + "M"
            
            (h, m, s) = _CommonHelper.secondsToHoursMinutesSeconds (seconds: Int(invoice.NonRegistered_Time_Minutes * 60))
            NonRegisteredAmountLabel?.text = String(h) + "H " + String(m) + "M"
            
            (h, m, s) = _CommonHelper.secondsToHoursMinutesSeconds (seconds: Int((invoice.Early_Time_Minutes + invoice.Late_Time_Minutes) * 60))
            ExtraAmountLabel?.text = String(h) + "H " + String(m) + "M"
            
            BalanceAmountLabel?.text = "£" + String(describing: invoice.InvoiceBalance.roundTo(places: 2))
            BalanceAmountLabel.isHidden = false
            BalanceLabel.isHidden = false
            
            InvoiceStartDate.text = invoice.Start_Date.ToString()
            InvoiceEndDate.text = invoice.End_Date.ToString()
            
            // UserDefaults.standard.set(child.RegisteredFinishTime, forKey: "finishTime")
            //UserDefaults.standard.set(child.RegisteredStartTime, forKey: "dateKey")
            
            //The words start and end need to go below the dates.
            LineContainer.isHidden = true
            LineInnerContainer.isHidden = true
            LineOuterContainer.isHidden = true
            
        }
    }
    
    
}


