//
//  MainMenuViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 05/12/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    var collectionView: UICollectionView!
    var topThirdView: UIView!
    
    var leftSpacer: UIView!
    var rightSpacer: UIView!
    
    var headingLabel: UILabel!
    var bodyLabel: UILabel!
    
    var images = [UIImage(named: "Billing"), UIImage(named: "TimeStamps"),UIImage(named: "RegisteredHours"),UIImage(named: "Register")]
    let DisplayTextList = ["Billing", "TimeStamps", "RegisteredHours", "Register"]

    let segueIdList = ["GoToBilling", "GoToTimeStamps", "GoToRegisteredHours", "GoToRegister"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        
        // Do any additional setup after loading the view.
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
        
        
        
        
        
        
        let commonHelper = CommonHelper()
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 60
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(MainMenuButtonCollectionViewCell.self, forCellWithReuseIdentifier: "mainMenuButtonCell")
        collectionView.backgroundColor = commonHelper.hexStringToUIColor(hex: "#37A0e6")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //For some reason above the collectionView there is space, this removes the space.
       // self.automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(collectionView)
        
        topThirdView = UIView()
        view.addSubview(topThirdView)
        
        headingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        headingLabel.text = "MENU"
        headingLabel.textColor = .white
        
        view.addSubview(headingLabel)
        
        bodyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bodyLabel.text = "Below are a list of our many features that can help your run your nursery. Choose one by touching the buttons below."
        
        bodyLabel.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        bodyLabel.numberOfLines = 3
        bodyLabel.textColor = .white
        
        view.addSubview(bodyLabel)
        
        setupConstraints()
        
    }
    
    func setupConstraints()
    {
        //The first view takes up a third of the screen.
        
        let commonHelper = CommonHelper()
        
        
        leftSpacer.backgroundColor = commonHelper.hexStringToUIColor(hex: "#37A0e6")
        leftSpacer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        leftSpacer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        //top
        leftSpacer.topAnchor .constraint(
            equalTo: view.layoutMarginsGuide.topAnchor, constant: 25).isActive = true
        //bottom
        leftSpacer.bottomAnchor .constraint(
            equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        leftSpacer.widthAnchor.constraint(
            equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
        
        rightSpacer.backgroundColor = commonHelper.hexStringToUIColor(hex: "#37A0e6")
        rightSpacer.translatesAutoresizingMaskIntoConstraints = false
        
        //right
        rightSpacer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        //top
        rightSpacer.topAnchor .constraint(
            equalTo: view.layoutMarginsGuide.topAnchor, constant: 25).isActive = true
        //bottom
        rightSpacer.bottomAnchor .constraint(
            equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        rightSpacer.widthAnchor.constraint(
            equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
        
        
        
        
        
        
        
        
        
        
        
        
        
        topThirdView.translatesAutoresizingMaskIntoConstraints = false
        topThirdView.backgroundColor = commonHelper.hexStringToUIColor(hex: "#37A0e6")

        //left
        topThirdView.leadingAnchor.constraint(
            equalTo: leftSpacer.trailingAnchor).isActive = true
        //right
        topThirdView.trailingAnchor.constraint(
            equalTo: rightSpacer.leadingAnchor).isActive = true
        //top
        topThirdView.topAnchor .constraint(
            equalTo: view.layoutMarginsGuide.topAnchor, constant: 25).isActive = true
        //height
        topThirdView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.33).isActive = true
        
        
        
        
        
        
        
        //Now addin the menu label the top left
        
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //bottom
        headingLabel.topAnchor.constraint(
            equalTo: topThirdView.topAnchor).isActive = true
        //left
        headingLabel.leadingAnchor.constraint(
            equalTo: leftSpacer.trailingAnchor).isActive = true
        //right
        headingLabel.trailingAnchor.constraint(
            equalTo: rightSpacer.leadingAnchor).isActive = true
        
        headingLabel.addConstraint(NSLayoutConstraint(item: headingLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 21))
        
        //Now adding the body label the top left
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //bottom
        bodyLabel.centerXAnchor.constraint(
            equalTo: topThirdView.centerXAnchor).isActive = true
        
        bodyLabel.centerYAnchor.constraint(
            equalTo: topThirdView.centerYAnchor).isActive = true
        
        
        bodyLabel.widthAnchor.constraint(
            equalTo: topThirdView.widthAnchor).isActive = true
        
      
        
        
        
        bodyLabel.addConstraint(NSLayoutConstraint(item: bodyLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 400))
        

        
        
        
        //The second view takes up the remining 66% of the screen
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //collectionView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
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
        
        
        
        
        
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
