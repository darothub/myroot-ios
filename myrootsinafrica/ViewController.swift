//
//  ViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 12/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import TinyConstraints

class ViewController: UIViewController {


    lazy var container = self.createView(with: .clear)
    lazy var subHeading = self.createUIlabel(with: NSLocalizedString("homeSceneSubText1", comment: "I can literarily..."), and: 20.0)
    lazy var headerText = self.createUIlabel(with: NSLocalizedString("homeSceneHeaderText", comment: "World..."), and: 18.0)
    lazy var loginButton = self.createButton(with: NSLocalizedString("login", comment: "login"), and: #colorLiteral(red: 0.7607843137, green: 0.862745098, blue: 0, alpha: 1), action: #selector(toLoginScreen))
    lazy var signupButton = self.createButton(with: NSLocalizedString("signup", comment: "signup"), and: #colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1), action: #selector(toSignupScene))
    lazy var scroller = self.createScrollView()
    lazy var logo = self.createImageView(with: #imageLiteral(resourceName: "my_roots_logo"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addViews()
        setViewConstraints()
        
        view.layer.contents = #imageLiteral(resourceName: "homeBackground").cgImage
        
        let size = container.frame.height
        
        print("size \(size)")
        
        self.transparentNavBar()

       self.navigationItem.leftBarButtonItem = UIBarButtonItem()

        
    }
    
    
    private func addViews(){
       
        view.addSubview(scroller)
        scroller.edgesToSuperview()
        scroller.addSubview(self.container)
        scroller.addSubview(subHeading)
        self.container.addSubview(headerText)
        self.container.addSubview(logo)
        self.container.addSubview(signupButton)
        self.container.addSubview(loginButton)
 
        
    }
    
    private func setViewConstraints(){
        headerText.top(to: self.container, offset: 50, isActive: true)
        headerText.centerX(to: container)
        logo.top(to: headerText, offset: 70,  isActive: true)
        logo.centerX(to: container)
        subHeading.centerX(to: container)
        subHeading.top(to: logo, offset: 95, isActive: true)
        signupButton.center(in: container)
        signupButton.left(to: container, offset: 50, isActive: true)
        signupButton.right(to: container, offset: -50, isActive: true)
        loginButton.centerX(to: container)
        loginButton.top(to: signupButton, offset: 65, isActive: true)
        loginButton.left(to: container, offset: 50, isActive: true)
        loginButton.right(to: container, offset: -50, isActive: true)
    }
    @objc func toLoginScreen(){
        
        self.performSegue(withIdentifier: "toLoginScene", sender: self)
    }
  
    @objc func toSignupScene(){
        self.performSegue(withIdentifier: "toSignupScene", sender: self)
    }
}


