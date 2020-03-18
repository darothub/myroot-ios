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

}
