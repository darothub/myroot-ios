//
//  ControllerBackgroundImage.swift
//  myrootsinafrica
//
//  Created by Darot on 18/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension UIViewController {

    /// This function sets an image as the background of the view controller
    ///
    /// - Parameters:
    ///   - imageName: name of image
    ///   - contentMode:
    ///          .scaleAspectFill
    ///          .scaleAspectFit
    ///          .scaleToFill
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

}
