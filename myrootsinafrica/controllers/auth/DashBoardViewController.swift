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
    var userData:UserData?
   
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
        
        backgroundImageView.image = UIImage(named: "dashboardBackground")
        
        circleView.layer.cornerRadius = circleView.frame.width/2
        topBoardView.layer.cornerRadius = 25
        bottomBoardView.layer.cornerRadius = 25
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        circleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDetectedForProfile(_ :))))
        
        reserveTreeTap.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToMoveToNext(_ :))))
        
        
        loggedInUser = HelperClass.getUserData()
        let result = HelperClass.updateValue(key: "loggedIn", value: true)
            
        timeMonitor(name:loggedInUser!.name!)
        
        
        print("Userdata \(loggedInUser)")
        print("resultData \(result)")
        
        authViewModel.getUserTrees(token: (loggedInUser?.token!)!).subscribe(onNext: { (TreeResponse) in
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
            
            
        }, onError: { (Error) in
            print("Error: \(String(describing: Error.asAFError))")
            print("Errorcode: \(String(describing: Error.asAFError?.responseCode))")
        }, onCompleted: {
            print("completed")
        }) {
            print("Disposed")
        }.disposed(by: disposeBag)
        
        
     
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }

    


    func initiateTapGestures(view:UIView, action:Selector?){
        let singleTap = UITapGestureRecognizer(target: view, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
     }
    @objc func tapDetectedForProfile(_ sender : UITapGestureRecognizer){
        print("profile setting")
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "profilestory") as! ViewController
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
//    func setLoggedInUser()->UserData{
//        
//        do{
//            let result = try self.context.fetch(fetchRequest)
//            if result.count > 0{
//                userData = result[0]
//                let data = result[0]
//                data.setValue(true, forKey: "loggedIn")
//                print("userLogIn1Dash \(String(describing: data.loggedIn))")
//            }
//            do{
//                try self.context.save()
//                print("dashBoardSaved")
//            }catch{
//                print("Error updating entity")
//            }
//            
//        }catch{
//            print(error)
//        }
//
//        return userData!
//    }
    
    
}
