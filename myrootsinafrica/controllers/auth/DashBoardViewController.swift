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
    
    @IBOutlet weak var parentScrollView: UIScrollView!
    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var reserveTreeTap: UIView!
    @IBOutlet weak var topBoardView: UIView!
    @IBOutlet weak var countryBigCount: UILabel!
    @IBOutlet weak var ggwBigCount: UILabel!
    @IBOutlet weak var countriesTreesDetailLabel: UILabel!
    @IBOutlet weak var ggwTreesDetailsLabel: UILabel!
    @IBOutlet weak var bottomBoardView: UIView!
    var tokens = ""
    var user:User?

   
    var tree:Tree?
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<UserData>(entityName: "UserData")
    
    let authViewModel = AuthViewModel(authProtocol: AuthService())
    var disposeBag = DisposeBag()
//    var loggedInUser:UserData?
    var loggedInPerson:Results<User>?
    let realm = try! Realm()
    override func viewDidLoad() {
        
        print("We are here dashy")
        print("userLoggedIn \(user)")
        print("userTree \(tree)")
       
//
//        self.setBackgroundImage("dashboardBackground", contentMode: .scaleAspectFill)
        
//        backgroundImageView.image = UIImage(named: "dashboardBackground")
        
        circleView.layer.cornerRadius = circleView.frame.width/2
        topBoardView.layer.cornerRadius = 25
        bottomBoardView.layer.cornerRadius = 25
        reserveTreeTap.layer.cornerRadius = 30
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        circleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDetectedForProfile(_ :))))
        
        reserveTreeTap.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToMoveToNext(_ :))))
        

   
            view.layer.contents = #imageLiteral(resourceName: "dashboardBackground").cgImage
     
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loggedInPerson = {
            realm.objects(User.self).filter("loggedIn = true")
        }()
            
        let name = {
            self.loggedInPerson!.first!.name
        }()
        print("Userdata \(name)")
        ((name) != nil) ? timeMonitor(name:name!):timeMonitor(name:"Sir/Ma")
        
        
        var token: String {
            self.loggedInPerson!.first!.token!
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
            self.countryBigCount.text = "\(countriesTreesCount)"
            self.ggwBigCount.text = "\(ggwTreesCount)"


            switch countriesTreesCount {
            case 0..<2:self.countriesTreesDetailLabel.text = "You have \(countriesTreesCount) tree planted on the \(countriesTreesCount) country in Africa"
            default:
                self.countriesTreesDetailLabel.text = "You have \(countriesTreesCount) trees planted on the \(countriesTreesCount) countries in Africa"
            }

            switch ggwTreesCount {
            case 0..<2: self.ggwTreesDetailsLabel.text = "You have \(ggwTreesCount) tree planted on the Green Great Wall"
            default:
                self.ggwTreesDetailsLabel.text = "You have \(ggwTreesCount) trees planted on the Green Great Wall"
            }


        }, onError: { (error) in
//            print("Error: \(String(describing: error.asAFError(orFailWith: error.localizedDescription)))")
//            print("Errorcode: \(String(describing: error.asAFError?.responseCode))")
            self.showSimpleAlert(title: self.title!, message: error.localizedDescription.description, action: false)
        }, onCompleted: {
            print("completed")
        }) {
            print("Disposed")
        }.disposed(by: disposeBag)
      
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.transparentNavigationBar()
    }


    func initiateTapGestures(view:UIView, action:Selector?){
        let singleTap = UITapGestureRecognizer(target: view, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
     }
    @objc func tapDetectedForProfile(_ sender : UITapGestureRecognizer){
        print("profile setting")
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "profilestory") as! UIViewController
//        let profile = ProfileViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @objc func tapToMoveToNext(_ sender : UITapGestureRecognizer){
        self.performSegue(withIdentifier: "toWhereToPlantScene", sender: loggedInPerson?.first)
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

//    @IBAction func logoutAction(_ sender: Any) {
//        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "loginstory") as! ViewController
//        //        let profile = ProfileViewController()
//        self.navigationController?.pushViewController(nextVC, animated: true)
//
//
//    }
    
    func timeMonitor(name:String){

        let date = Date()
        let units: Set<Calendar.Component> = [.hour]
        let comps = Calendar.current.dateComponents(units, from: date)
        guard let hour = comps.hour else {
            fatalError("Invalid time format")
        }
     
        switch hour {
            case 0...11:
                 greetingLabel.text = "Good morning, \(name)"
            case 12...15:
                 greetingLabel.text = "Good Afternoon, \(name)"
            case 16..<24:
                greetingLabel.text = "Good Evening, \(name)"
            default:
                greetingLabel.text = "Howdy, \(name)!"
        }

    }
    
//    
    override func viewWillDisappear(_ animated: Bool) {
                
  
    }
 
    
    
    
}
