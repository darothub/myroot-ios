//
//  TypeOfOccasion.swift
//  myrootsinafrica
//
//  Created by Darot on 22/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit


class TypeOfOccasionViewController : UIViewController{

    private lazy var container = self.createView(with: .clear)
    private lazy var scroller = self.createScrollView()
    lazy var header = self.createUIlabelBold(with: "occasionHeader".localized, and: 22.0, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    lazy var subHeader = self.createUIlabelBold(with: "occasionSubHeader".localized, and: 16.0, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    lazy var viewHeight = container.frame.height
    lazy var viewWidth = container.frame.width
    
    private lazy var topBoardView = self.createCustomView(with: .clear, height: viewHeight/3.5, width: 0)
    private lazy var birthdayCard = self.createCustomView(with: .clear, height: 125, width: 114)
    lazy var birthdayImage = self.createImageView(with: #imageLiteral(resourceName: "giftnew-1"))
    lazy var birthdayTitle = self.createUIlabel(with: "birthday".localized, and: 16.0, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    private lazy var anniversaryCard = self.createCustomView(with: .clear, height: 125, width: 114)
    lazy var anniversaryImage = self.createImageView(with: #imageLiteral(resourceName: "champagnenew"))
    lazy var anniversaryTitle = self.createUIlabel(with: "anniversary".localized, and: 16.0, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    
    private lazy var bottomBoardView = self.createCustomView(with: .clear, height: viewHeight/3.5, width: 0)
    private lazy var holidayCard = self.createCustomView(with: .clear, height: 125, width: 114)
    lazy var holidayImage = self.createImageView(with: #imageLiteral(resourceName: "umbrellanew"))
    lazy var holidayTitle = self.createUIlabel(with: "holiday".localized, and: 16.0, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    private lazy var otherCard = self.createCustomView(with: .clear, height: 125, width: 114)
    lazy var otherImage = self.createImageView(with: #imageLiteral(resourceName: "other"))
    lazy var otherTitle = self.createUIlabel(with: "other".localized, and: 16.0, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    lazy var nextUIButton = self.createButton(with: "next".localized, and: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), action: #selector(tapToMoveToNext))

    var tree:Tree?
    var selectedOccasion = ""
    let birthday = "birthday".localized
    let anniversary = "anniversary".localized
    let holiday = "holiday".localized
    let other = "other".localized
    override func viewDidLoad() {
        print("Type of occasion")
        print("tree\(tree)")
        
        addViews()
        setViewConstraints()
        
        self.setupProgressBarXclusive(progress: 0.6, progressTintcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), trackTintColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
        
        tapInitiation(view: birthdayCard, action: #selector(self.tapDetectedForBirthday))
        tapInitiation(view: anniversaryCard, action: #selector(self.tapDetectedForAnniversary))
        tapInitiation(view: holidayCard, action: #selector(self.tapDetectedForHoliday))
        tapInitiation(view: otherCard, action: #selector(self.tapDetectedForOther))
        
        self.addCustomBackButton(action: #selector(self.gotoScene), color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        
        scroller.layer.contents = #imageLiteral(resourceName: "generalBackground").cgImage
        view.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1)
    }
    
    @objc override func gotoScene() {
        self.moveToDestination(with: "reasonScene")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    @objc func tapDetectedForBirthday(){
         
        if birthdayCard.showSelectorCard() {
            anniversaryCard.unSelectCard()
            holidayCard.unSelectCard()
            otherCard.unSelectCard()
            selectedOccasion = birthday
            
        }
     }
    
    @objc func tapDetectedForAnniversary(){
        if anniversaryCard.showSelectorCard(){
            holidayCard.unSelectCard()
            otherCard.unSelectCard()
            birthdayCard.unSelectCard()
            selectedOccasion = anniversary
        }
         
    }
    
    @objc func tapDetectedForHoliday(){
        if holidayCard.showSelectorCard(){
            otherCard.unSelectCard()
            birthdayCard.unSelectCard()
            anniversaryCard.unSelectCard()
            selectedOccasion = holiday
        }
     
    }
    
    @objc func tapDetectedForOther(){
        if otherCard.showSelectorCard(){
            birthdayCard.unSelectCard()
            anniversaryCard.unSelectCard()
            holidayCard.unSelectCard()
            selectedOccasion = other
        }
    }
    
    func tapInitiation(view:UIView, action: Selector){
        let singleTap = UITapGestureRecognizer(target: self, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
    }
    @objc func tapToMoveToNext(_ sender: Any) {
        print(selectedOccasion)
         if selectedOccasion == "" {
             self.showToastMessage(message: "Kindly pick an occasion", font: UIFont(name: "BalooChetan2-Regular", size: 12.0))
         }
         else{
            tree?.occasion = selectedOccasion
             self.performSegue(withIdentifier: "toHowToPlantScene", sender: tree)
         }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let vc = segue.destination as? HowToPlantViewController, let tree = sender as? Tree{
             //
             vc.tree = tree
             print("treeinprepare \(tree)")
         }
         
     }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.transparentNavBar()
    }
    
    //MARK: add views
    private func addViews(){
        
        view.addSubview(self.scroller)
        scroller.edgesToSuperview()
        scroller.addSubview(self.container)
//        scroller.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1)
        customAddToSubView(parent:container, views: header, subHeader, topBoardView, bottomBoardView, nextUIButton)
        
        customAddToSubView(parent: topBoardView, views: birthdayCard, birthdayTitle, anniversaryCard, anniversaryTitle)
        customAddToSubView(parent: bottomBoardView, views: holidayCard, holidayTitle, otherCard, otherTitle )
        
        birthdayCard.addSubview(birthdayImage)
        anniversaryCard.addSubview(anniversaryImage)
        holidayCard.addSubview(holidayImage)
        otherCard.addSubview(otherImage)
        
    
       
    }
    
     //MARK: set constraints
    private func setViewConstraints() {
        header.centerX(to: container)
        header.top(to: self.container, offset: viewHeight/45, isActive: true)
        subHeader.centerX(to: container)
        subHeader.top(to: header, offset: 50, isActive: true)
        boardContainerViews(view: topBoardView, centerAnchorView: container, topAnchorView: subHeader, topOffset: 20)
        nextUIButton.centerX(to: container)
        nextUIButton.left(to: self.container, offset: viewHeight/10, isActive: true)
        nextUIButton.top(to: bottomBoardView, offset: viewHeight/3.5+20, isActive: true)
        nextUIButton.setTitleColor(#colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1), for: .normal)
        setLeftConstraintOnContainer(parent: topBoardView, view: birthdayCard, imageView: birthdayImage, title: birthdayTitle)
        setLeftConstraintOnContainer(parent: bottomBoardView, view: holidayCard, imageView: holidayImage, title: holidayTitle)
        setRightConstraintOnContainer(parent: topBoardView, view: anniversaryCard, imageView: anniversaryImage, title: anniversaryTitle)
        setRightConstraintOnContainer(parent: bottomBoardView, view: otherCard, imageView: otherImage, title: otherTitle)
        
        boardContainerViews(view: bottomBoardView, centerAnchorView: container, topAnchorView: topBoardView, topOffset: viewHeight/3.5)
        
  
        
    }
    
    func setLeftConstraintOnContainer(parent:UIView, view:UIView, imageView:UIImageView, title:UILabel){
        view.centerY(to: parent)
        view.left(to: parent, offset: 15, isActive: true)
        imageView.size(CGSize(width: 75, height: 75))
        imageView.center(in: view)
        title.bottom(to: parent, offset: -10, isActive: true)
        title.centerX(to: view)
        
    }
    func setRightConstraintOnContainer(parent:UIView, view:UIView, imageView:UIImageView, title:UILabel){
        view.centerY(to: parent)
        view.right(to: parent, offset: -15, isActive: true)
        imageView.size(CGSize(width: 75, height: 75))
        imageView.center(in: view)
        title.bottom(to: parent, offset: -10, isActive: true)
        title.centerX(to: view)
        
    }
    
    private func boardContainerViews(view:UIView, centerAnchorView:UIView, topAnchorView:UIView, topOffset:CGFloat){
         view.centerX(to: centerAnchorView)
         view.top(to: topAnchorView, offset: topOffset, isActive: true)
         view.right(to: self.container, offset: -30, isActive: true)
         view.left(to: self.container, offset: 30, isActive: true)
     }
}
