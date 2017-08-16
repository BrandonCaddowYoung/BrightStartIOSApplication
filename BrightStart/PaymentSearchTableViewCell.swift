//
//  CustomTableViewCell.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import UIKit

class PaymentSearchTableViewCell: UITableViewCell
{
    var Payment: FinancialTransaction? {
        didSet {
            updateUI()
        }
    }
    
    var _CommonHelper: CommonHelper!
    var _ApplicationColours: ApplicatoinColours!
    
    @IBOutlet weak var LargeLeftContainer: UIView!
    
    @IBOutlet weak var TotalLabel: UILabel!
    
    @IBOutlet weak var PaymentNumberLabel: UILabel!
    
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
        
        TotalLabel.font = _ApplicationColours.XlargeFont
        PaymentNumberLabel.font = _ApplicationColours.mediumFont
        
        RegisteredAmountLabel.font = _ApplicationColours.sshmediumlFont
        NonRegisteredAmountLabel.font = _ApplicationColours.sshmediumlFont
        ExtraAmountLabel.font = _ApplicationColours.sshmediumlFont
        BalanceAmountLabel.font = _ApplicationColours.sshmediumlFont
        
        RegisterdLabel.font = _ApplicationColours.smallFont
        NonRegisteredLabel.font = _ApplicationColours.smallFont
        ExtraLabel.font = _ApplicationColours.smallFont
        BalanceLabel.font = _ApplicationColours.smallFont
        
        TotalLabel.textColor = StyleManager.theme5()
        PaymentNumberLabel.textColor = StyleManager.theme5()
        
        RegisteredAmountLabel.textColor = StyleManager.theme5()
        NonRegisteredAmountLabel.textColor = StyleManager.theme5()
        ExtraAmountLabel.textColor = StyleManager.theme5()
        BalanceAmountLabel.textColor = StyleManager.theme5()
        
        RegisterdLabel.textColor = StyleManager.theme5()
        NonRegisteredLabel.textColor = StyleManager.theme5()
        ExtraLabel.textColor = StyleManager.theme5()
        BalanceLabel.textColor = StyleManager.theme5()
        
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
        
        //Payment NUMBER LABEL
        
        PaymentNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        PaymentNumberLabel.leadingAnchor.constraint(
            equalTo: LargeLeftContainer.leadingAnchor, constant: 10).isActive = true
        
        //left
        PaymentNumberLabel.topAnchor.constraint(
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
        
    }
    
    func updateUI() {
        
        self.backgroundColor = StyleManager.theme1()
        
        if let Payment = self.Payment
        {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "HH mm ss"
            
            //dateFormatter.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
            dateFormatter.dateFormat = "h:mm a"
            
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            
            TotalLabel?.text = "£" + String(describing: Payment.TransactionAmount.roundTo(places: 2))
            PaymentNumberLabel?.text = "#" + String(describing: Payment.TransactionId)
            
            BalanceAmountLabel?.text = Payment.TransactionType
            RegisteredAmountLabel?.text = Payment.InvoiceNumber
            
            NonRegisteredAmountLabel?.text = Payment.AccountId
            NonRegisteredLabel?.text = "CHILD"
            
            ExtraAmountLabel?.text = Payment.DatePaymentHitAccount.ToStringYMD()
            
            BalanceAmountLabel.isHidden = false
            BalanceLabel.isHidden = false
            
            
            RegisteredAmountLabel.isHidden = false
            NonRegisteredAmountLabel.isHidden = false
           
            
        }
    }
    
    
}


