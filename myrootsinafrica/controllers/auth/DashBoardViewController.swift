//
//  DashBoardViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 19/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData
import Alamofire
import RxSwift
import SwiftyJSON
import RealmSwift


class DashBoardViewController : UIViewController{
    
    var tokens = ""
    var user:User?

    private lazy var container = self.createView(with: .clear)
    private lazy var scroller = self.createScrollView()
    
    lazy var viewHeight = container.frame.height
    lazy var viewWidth = container.frame.width
    lazy var circleView = self.createCustomView(with: .white, height: 50, width: 50)
    lazy var profileIcon = self.createImageView(with: #imageLiteral(resourceName: "profileicon"))
    
    lazy var topBoardView = self.createCustomView(with: .white, height: viewHeight/8, width: 0)
    lazy var topBoardViewImage = self.createImageView(with: #imageLiteral(resourceName: "topboardLeaf"))
    lazy var countryLabel = self.createUIlabelBold(with: NSLocalizedString("countryLabel", comment: "54 countries"), and: 16.0, color: #colorLiteral(red: 0.7607843137, green: 0.862745098, blue: 0, alpha: 1))
    lazy var countryCountLabel = self.createUIlabelBold(with: NSLocalizedString("number", comment: "tree count"), and: viewHeight/23, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    lazy var topBoardViewAdvice = self.createUIlabel(with: NSLocalizedString("topBoardAdvice", comment: "transaction update"), and: 14, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    
    lazy var bottomBoardView = self.createCustomView(with: .white, height: viewHeight/8, width: 0)
    lazy var bottomBoardViewImage = self.createImageView(with: #imageLiteral(resourceName: "bottomboardLeaf"))
    lazy var ggwLabel = self.createUIlabelBold(with: NSLocalizedString("ggwLabel", comment: "Great green wall"), and: 16.0, color: #colorLiteral(red: 0.7607843137, green: 0.862745098, blue: 0, alpha: 1))
    lazy var ggwCountLabel = self.createUIlabelBold(with: NSLocalizedString("number", comment: "tree count"), and: viewHeight/23, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    lazy var bottomBoardViewAdvice = self.createUIlabel(with: NSLocalizedString("bottomBoardAdvice", comment: "transaction update"), and: 14, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    lazy var greetingLabel = self.createUIlabelBold(with: NSLocalizedString("greeting", comment: "greetings according to the time of the day"), and: 23.0, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    lazy var statementLabel = self.createUIlabel(with: NSLocalizedString("plantingStatement", comment: "Plant a new tree ..."), and: 13.0, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    lazy var reserveATreeLabel = self.createUIlabelBold(with: NSLocalizedString("reserveText", comment: "Reserve a new tree ...").uppercased(), and: viewHeight/55, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    
    lazy var buttonView = self.createCustomView(with: #colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1), height: viewHeight/15, width: 0)
    lazy var pointingHandImage = self.createImageView(with: #imageLiteral(resourceName: "handpointingRight-1"))
    
    
    var tree:Tree?
  
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<UserData>(entityName: "UserData")
    
    let authViewModel = AuthViewModel(authProtocol: AuthService())
    var disposeBag = DisposeBag()

    lazy var loggedInPerson:User = {
        realm.objects(User.self).filter("loggedIn == true").first!
    }()
    let realm = try! Realm()

    var loggedInUser:UserData?
    
    lazy var date :Date = {
        return Date()
        
    }()
    let units: Set<Calendar.Component> = [.hour]
    lazy var comps:DateComponents={
        return Calendar.current.dateComponents(units, from: date)
    }()
    lazy var hour = {
        return self.comps.hour!
    }()
    
    override func viewDidLoad() {
        
       

        self.navigationItem.setHidesBackButton(true, animated: true)
        circleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDetectedForProfile(_ :))))
//
        buttonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToMoveToNext(_ :))))
        
        
        view.layer.contents = #imageLiteral(resourceName: "dashboardBackground").cgImage
        addViews()
        setViewConstraints()
        setCornerRadius()

     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
//        loggedInPerson = {
//            realm.objects(User.self).filter("name == '\(user!.email!)'")
//        }()
    
        let name = {
            self.loggedInPerson.name
        }()
        
        timeMonitor(name:name!, hour:hour)
        
        
        var token: String {
            self.loggedInPerson.token!
        }
        
        
        authViewModel.getUserTrees(token: token).subscribe(onNext: { (TreeResponse) in


            guard let countriesTreesCount = TreeResponse.payload?.countries.count else{
                fatalError("Invalid tree counts for countries")
            }
            guard let ggwTreesCount = TreeResponse.payload?.greenWall.count else{
                fatalError("Invalid tree counts for ggw")
            }
            print("error \(String(describing: TreeResponse.error))")
            print("message \(String(describing: TreeResponse.message))")

            print("countries \(String(describing: countriesTreesCount))")
            print("ggw \(String(describing: ggwTreesCount))")

            self.countryCountLabel.text = "\(countriesTreesCount)"
            self.ggwCountLabel.text = "\(ggwTreesCount)"

            let countryCounter = Counter.one(countriesTreesCount)
            switch countryCounter {
            case .one(countriesTreesCount)where countriesTreesCount == 1:self.topBoardViewAdvice.text = "\("youHave".localized) \(countriesTreesCount) \("treePlanted".localized) \(countriesTreesCount) \("country".localized)"
            case .one(countriesTreesCount),
                 .more(countriesTreesCount) where countriesTreesCount > 1:self.topBoardViewAdvice.text = "\("youHave".localized) \(countriesTreesCount) \("treesPlanted".localized) \(countriesTreesCount) \("countries".localized)"
            @unknown default:
                print("unknown")
                
            }
            
            let ggwCounter = Counter.one(ggwTreesCount)
            switch ggwCounter {
            case .one(ggwTreesCount)where ggwTreesCount == 1:self.bottomBoardViewAdvice.text = "\("youHave".localized) \(ggwTreesCount) \("treePlanted".localized) \(ggwTreesCount) \("ggwLabel".localized)"
            case .one(ggwTreesCount),
                 .more(ggwTreesCount) where ggwTreesCount > 1:self.bottomBoardViewAdvice.text = "\("youHave".localized) \(ggwTreesCount) \("treesPlanted".localized) \(ggwTreesCount) \("ggwLabel".localized)"
            @unknown default:
                print("unknown")
            }

        }, onError: { (error) in
//            print("Error: \(String(describing: error.asAFError(orFailWith: error.localizedDescription)))")
//            print("Errorcode: \(String(describing: error.asAFError?.responseCode))")
            self.showSimpleAlert(title: "Dashboard", message: error.localizedDescription.description, action: false)
        }, onCompleted: {
            print("completed")
        }) {
            print("Disposed")
        }.disposed(by: disposeBag)
//
    }



    func initiateTapGestures(view:UIView, action:Selector?){
        let singleTap = UITapGestureRecognizer(target: view, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
     }
    @objc func tapDetectedForProfile(_ sender : UITapGestureRecognizer){
        print("profile setting")

        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "profilestory") as! UIViewController

        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @objc func tapToMoveToNext(_ sender : UITapGestureRecognizer){
        self.performSegue(withIdentifier: "toWhereToPlantScene", sender: loggedInPerson)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WhereToPlantViewController, let theUser = sender as? User{
            //
            vc.user = theUser
            print("userinprepare \(theUser)")
        }
        else if let vc = segue.destination as? LoginViewController, let logoutButton = sender as? UIBarButtonItem{
     
              print("going")
        }
        
    }

    
    
    func timeMonitor(name:String, hour:Int){
          print("hour \(hour)")

        
        let timeOfTheDay = timer(time: .morning(hour), name:name) ?? timer(time: .afternoon(hour), name:name) ?? timer(time: .evening(hour), name:name)
        
        greetingLabel.text = timeOfTheDay ?? "howdy".localized

    }
    
    func timer(time:TimeOfTheDay, name:String) -> String?{
        switch time {
        case .morning(hour) where hour < 12:
            return "\("morning".localized), \(name)"
            
        case .afternoon(hour) where hour < 15:
            return "\("afternoon".localized), \(name)"
           
        case .evening(hour) where hour > 15:
            return "\("evening".localized), \(name)"
           
        default:
            return nil
            
        }
    }
 
    
    private func addViews(){
        view.addSubview(self.scroller)
        scroller.edgesToSuperview()
        scroller.addSubview(self.container)
        customAddToSubView(parent:self.container, views: circleView, topBoardView, bottomBoardView, greetingLabel, statementLabel, buttonView)
        circleView.addSubview(profileIcon)
        customAddToSubView(parent: topBoardView, views: topBoardViewImage, countryLabel, countryCountLabel, topBoardViewAdvice)
        customAddToSubView(parent: bottomBoardView, views: bottomBoardViewImage, ggwLabel, ggwCountLabel, bottomBoardViewAdvice)
        
        customAddToSubView(parent: buttonView, views: pointingHandImage, reserveATreeLabel)

    }
    
    private func setViewConstraints() {

        circleView.top(to: self.container, offset: viewHeight/90, isActive: true)
        circleView.right(to: self.container, offset: -20, isActive: true)
        profileIcon.size(CGSize(width: 30, height: 30))
        profileIcon.contentMode = .scaleAspectFit
        profileIcon.center(in: circleView)
        
        boardContainerViews(view: topBoardView, centerAnchorView: container, topAnchorView: circleView, offset: 60)
        boardContainerViews(view: bottomBoardView, centerAnchorView: container, topAnchorView: topBoardView, offset: viewHeight/7)
        setBoardsConstraint(parent: topBoardView, image: topBoardViewImage, header: countryLabel, number: countryCountLabel, advice: topBoardViewAdvice)
        setBoardsConstraint(parent: bottomBoardView, image: bottomBoardViewImage, header: ggwLabel, number: ggwCountLabel, advice: bottomBoardViewAdvice)
        
        topBoardViewAdvice.right(to: topBoardView, offset:-10, isActive: true)
        
        bottomBoardViewAdvice.right(to: topBoardView, offset:-10, isActive: true)
        
        
        greetingLabel.top(to: self.container, offset: viewHeight/2.5 + 10, isActive: true)
        greetingLabel.left(to: self.container, offset: 20, isActive: true)
        
        statementLabel.top(to: greetingLabel, offset: 30, isActive: true)
        statementLabel.left(to: self.container, offset: 20, isActive: true)
        statementLabel.right(to: self.container, offset: -20, isActive: true)
        statementLabel.numberOfLines = 0
        statementLabel.textAlignment = .left
        
        buttonView.bottom(to: container, offset: -viewHeight/3.5, isActive: true)
        buttonView.left(to: container, offset: 78, isActive: true)
        buttonView.right(to: container, offset: -78, isActive: true)
        
        pointingHandImage.height(viewHeight/17)
        pointingHandImage.left(to: buttonView, offset: 10, isActive: true)
        pointingHandImage.centerY(to: buttonView)
        
        reserveATreeLabel.left(to: pointingHandImage, offset: pointingHandImage.frame.width/7, isActive: true)
        reserveATreeLabel.centerY(to: buttonView)
        
       
        
        
    }
    
    
    private func setCornerRadius(){
        
        circleView.layer.cornerRadius = 25
        
        topBoardView.layer.cornerRadius = 25
        bottomBoardView.layer.cornerRadius = 25
        buttonView.layer.cornerRadius = viewHeight/30
    }
    
    private func boardContainerViews(view:UIView, centerAnchorView:UIView, topAnchorView:UIView, offset:CGFloat){
        view.centerX(to: centerAnchorView)
        view.top(to: topAnchorView, offset: offset, isActive: true)
        view.right(to: self.container, offset: -20, isActive: true)
        view.left(to: self.container, offset: 20, isActive: true)
    }
    
    private func setBoardsConstraint(parent:UIView, image:UIImageView, header:UILabel, number:UILabel, advice:UILabel){
        
        
        image.size(CGSize(width: viewHeight/14, height: viewHeight/14))
        image.left(to: parent, offset: 10, isActive: true)
        image.centerY(to: parent)
        header.top(to: parent, offset: 10, isActive: true)
        header.left(to: image, offset: 70, isActive: true)
        number.left(to: image, offset: 70, isActive: true)
        number.top(to: header, offset: 15, isActive: true)
        advice.numberOfLines = 0
        advice.textAlignment = .left
        advice.left(to: number, offset: 45, isActive: true)
        advice.top(to: header, offset: 20, isActive: true)
        
    }
}
