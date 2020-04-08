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


class DashBoardViewController : ViewController{
    
    @IBOutlet weak var parentScrollView: UIScrollView!
//    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var reserveTreeTap: UIView!
//    @IBOutlet weak var topBoardView: UIView!
    @IBOutlet weak var countryBigCount: UILabel!
    @IBOutlet weak var ggwBigCount: UILabel!
    @IBOutlet weak var countriesTreesDetailLabel: UILabel!
    @IBOutlet weak var ggwTreesDetailsLabel: UILabel!
//    @IBOutlet weak var bottomBoardView: UIView!
    var tokens = ""
    var user:User?
    var userData:UserData?
    lazy var viewHeight = containerView.frame.height
    lazy var circleView = self.createCustomView(with: .white, height: 50, width: 50)
    lazy var profileIcon = self.createImageView(with: #imageLiteral(resourceName: "profileicon"))
    
    lazy var topBoardView = self.createCustomView(with: .white, height: viewHeight/8, width: 0)
    lazy var topBoardViewImage = self.createImageView(with: #imageLiteral(resourceName: "topboardLeaf"))
    lazy var countryLabel = self.createUIlabelBold(with: NSLocalizedString("countryLabel", comment: "54 countries"), and: 16.0, color: #colorLiteral(red: 0.7607843137, green: 0.862745098, blue: 0, alpha: 1))
    lazy var countryCountLabel = self.createUIlabelBold(with: NSLocalizedString("number", comment: "tree count"), and: viewHeight/18, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    lazy var topBoardViewAdvice = self.createUIlabel(with: NSLocalizedString("topBoardAdvice", comment: "transaction update"), and: 14, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    
    lazy var bottomBoardView = self.createCustomView(with: .white, height: viewHeight/8, width: 0)
    lazy var bottomBoardViewImage = self.createImageView(with: #imageLiteral(resourceName: "bottomboardLeaf"))
    lazy var ggwLabel = self.createUIlabelBold(with: NSLocalizedString("ggwLabel", comment: "Great green wall"), and: 16.0, color: #colorLiteral(red: 0.7607843137, green: 0.862745098, blue: 0, alpha: 1))
    lazy var ggwCountLabel = self.createUIlabelBold(with: NSLocalizedString("number", comment: "tree count"), and: viewHeight/18, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    lazy var bottomBoardViewAdvice = self.createUIlabel(with: NSLocalizedString("bottomBoardAdvice", comment: "transaction update"), and: 14, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
   
    var tree:Tree?
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<UserData>(entityName: "UserData")
    
    let authViewModel = AuthViewModel(authProtocol: AuthService())
    var disposeBag = DisposeBag()
    var loggedInUser:UserData?
    override func viewDidLoad() {
        
        print("We are here dashy")
        print("userLoggedIn \(user)")
        print("userTree \(tree)")
        
       
//
//        self.setBackgroundImage("dashboardBackground", contentMode: .scaleAspectFill)
        
//        backgroundImageView.image = UIImage(named: "dashboardBackground")
        
        circleView.layer.cornerRadius = 25
        
        topBoardView.layer.cornerRadius = 25
        bottomBoardView.layer.cornerRadius = 25
//
//        self.navigationItem.setHidesBackButton(true, animated: true)
//        circleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDetectedForProfile(_ :))))
//
//        reserveTreeTap.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToMoveToNext(_ :))))
        
        
        view.layer.contents = #imageLiteral(resourceName: "dashboardBackground").cgImage
        addViews()
        setViewConstraints()
     
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        loggedInUser = HelperClass.getUserData()
//        HelperClass.updateValue(key: "loggedIn", value: true)
//
//        print("Userdata \(loggedInUser)")
//        ((loggedInUser?.name) != nil) ? timeMonitor(name:loggedInUser!.name!):timeMonitor(name:"Sir/Ma")
//
//
//        let token = ((loggedInUser) != nil) ? loggedInUser?.token : "token"
//
//
//        authViewModel.getUserTrees(token: token!).subscribe(onNext: { (TreeResponse) in
//            guard let countriesTreesCount = TreeResponse.payload?.countries.count else{
//                fatalError("Invalid tree counts for countries")
//            }
//            guard let ggwTreesCount = TreeResponse.payload?.greenWall.count else{
//                fatalError("Invalid tree counts for ggw")
//            }
//            print("error \(String(describing: TreeResponse.error))")
//            print("message \(String(describing: TreeResponse.message))")
//
//            print("countries \(String(describing: countriesTreesCount))")
//            print("ggw \(String(describing: ggwTreesCount))")
//            self.countryBigCount.text = "\(countriesTreesCount)"
//            self.ggwBigCount.text = "\(ggwTreesCount)"
//
//
//            switch countriesTreesCount {
//            case 0..<2:self.countriesTreesDetailLabel.text = "You have \(countriesTreesCount) tree planted on the \(countriesTreesCount) country in Africa"
//            default:
//                self.countriesTreesDetailLabel.text = "You have \(countriesTreesCount) trees planted on the \(countriesTreesCount) countries in Africa"
//            }
//
//            switch ggwTreesCount {
//            case 0..<2: self.ggwTreesDetailsLabel.text = "You have \(ggwTreesCount) tree planted on the Green Great Wall"
//            default:
//                self.ggwTreesDetailsLabel.text = "You have \(ggwTreesCount) trees planted on the Green Great Wall"
//            }
//
//
//        }, onError: { (error) in
////            print("Error: \(String(describing: error.asAFError(orFailWith: error.localizedDescription)))")
////            print("Errorcode: \(String(describing: error.asAFError?.responseCode))")
//            self.showSimpleAlert(title: self.title!, message: error.localizedDescription.description, action: false)
//        }, onCompleted: {
//            print("completed")
//        }) {
//            print("Disposed")
//        }.disposed(by: disposeBag)
      
    }

    


    func initiateTapGestures(view:UIView, action:Selector?){
        let singleTap = UITapGestureRecognizer(target: view, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
     }
    @objc func tapDetectedForProfile(_ sender : UITapGestureRecognizer){
        print("profile setting")
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "profilestory") as! ViewController
//        let profile = ProfileViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @objc func tapToMoveToNext(_ sender : UITapGestureRecognizer){
        self.performSegue(withIdentifier: "toWhereToPlantScene", sender: loggedInUser)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WhereToPlantViewController, let user = sender as? UserData{
            //
            vc.user = user
            print("userinprepare \(user)")
        }
        else if let vc = segue.destination as? LoginViewController, let logoutButton = sender as? UIBarButtonItem{
     
              print("going")
        }
        
    }

//    @IBAction func logoutAction(_ sender: Any) {
//        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "loginstory") as! ViewController
//        //        let profile = ProfileViewController()
//        self.navigationController?.pushViewController(nextVC, animated: true)
//
//
//    }
    
    func timeMonitor(name:String){

//        let date = Date()
//        let units: Set<Calendar.Component> = [.hour]
//        let comps = Calendar.current.dateComponents(units, from: date)
//        guard let hour = comps.hour else {
//            fatalError("Invalid time format")
//        }
//
//        switch hour {
//            case 0...11:
//                 greetingLabel.text = "Good morning, \(name)"
//            case 12...15:
//                 greetingLabel.text = "Good Afternoon, \(name)"
//            case 16..<24:
//                greetingLabel.text = "Good Evening, \(name)"
//            default:
//                greetingLabel.text = "Howdy, \(name)!"
//        }

    }
    
//    
    override func viewWillDisappear(_ animated: Bool) {
                
//        navigationController?.removeViewController(DashBoardViewController.self)
        
//        if let navVCsCount = navigationController?.viewControllers.count {
//            navigationController?.viewControllers.removeSubrange(navVCsCount-3..<navVCsCount-1)
//        }
  
    }
 
    
    func setLoggedInUser()->UserData{
        
        do{
            let result = try self.context.fetch(fetchRequest)
            if result.count > 0{
                userData = result[0]
                let data = result[0]
                data.setValue(true, forKey: "loggedIn")
                print("userLogIn1Dash \(String(describing: data.loggedIn))")
            }
            do{
                try self.context.save()
                print("dashBoardSaved")
            }catch{
                print("Error updating entity")
            }

        }catch{
            print(error)
        }

        return userData!
    }
    
    internal func addViews(){
        view.addSubview(self.scrollView)
        scrollView.edgesToSuperview()
        scrollView.addSubview(self.containerView)
        customAddToSubView(parent:self.containerView, views: circleView, topBoardView, bottomBoardView)
        circleView.addSubview(profileIcon)
        customAddToSubView(parent: topBoardView, views: topBoardViewImage, countryLabel, countryCountLabel, topBoardViewAdvice)
        customAddToSubView(parent: bottomBoardView, views: bottomBoardViewImage, ggwLabel, ggwCountLabel, bottomBoardViewAdvice)

    }
    
    private func setViewConstraints() {

        circleView.top(to: self.containerView, offset: viewHeight/12, isActive: true)
        circleView.right(to: self.containerView, offset: -20, isActive: true)
        profileIcon.size(CGSize(width: 30, height: 30))
        profileIcon.contentMode = .scaleAspectFit
        profileIcon.center(in: circleView)
        
        boardContainerViews(view: topBoardView, centerAnchorView: containerView, topAnchorView: circleView, offset: 60)
        boardContainerViews(view: bottomBoardView, centerAnchorView: containerView, topAnchorView: topBoardView, offset: viewHeight/7)
        setBoardsConstraint(parent: topBoardView, image: topBoardViewImage, header: countryLabel, number: countryCountLabel, advice: topBoardViewAdvice)
        setBoardsConstraint(parent: bottomBoardView, image: bottomBoardViewImage, header: ggwLabel, number: ggwCountLabel, advice: bottomBoardViewAdvice)
        
        
    }
    
    
    private func boardContainerViews(view:UIView, centerAnchorView:UIView, topAnchorView:UIView, offset:CGFloat){
        view.centerX(to: centerAnchorView)
        view.top(to: topAnchorView, offset: offset, isActive: true)
    }
    
    private func setBoardsConstraint(parent:UIView, image:UIImageView, header:UILabel, number:UILabel, advice:UILabel){
        
        parent.right(to: self.containerView, offset: -20, isActive: true)
        parent.left(to: self.containerView, offset: 20, isActive: true)
        
        image.size(CGSize(width: viewHeight/14, height: viewHeight/14))
        image.left(to: parent, offset: 10, isActive: true)
        image.centerY(to: parent)
        header.top(to: parent, offset: 10, isActive: true)
        header.left(to: image, offset: 70, isActive: true)
        number.left(to: image, offset: 70, isActive: true)
        number.top(to: header, offset: 15, isActive: true)
        advice.numberOfLines = 0
        advice.textAlignment = .left
        advice.left(to: number, offset: 35, isActive: true)
        advice.top(to: header, offset: 20, isActive: true)
        
    }
}
