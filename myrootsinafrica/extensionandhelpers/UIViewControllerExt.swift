//
//  ControllerBackgroundImage.swift
//  myrootsinafrica
//
//  Created by Darot on 18/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension UIViewController {
    func setBackgroundImage(_ imageName: String, contentMode: UIView.ContentMode) {
        let backgroundImage = UIImageView(frame: self.view.bounds)
        backgroundImage.image = UIImage(named: imageName)
        backgroundImage.contentMode = contentMode
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func setupProgressBar(progress:Float){
        let progressBarView = UIProgressView()
        
    
        progressBarView.translatesAutoresizingMaskIntoConstraints = false
        progressBarView.progressViewStyle = UIProgressView.Style.bar
        
        progressBarView.progressTintColor = #colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1)
        progressBarView.trackTintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        
        progressBarView.setProgress(progress, animated: true)
        
        progressBarView.heightAnchor.constraint(equalToConstant: CGFloat(4
        )).isActive = true
        progressBarView.widthAnchor.constraint(equalToConstant: CGFloat(290
        )).isActive = true
    
        
        navigationItem.titleView = progressBarView
        
        
//        C2DC00
//        7AC840
    }
    func setupProgressBarXclusive(progress:Float, progressTintcolor:UIColor, trackTintColor:UIColor){
            let progressBarView = UIProgressView()
            
        
            progressBarView.translatesAutoresizingMaskIntoConstraints = false
            progressBarView.progressViewStyle = UIProgressView.Style.bar
//            #colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1)

            progressBarView.progressTintColor = progressTintcolor
            progressBarView.trackTintColor = trackTintColor
            
            progressBarView.setProgress(progress, animated: true)
            
            progressBarView.heightAnchor.constraint(equalToConstant: CGFloat(4
            )).isActive = true
            progressBarView.widthAnchor.constraint(equalToConstant: CGFloat(290
            )).isActive = true
        
            
            navigationItem.titleView = progressBarView
            
            
    //        C2DC00
    //        7AC840
        }
    
    func showSimpleAlert(title:String, message:String, identifier:String?=nil, action:Bool?=false, user:User?=nil, tree:Tree?=nil) {
        let alert = UIAlertController(title: title, message:message,preferredStyle: UIAlertController.Style.alert)
        
        //        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
        //            //Cancel Action
        //        }))
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
                                        let identifiedString = identifier ?? ""
                                        if action == true && !(user == nil){
                                            
                                            print("okIdentify \(identifiedString)")
                                            self.performSegue(withIdentifier: identifiedString, sender: user)
                                        }
                                        else if action == true && !(tree == nil){
                                            
                                            print("okIdentify \(identifiedString)")
                                            self.performSegue(withIdentifier: identifiedString, sender: tree)
                                            
                                        }
                                        else if action == true && (user == nil){
                                            
                                            print("okIdentify \(identifiedString)")
                                            self.performSegue(withIdentifier: identifiedString, sender: self)
                                        }
                                    
                                        
                                                                              
                                        
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func transparentNavBar(){
      
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
     }
    
    func moveToDestination(with identifier:String){
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: identifier) as! UIViewController
          self.navigationController?.pushViewController(nextVC, animated: true)
      }


    func addCustomBackButton(action:Selector, color:UIColor=#colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1)){
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "backicon"), for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.tintColor = color
        
        backButton.addTarget(self, action: action, for: .touchUpInside)
      }
    func addCustomRightBackButton(image:UIImage?, title:String?, action:Selector){
        let backButton = UIButton(type: .system)
        if image != nil{
             backButton.setImage(image, for: .normal)
        }else{
           backButton.setTitle("logout".localized, for: .normal)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.tintColor = .white
        backButton.addTarget(self, action: action, for: .touchUpInside)
      }
    @objc func gotoScene(){
        self.moveToDestination(with: "homeScene")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
}
