//
//  WhatTypeOfTree.swift
//  myrootsinafrica
//
//  Created by Darot on 22/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import SwiftyJSON
import CoreData

class WhatTypeOfTreeViewController : UIViewController{
    
    @IBOutlet weak var submitButton: SecondaryButton!
    @IBOutlet weak var progressSpinner: UIActivityIndicatorView!
    @IBOutlet weak var environmentalSelectorCard: UIView!
    @IBOutlet weak var fruitSelectorCard: UIView!
    @IBOutlet weak var decorativeSelectorCard: UIView!
    
    let authViewModel = AuthViewModel(authProtocol: AuthService())
    let disposeBag = DisposeBag()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<UserData>.init(entityName: "UserData")
    
    var tree:Tree?
    var treeType = ""
    var decorative = "Decorative tree"
    var fruit = "Fruit tree"
    var environmental = "Environmental tree"
    override func viewDidLoad() {
        print("Tree type")
        print("tree\(String(describing: tree))")
        
        self.setupProgressBar(progress: 1.0)
        tapInitiation(view: decorativeSelectorCard, action: #selector(self.tapDetectedForDecorativeCard))
        tapInitiation(view: fruitSelectorCard, action: #selector(self.tapDetectedForFruitCard))
        tapInitiation(view: environmentalSelectorCard, action: #selector(self.tapDetectedForEnvironmentalCard))
     
        
    }
    
    @objc func tapDetectedForDecorativeCard(){
        
        if decorativeSelectorCard.showSelectorCard() {
            fruitSelectorCard.unSelectCard()
            environmentalSelectorCard.unSelectCard()
            treeType = decorative
            
        }
    }
    
    @objc func tapDetectedForFruitCard(){
        if fruitSelectorCard.showSelectorCard(){
            decorativeSelectorCard.unSelectCard()
            environmentalSelectorCard.unSelectCard()
            treeType = fruit

        }
        
    }
    
    @objc func tapDetectedForEnvironmentalCard(){
        if environmentalSelectorCard.showSelectorCard(){
            decorativeSelectorCard.unSelectCard()
            fruitSelectorCard.unSelectCard()
            treeType = environmental

        }
        
    }
    
    
    func tapInitiation(view:UIView, action: Selector){
        let singleTap = UITapGestureRecognizer(target: self, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
    }
    @IBAction func submitButton(_ sender: Any) {
        let currentDate = Date()
      
        if treeType == ""{
             self.showToastMessage(message: "Kindly pick a type of tree", font: UIFont(name: "BalooChetan2-Regular", size: 12.0))
            return
        }
        tree?.treeType = treeType
        tree?.date = "\(currentDate)"
        tree?.new = true
//        self.performSegue(withIdentifier: "toWhatTypeOfTreeScene", sender: tree)
        print("date \(currentDate)")
        print("treepost \(tree)")
        
        reserveTree()
    }
    
    func reserveTree(){
        progressSpinner.isHidden = false
        submitButton.isHidden = true
        var title = "Tree reservation"
        
        guard let newTree = tree else {
            fatalError("Invalid tree reservation parameters")
        }
        guard let token = tree?.token else {
            fatalError("Invalid authorization")
        }
        authViewModel.reserveTree(tree: newTree, token:token).subscribe(onNext: { (AuthResponse) in
            print("messaage \(String(describing: AuthResponse.message))")
            self.progressSpinner.isHidden = true
            self.submitButton.isHidden = false
            if AuthResponse.status == 200 {
                
                print("treeftok \( token )")
                self.showSimpleAlert(title: title, message: AuthResponse.message!, identifier: "toSuccessScene", action: true, tree: self.tree)
                //                self.performSegue(withIdentifier: "gotoVerification", sender: self.tokens)
            }
            else{
                print(AuthResponse.error ?? "error")
                self.showSimpleAlert(title: title, message: AuthResponse.error ?? "error", action: false)
            }
            
        }, onError: { (Error) in
            self.progressSpinner.isHidden = true
            self.submitButton.isHidden = false
            print("Error: \(String(describing: Error.asAFError))")
            print("Errorcode: \(String(describing: Error.asAFError?.responseCode))")
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        }).disposed(by: disposeBag)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let vc = segue.destination as? VerificationResultViewController, let tree = sender as? Tree{
             //
             vc.tree = tree
             print("treeinprepare \(tree)")
         }
         
     }
}
