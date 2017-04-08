//
//  RegisteredHoursWeekly_Step2ViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 06/04/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class RegisteredHoursWeekly_Step3ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    @IBOutlet weak var MainHeadingLabel: UILabel!
    
    @IBOutlet weak var SelectLabel: UILabel!
    
    @IBOutlet weak var Top: UIView!
    
    @IBOutlet weak var UpperHeading: UIView!
    
    @IBOutlet weak var UpperContent: UIView!
    
    @IBOutlet weak var Bottom: UIView!
    
    @IBOutlet weak var KeyWorkerTable: UITableView!
    
    var numberArray = Array<WeekDay>()
    var selectedArray = Array<WeekDay>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        self.hideKeyboardWhenTappedAround()
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        setupConstraints()
        
        self.KeyWorkerTable.delegate = self
        self.KeyWorkerTable.dataSource = self
        
        let monday = WeekDay()
        monday.DayName = "Monday"
        monday.DayNumber = 1
        
        self.numberArray.append(monday)
        
        let tuesday = WeekDay()
        tuesday.DayName = "Tuesday"
        tuesday.DayNumber = 2
        
        self.numberArray.append(tuesday)
        
        let wednesday = WeekDay()
        wednesday.DayName = "Wednesday"
        wednesday.DayNumber = 3
        
        self.numberArray.append(wednesday)
        
        let thursday = WeekDay()
        thursday.DayName = "Thursday"
        thursday.DayNumber = 4
        
        self.numberArray.append(thursday)
        
        let friday = WeekDay()
        friday.DayName = "Friday"
        friday.DayNumber = 5
        
        self.numberArray.append(friday)
        
        let saturday = WeekDay()
        saturday.DayName = "Saturday"
        saturday.DayNumber = 6

        self.numberArray.append(saturday)
        
        let sunday = WeekDay()
        sunday.DayName = "Sunday"
        sunday.DayNumber = 7
        
        self.numberArray.append(sunday)
        
        Top.backgroundColor = _ApplicatoinColours.White
        
        UpperHeading.backgroundColor = _ApplicatoinColours.White
        
        UpperContent.backgroundColor = _ApplicatoinColours.White
        
        Bottom.backgroundColor = _ApplicatoinColours.White
        
    }
    
    
    func setupConstraints() {
        
        //Top
        
        Top.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        Top.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        Top.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //top
        Top.topAnchor.constraint(
            equalTo: view.topAnchor).isActive = true
        
        //height
        Top.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        
        //Heading label
        
        MainHeadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        MainHeadingLabel.centerYAnchor.constraint(
            equalTo: Top.centerYAnchor).isActive = true
        
        //center
        MainHeadingLabel.trailingAnchor.constraint(
            equalTo: Top.trailingAnchor, constant: -15).isActive = true
        
        MainHeadingLabel.widthAnchor.constraint(
            equalTo: Top.widthAnchor, multiplier: 0.70).isActive = true
        
        MainHeadingLabel.textAlignment = .right
        
        MainHeadingLabel.adjustsFontSizeToFitWidth = true
        
        
        //Upper Heading
        
        UpperHeading.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        UpperHeading.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        UpperHeading.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //top
        UpperHeading.topAnchor.constraint(
            equalTo: Top.bottomAnchor).isActive = true
        
        //height
        UpperHeading.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        //Name Label
        
        SelectLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        SelectLabel.centerYAnchor.constraint(
            equalTo: UpperHeading.centerYAnchor).isActive = true
        
        //width
        SelectLabel.widthAnchor.constraint(
            equalTo: UpperHeading.widthAnchor).isActive = true
        
        //left
        SelectLabel.leadingAnchor.constraint(
            equalTo: UpperHeading.leadingAnchor, constant: 20 ).isActive = true
        
        
        //Bottom
        
        Bottom.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        Bottom.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        Bottom.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //bottom
        Bottom.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        
        //height
        Bottom.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        //Upper Content
        
        UpperContent.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        UpperHeading.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        UpperContent.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //top
        UpperContent.topAnchor.constraint(
            equalTo: UpperHeading.bottomAnchor).isActive = true
        
        //height
        UpperContent.bottomAnchor.constraint(
            equalTo: Bottom.topAnchor).isActive = true
        
        //Table
        
        KeyWorkerTable.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        KeyWorkerTable.centerXAnchor.constraint(
            equalTo: UpperContent.centerXAnchor).isActive = true
        
        //center
        KeyWorkerTable.centerYAnchor.constraint(
            equalTo: UpperContent.centerYAnchor).isActive = true
        
        //width
        KeyWorkerTable.widthAnchor.constraint(
            equalTo: UpperContent.widthAnchor, multiplier: 0.90).isActive = true
        
        //height
        KeyWorkerTable.heightAnchor.constraint(
            equalTo: UpperContent.heightAnchor).isActive = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func tickClicked(sender: UIButton!)
    {
        
        let value = sender.tag;
        
        print(value)
        
        
        if(selectedArray.contains( where: { $0 === numberArray[value] } )){
            
            let indexOfChild = selectedArray.index{$0 === numberArray[value]}
            
            //remove
            selectedArray.remove(at: indexOfChild!)
        }
        else
        {
            //add
            selectedArray.append(numberArray[value])
        }
        
        KeyWorkerTable.reloadData()
        
    }
    
    /////NUMBER OF ROWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return numberArray.count;
        
    }
    /////CELL FOR ROW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //let contact = numberArray.object(at: indexPath.row)
        let contact = numberArray[indexPath.row]
        
        let cell:ListItemCell = KeyWorkerTable.dequeueReusableCell(withIdentifier: "reuseCell") as! ListItemCell
        
        var selectedChild = WeekDay()
        selectedChild = contact
        
        cell.textLabel?.text = contact.DayName
        
        cell.textLabel?.font = _ApplicatoinColours.sshmediumlFont
        cell.textLabel?.textColor = _ApplicatoinColours.Blue
        
        cell.tickButton.addTarget(self, action:#selector(CreateChild_Quick_3ViewController.tickClicked(sender:)), for: .touchUpInside)
        
        cell.tickButton.tag=indexPath.row
        
        if(selectedArray.contains( where: { $0 === contact } )){
            cell.tickButton.setBackgroundImage(UIImage(named:"Rocket"), for: UIControlState.normal)
        }
        else
        {
            cell.tickButton.setBackgroundImage(UIImage(named:"star"), for: UIControlState.normal)
        }
        
        cell.tickButton.titleLabel?.text = ""
        
        return cell
    }
    /////HEIGHT FOR ROW
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) ->CGFloat
    {
        return 80.0
    }
    
}
