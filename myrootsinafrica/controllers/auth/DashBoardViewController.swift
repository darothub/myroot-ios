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


class DashBoardViewController : ViewController{
    
    @IBOutlet weak var parentScrollView: UIScrollView!
    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var reserveTreeTap: UIView!
    @IBOutlet weak var topBoardView: UIView!
    @IBOutlet weak var bottomBoardView: UIView!
    var tokens = ""
    var user:User?
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var userList:[UserData] = []
    let fetchRequest = NSFetchRequest<UserData>(entityName: "UserData")
    override func viewDidLoad() {
        
        print("We are here dashy")
        print("userLoggedIn \(user)")
       
//
//        self.setBackgroundImage("dashboardBackground", contentMode: .scaleAspectFill)
        
        backgroundImageView.image = UIImage(named: "dashboardBackground")
        
        circleView.layer.cornerRadius = circleView.frame.width/2
        topBoardView.layer.cornerRadius = 25
        bottomBoardView.layer.cornerRadius = 25
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        circleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDetectedForProfile(_ :))))
        
        reserveTreeTap.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToMoveToNext(_ :))))

        guard let loggedInUser = user else{
            fatalError("Unknown user")
        }
        
        timeMonitor(name:loggedInUser.name ?? "Sir/Ma")
        
        setLoggedInUser(loggedInUser: loggedInUser)
        
     
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
        self.performSegue(withIdentifier: "toWhereToPlantScene", sender: user)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WhereToPlantViewController, let user = sender as? User{
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
                
//        navigationController?.removeViewController(DashBoardViewController.self)
        
//        if let navVCsCount = navigationController?.viewControllers.count {
//            navigationController?.viewControllers.removeSubrange(navVCsCount-3..<navVCsCount-1)
//        }
  
    }
    
    func setLoggedInUser(loggedInUser:User){
        do{
            let result = try self.context.fetch(fetchRequest)
            let data = result[0]
            data.setValue(true, forKey: "loggedIn")
            data.setValue(loggedInUser.name, forKey: "name")
            data.setValue(loggedInUser.email, forKey: "email")
            data.setValue(loggedInUser.password, forKey: "password")
            data.setValue(loggedInUser.country, forKey: "country")
            data.setValue(loggedInUser.phone, forKey: "phone")
            data.setValue(loggedInUser.token, forKey: "token")
            data.setValue(false, forKey: "newTree")
            print("userLoggedInonDash \(String(describing: data.loggedIn))")
            print("userEmailOnDashBoard \(String(describing: data.email))")
            do{
                try context.save()
                print("dashBoardSaved")
            }catch{
                print("Error updating entity")
            }
            print("dashboardUserLoggedIn \(String(describing: data.loggedIn))")
            
        }catch{
            print(error)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

    }
}
