//
//  MainMenuViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    var _ApplicatoinColours: ApplicatoinColours!
    
    var collectionView: UICollectionView!
    var topThirdView: UIView!
    
    var topThirdViewTopSpacer: UIView!
    var topThirdViewMiddleSpacer: UIView!
    
    var leftSpacer: UIView!
    var rightSpacer: UIView!
    
    var headingLabel: UILabel!
    //var bodyLabel: UILabel!
    
    var images = [UIImage(named: "Register"), UIImage(named: "Forecast"), UIImage(named: "Information"), UIImage(named: "SignOut")]
    
    var DisplayTextList = ["Register",  "Forecast", "Informaiton", "Sign Out"]

    var segueIdList = ["GoToRegister", "GoToForecast", "GoToInformation", "GoToSignIn"]
    
    var showNavigationBar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _ApplicatoinColours = ApplicatoinColours()
        
        setupCollectionView()
        
        //Changes the color of the backgorund within the nav bar.
        navigationController?.navigationBar.barTintColor = _ApplicatoinColours.NavigationBarBackGroundColor
        
        //Changes the color of the text within the nav bar
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = _ApplicatoinColours.FontColour
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Initialising a collection view and addit it to the view controllers current view
    func setupCollectionView()
    {
        leftSpacer = UIView()
        view.addSubview(leftSpacer)
        
        rightSpacer = UIView()
        view.addSubview(rightSpacer)
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 30
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(MainMenuButtonCollectionViewCell.self, forCellWithReuseIdentifier: "mainMenuButtonCell")
        
        collectionView.contentInset  = UIEdgeInsets();
        collectionView.contentInset.left = 25
        collectionView.contentInset.right = 25
       
        collectionView.backgroundColor = _ApplicatoinColours.BackGroundColour
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //For some reason above the collectionView there is space, this removes the space.
       // self.automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(collectionView)
        
        topThirdView = UIView()
        view.addSubview(topThirdView)
        
        topThirdViewTopSpacer = UIView()
        view.addSubview(topThirdViewTopSpacer)
        
        topThirdViewMiddleSpacer = UIView()
        view.addSubview(topThirdViewMiddleSpacer)
        
        headingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        headingLabel.text = "Menu"
        
        headingLabel.font = UIFont(name: "Helvetica Neue", size: _ApplicatoinColours.MenuHeadingFontSize)
        headingLabel.font = UIFont.systemFont(ofSize: _ApplicatoinColours.MenuHeadingFontSize, weight: UIFontWeightThin)
        
        headingLabel.textColor = _ApplicatoinColours.FontColour
        
        view.addSubview(headingLabel)
        
        setupConstraints()
        
    }
    
    func setupConstraints()
    {
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        //The first view takes up a third of the screen.
        
        leftSpacer.backgroundColor = _ApplicatoinColours.BackGroundColour
        leftSpacer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        leftSpacer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        //top
        leftSpacer.topAnchor .constraint(
            equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        //bottom
        leftSpacer.bottomAnchor .constraint(
            equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        leftSpacer.widthAnchor.constraint(
            equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
        
        //leftSpacer.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        rightSpacer.backgroundColor = _ApplicatoinColours.BackGroundColour
        rightSpacer.translatesAutoresizingMaskIntoConstraints = false
        
        //right
        rightSpacer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        //top
        rightSpacer.topAnchor .constraint(
            equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        //bottom
        rightSpacer.bottomAnchor .constraint(
            equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        rightSpacer.widthAnchor.constraint(
            equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
        
        
        //rightSpacer.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        topThirdView.translatesAutoresizingMaskIntoConstraints = false
        topThirdView.backgroundColor = _ApplicatoinColours.BackGroundColour

        //left
        topThirdView.leadingAnchor.constraint(
            equalTo: leftSpacer.trailingAnchor).isActive = true
        //right
        topThirdView.trailingAnchor.constraint(
            equalTo: rightSpacer.leadingAnchor).isActive = true
        //top
        topThirdView.topAnchor .constraint(
            equalTo: topLayoutGuide.bottomAnchor).isActive = true
        //height
        topThirdView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.10).isActive = true
        
        
       //topThirdView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        topThirdViewTopSpacer.translatesAutoresizingMaskIntoConstraints = false
        topThirdViewTopSpacer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        //left
        topThirdViewTopSpacer.leadingAnchor.constraint(
            equalTo: leftSpacer.trailingAnchor).isActive = true
        //right
        topThirdViewTopSpacer.trailingAnchor.constraint(
            equalTo: rightSpacer.leadingAnchor).isActive = true
       
        //top
        topThirdViewTopSpacer.topAnchor .constraint(
            equalTo: topThirdView.topAnchor).isActive = true
        
        //height
        topThirdViewTopSpacer.heightAnchor.constraint(
            equalTo: topThirdView.heightAnchor,
            multiplier: 0.25).isActive = true
        
        //topThirdViewTopSpacer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        //Now addin the menu label the top left
        
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //top
        headingLabel.topAnchor.constraint(
            equalTo: topThirdViewTopSpacer.bottomAnchor).isActive = true
        
        //left
        //headingLabel.leadingAnchor.constraint(
          //  equalTo: leftSpacer.trailingAnchor).isActive = true
        //right
        //headingLabel.trailingAnchor.constraint(
          //  equalTo: rightSpacer.leadingAnchor).isActive = true
        
        headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        headingLabel.addConstraint(NSLayoutConstraint(item: headingLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 21))
        
        topThirdViewMiddleSpacer.translatesAutoresizingMaskIntoConstraints = false
        topThirdViewMiddleSpacer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        //left
        topThirdViewMiddleSpacer.leadingAnchor.constraint(
            equalTo: leftSpacer.trailingAnchor).isActive = true
        //right
        topThirdViewMiddleSpacer.trailingAnchor.constraint(
            equalTo: rightSpacer.leadingAnchor).isActive = true
        //top
        topThirdViewMiddleSpacer.topAnchor .constraint(
            equalTo: headingLabel.bottomAnchor).isActive = true
        
        //height
        topThirdViewMiddleSpacer.heightAnchor.constraint(
            equalTo: topThirdView.heightAnchor,
            multiplier: 0.15).isActive = true
        
        //The second view takes up the remining 66% of the screen
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
                //left
        collectionView.leadingAnchor.constraint(
            equalTo: leftSpacer.trailingAnchor).isActive = true
        //right
        collectionView.trailingAnchor.constraint(
            equalTo: rightSpacer.leadingAnchor).isActive = true
        //bottom
        collectionView.bottomAnchor .constraint(
            equalTo: view.bottomAnchor).isActive = true
        //top
        collectionView.topAnchor.constraint(
            equalTo: topThirdView.bottomAnchor).isActive = true
        
        //Adding the heading label to the top left
        
        // collectionView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
    }
    
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToTimeStampsMenu") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? TimeStampsMenuController {
                
                //vc.images = [UIImage(named: "Search"), UIImage(named: "Edit"), UIImage(named: "Delete"), UIImage(named: "Home"), UIImage(named: "SignOut")]
                
               // vc.segueIdList = ["GoToSearchPerson_Search", "GoToSearchPerson_Edit", "GoToSearchPerson_Delete", "GoToMainMenu", "GoToSignIn"]
                
                //vc.DisplayTextList = ["Search",  "Edit", "Delete", "Home", "Sign Out"]
                
                vc.images = [UIImage(named: "Search"), UIImage(named: "Edit"), UIImage(named: "Delete"), UIImage(named: "Expired"), UIImage(named: "Home"), UIImage(named: "SignOut")]
                
                vc.segueIdList = ["GoToSearchPerson_Search", "GoToSearchPerson_Edit", "GoToSearchPerson_Delete", "GoToSearchPerson_ExtraMinutes", "GoToMainMenu", "GoToSignIn"]
                
                vc.DisplayTextList = ["Search",  "Edit", "Delete", "Late/Early", "Home", "Sign Out"]
                
                vc.showNavigationBar = true
                
            }
        }
    }
    
}

extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Specifying the number of sections in the collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Specifying the number of cells in the given section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    //We use this method to dequeue the cell and set it up
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainMenuButtonCell", for: indexPath) as! MainMenuButtonCollectionViewCell
        cell.awakeFromNib()
        cell.delegate = self
        
        cell.setDisplayText(newDisplayText: DisplayTextList[indexPath.row])
        cell.segueText = segueIdList[indexPath.row]
        
        
        return cell
    }
    
    //We use this method to populate the data of a given cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let foodCell = cell as! MainMenuButtonCollectionViewCell
        foodCell.button.setBackgroundImage(images[indexPath.row], for: .normal)
    }
    
    //Sets the size of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    //Removes the navigation bar from the top
    override func viewWillDisappear(_ animated: Bool) {
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(false, animated: animated);
            super.viewWillDisappear(animated)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
         if(!showNavigationBar){
            super.viewWillAppear(animated)
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        
    }
    
}

extension MainMenuViewController: MainMenuButtonCollectionViewCellDelegate {
    
    func changeColorOfButton(forCell: MainMenuButtonCollectionViewCell) {
        //forCell.button.backgroundColor = UIColor.blue
    }
    
    func performSegue(segueId: String) {
        self.performSegue(withIdentifier: segueId, sender: self)
    }
}
