//
//  ControllerBackgroundImage.swift
//  myrootsinafrica
//
//  Created by Darot on 18/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension ViewController {
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

}
