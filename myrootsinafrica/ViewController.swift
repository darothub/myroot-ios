//
//  ViewController.swift
//  myrootsinafrica
//
//  Created by Darot on 12/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import TinyConstraints

class ViewController: UIViewController {
    
    
   
    //    @IBOutlet weak var worldText: UILabel!
//    @IBOutlet weak var myRootHeaderLabel: UIImageView!
//    @IBOutlet weak var signUpbtn: SecondaryButton!
//
//    @IBOutlet weak var loginButton: PrimaryButton!
//
//    @IBOutlet weak var parentViewWrapper: UIView!
    
    //    @IBOutlet weak var SubParentView: UIView!
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    lazy var imageView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "homeBackground")
        view.frame.size = contentViewSize
        return view
    }()
    lazy var image = UIImage(named: "homeBackground")
    lazy var scrollView:UIView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .clear
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsVerticalScrollIndicator = false
        view.frame = self.view.bounds
        return view
      }()
    lazy var containerView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        view.withBackground(image: #imageLiteral(resourceName: "homeBackground"), contentMode: .scaleToFill)
        return view
    }()
    lazy var label:UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        return label
    }()
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(scrollView)
        scrollView.edgesToSuperview()
        scrollView.addSubview(containerView)
        
//        containerView.horizontalToSuperview()
       
//        imageView.bottom(to: containerView)
//        imageView.leadingToSuperview()
//        imageView.trailingToSuperview()
        
//        setupScrollView()
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
        //set view background image
//        view.layer.contents = #imageLiteral(resourceName: "homeBackground").cgImage
//         parentViewWrapper .layer.contents = #imageLiteral(resourceName: "homeBackground").cgImage

      
        
    }
//    @IBAction func showToast(_ sender: Any) {
//        let font = UIFont(name: "BalooChettan2-Regular", size: 14.0) ?? UIFont(name: "Helvetica", size: 14.0)
//        self.showToastMessage(message: "Hello", font: font!)
//    }
//
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? SignupController{
//
//            vc.testText = "Arthur Dent"
//        }
//    }
////
//    @IBAction func unWindtoHome(unwindSegue: UIStoryboardSegue){}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


